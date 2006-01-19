From: Nathan Kurz <nate@verse.com>
Subject: ladspa plugins (patch)
Date: Thu, 19 Jan 2006 14:00:43 -0700
Message-ID: <20060119210043.GC19795@first.verse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello ---

I just started trying to use some LADSPA plugins to allow for
pre-processing of input before it is seen by a soft-phone application,
and encountered some problems.  Some plugins would work, and others
would fail with an assertion in snd_pcm_ladspa_allocate: 

pcm.pitchshift {
   type ladspa
   slave.pcm "plughw:0,0"
   path "/usr/local/lib/ladspa"
   plugins [ 
      {
         label pitchScaleHQ
         input { controls [ 2 ] }
      } 
   ]
}

$ arecord -f dat -d 4 -Dplug:pitchshift foo.wav
  Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, 
                             Rate 48000 Hz, Stereo
  pcm_ladspa.c:670: snd_pcm_ladspa_allocate_instances: 
                    Assertion `err  >= 0' failed.

It turned out that plugins that had control outputs were not being set
up properly if there was no corresponding "output" section.  Adding an
output section (even if entirely empty) solved this problem:

pcm.pitchshift {
   type ladspa
   slave.pcm "plughw:0,0"
   path "/usr/local/lib/ladspa"
   plugins [
      {
         label pitchScaleHQ
         input { controls [ 2 ] }
         output { }
      }
   ]
}

This behavior seemed to be somewhere between buggy and undocumented,
so I wrote a patch that causes the proper controls to be set up even
for both input and output even if the ioconfig section is omitted.  I
think this is significantly better than the current behavior, which is
to perform differently with an empty ioconfig than with an absent one:

pcm.pitchshift {
   type ladspa
   slave.pcm "plughw:0,0"
   path "/usr/local/lib/ladspa"
   plugins [
      {
         # input {} optional if defaults are used
         label pitchScaleHQ
      }
   ]
}

The attached patch looks more complicated than it actually is.  What
it does is to split snd_pcm_ladspa_parse_ioconfig() into pieces so it
calls three simpler functions: snd_pcm_ladspa_add_default_controls(),
snd_pcm_ladspa_parse_controls(), and snd_pcm_ladspa_parse_bindings().
'add_default_controls' is always called, and the other two are called
only if their corresponding section exists.

I haven't tested this patch well, but compiles without error and
appears to be working on my system.  While not perfect, I think the
functions I've created are clearer than what came before.  I tried to
follow the established coding patterns, and apologize if I haven't
succeeded.  The patch is against alsa-lib-1.0.11rc2.

I hope this is useful enough for inclusion in CVS,

Nathan Kurz
nate@verse.com


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ladspa.patch"

--- src/pcm/pcm_ladspa.c.orig	2006-01-19 09:19:36.000000000 -0700
+++ src/pcm/pcm_ladspa.c	2006-01-19 13:49:32.000000000 -0700
@@ -1205,155 +1205,204 @@
 	return -ENOENT;
 }					  
 
-static int snd_pcm_ladspa_parse_ioconfig(snd_pcm_ladspa_plugin_t *lplug,
+static int snd_pcm_ladspa_add_default_controls(snd_pcm_ladspa_plugin_t *lplug,
+					       snd_pcm_ladspa_plugin_io_t *io) 
+{
+	unsigned int count = 0;
+	LADSPA_Data *array;
+	unsigned char *initialized;
+	unsigned long idx;
+
+	for (idx = 0; idx < lplug->desc->PortCount; idx++)
+		if ((lplug->desc->PortDescriptors[idx] & (io->pdesc | LADSPA_PORT_CONTROL)) == (io->pdesc | LADSPA_PORT_CONTROL))
+			count++;
+	array = (LADSPA_Data *)calloc(count, sizeof(LADSPA_Data));
+	if (!array)
+		return -ENOMEM;
+	initialized = (unsigned char *)calloc(count, sizeof(unsigned char));
+	if (!initialized) {
+		free(array);
+		return -ENOMEM;
+	}
+	io->controls_size = count;
+	io->controls_initialized = initialized;
+	io->controls = array;
+
+	return 0;
+}	
+
+static int snd_pcm_ladspa_parse_controls(snd_pcm_ladspa_plugin_t *lplug,
 					 snd_pcm_ladspa_plugin_io_t *io,
-					 snd_config_t *conf)
+					 snd_config_t *controls) 
 {
 	snd_config_iterator_t i, next;
-	snd_config_t *bindings = NULL, *controls = NULL;
 	int err;
-	
-	if (conf == NULL)
-		return 0;
-	if (snd_config_get_type(conf) != SND_CONFIG_TYPE_COMPOUND) {
-		SNDERR("input or output definition must be a compound");
+
+	if (snd_config_get_type(controls) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("controls definition must be a compound");
 		return -EINVAL;
 	}
-	snd_config_for_each(i, next, conf) {
+
+	snd_config_for_each(i, next, controls) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *id;
+		long lval;
+		unsigned int port, uval;
+		double dval;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "bindings") == 0) {
-			bindings = n;
-			continue;
+		err = safe_strtol(id, &lval);
+		if (err >= 0) {
+			err = snd_pcm_ladspa_find_port(&port, lplug, io->pdesc | LADSPA_PORT_CONTROL, lval);
+		} else {
+			err = snd_pcm_ladspa_find_sport(&port, lplug, io->pdesc | LADSPA_PORT_CONTROL, id);
 		}
-		if (strcmp(id, "controls") == 0) {
-			controls = n;
-			continue;
+		if (err < 0) {
+			SNDERR("Unable to find an control port (%s)", id);
+			return err;
+		}
+		if (snd_config_get_ireal(n, &dval) < 0) {
+			SNDERR("Control port %s has not an float or integer value", id);
+			return err;
 		}
+		err = snd_pcm_ladspa_find_port_idx(&uval, lplug, io->pdesc | LADSPA_PORT_CONTROL, port);
+		if (err < 0) {
+			SNDERR("internal error");
+			return err;
+		}
+		io->controls_initialized[uval] = 1;
+		io->controls[uval] = (LADSPA_Data)dval;
 	}
-	if (bindings) {
-		unsigned int count = 0;
-		unsigned int *array;
-		if (snd_config_get_type(bindings) != SND_CONFIG_TYPE_COMPOUND) {
-			SNDERR("bindings definition must be a compound");
+
+	return 0;
+}
+
+static int snd_pcm_ladspa_parse_bindings(snd_pcm_ladspa_plugin_t *lplug,
+					 snd_pcm_ladspa_plugin_io_t *io,
+					 snd_config_t *bindings) 
+{
+	unsigned int count = 0;
+	unsigned int *array;
+	snd_config_iterator_t i, next;
+	int err;
+
+	if (snd_config_get_type(bindings) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("bindings definition must be a compound");
+		return -EINVAL;
+	}
+	snd_config_for_each(i, next, bindings) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+		long channel;
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		err = safe_strtol(id, &channel);
+		if (err < 0 || channel < 0) {
+			SNDERR("Invalid channel number: %s", id);
 			return -EINVAL;
 		}
+		if (lplug->policy == SND_PCM_LADSPA_POLICY_DUPLICATE && channel > 0) {
+			SNDERR("Wrong channel specification for duplicate policy");
+			return -EINVAL;
+		}
+		if (count < (unsigned int)(channel + 1))
+			count = (unsigned int)(channel + 1);
+	}
+	if (count > 0) {
+		array = (unsigned int *)calloc(count, sizeof(unsigned int));
+		if (! array)
+			return -ENOMEM;
+		memset(array, 0xff, count * sizeof(unsigned int));
+		io->port_bindings_size = count;
+		io->port_bindings = array;
 		snd_config_for_each(i, next, bindings) {
 			snd_config_t *n = snd_config_iterator_entry(i);
-			const char *id;
-			long channel;
+			const char *id, *sport;
+			long channel, port;
 			if (snd_config_get_id(n, &id) < 0)
 				continue;
 			err = safe_strtol(id, &channel);
 			if (err < 0 || channel < 0) {
-				SNDERR("Invalid channel number: %s", id);
-				return -EINVAL;
-			}
-			if (lplug->policy == SND_PCM_LADSPA_POLICY_DUPLICATE && channel > 0) {
-				SNDERR("Wrong channel specification for duplicate policy");
+				assert(0);	/* should never happen */
 				return -EINVAL;
 			}
-			if (count < (unsigned int)(channel + 1))
-				count = (unsigned int)(channel + 1);
-		}
-		if (count > 0) {
-			array = (unsigned int *)calloc(count, sizeof(unsigned int));
-			if (! array)
-				return -ENOMEM;
-			memset(array, 0xff, count * sizeof(unsigned int));
-			io->port_bindings_size = count;
-			io->port_bindings = array;
-			snd_config_for_each(i, next, bindings) {
-				snd_config_t *n = snd_config_iterator_entry(i);
-				const char *id, *sport;
-				long channel, port;
-				if (snd_config_get_id(n, &id) < 0)
-					continue;
-				err = safe_strtol(id, &channel);
-				if (err < 0 || channel < 0) {
-					assert(0);	/* should never happen */
-					return -EINVAL;
-				}
-				err = snd_config_get_integer(n, &port);
-				if (err >= 0) {
-					err = snd_pcm_ladspa_find_port(&array[channel], lplug, io->pdesc | LADSPA_PORT_AUDIO, port);
-					if (err < 0) {
-						SNDERR("Unable to find an audio port (%li) for channel %s", port, id);
-						return err;
-					}
-					continue;
-				}
-				err = snd_config_get_string(n, &sport);
-				if (err < 0) {
-					SNDERR("Invalid LADSPA port field type for %s", id);
-					return -EINVAL;
-				}
-				err = snd_pcm_ladspa_find_sport(&array[channel], lplug, io->pdesc | LADSPA_PORT_AUDIO, sport);
+			err = snd_config_get_integer(n, &port);
+			if (err >= 0) {
+				err = snd_pcm_ladspa_find_port(&array[channel], lplug, io->pdesc | LADSPA_PORT_AUDIO, port);
 				if (err < 0) {
-					SNDERR("Unable to find an audio port (%s) for channel %s", sport, id);
+					SNDERR("Unable to find an audio port (%li) for channel %s", port, id);
 					return err;
 				}
+				continue;
+			}
+			err = snd_config_get_string(n, &sport);
+			if (err < 0) {
+				SNDERR("Invalid LADSPA port field type for %s", id);
+				return -EINVAL;
+			}
+			err = snd_pcm_ladspa_find_sport(&array[channel], lplug, io->pdesc | LADSPA_PORT_AUDIO, sport);
+			if (err < 0) {
+				SNDERR("Unable to find an audio port (%s) for channel %s", sport, id);
+				return err;
 			}
 		}
 	}
-	if (1) {
-		unsigned int count = 0;
-		LADSPA_Data *array;
-		unsigned char *initialized;
-		unsigned long idx;
-		for (idx = 0; idx < lplug->desc->PortCount; idx++)
-			if ((lplug->desc->PortDescriptors[idx] & (io->pdesc | LADSPA_PORT_CONTROL)) == (io->pdesc | LADSPA_PORT_CONTROL))
-				count++;
-		array = (LADSPA_Data *)calloc(count, sizeof(LADSPA_Data));
-		if (!array)
-			return -ENOMEM;
-		initialized = (unsigned char *)calloc(count, sizeof(unsigned char));
-		if (!initialized) {
-		        free(array);
-			return -ENOMEM;
-                }
-		io->controls_size = count;
-		io->controls_initialized = initialized;
-		io->controls = array;
-		if (!(io->pdesc & LADSPA_PORT_OUTPUT)) {
-        		if (snd_config_get_type(controls) != SND_CONFIG_TYPE_COMPOUND) {
-        			SNDERR("controls definition must be a compound");
-        			return -EINVAL;
-        		}
-        		snd_config_for_each(i, next, controls) {
-        			snd_config_t *n = snd_config_iterator_entry(i);
-        			const char *id;
-        			long lval;
-        			unsigned int port, uval;
-        			double dval;
-        			if (snd_config_get_id(n, &id) < 0)
-        				continue;
-        			err = safe_strtol(id, &lval);
-        			if (err >= 0) {
-        				err = snd_pcm_ladspa_find_port(&port, lplug, io->pdesc | LADSPA_PORT_CONTROL, lval);
-        			} else {
-        				err = snd_pcm_ladspa_find_sport(&port, lplug, io->pdesc | LADSPA_PORT_CONTROL, id);
-        			}
-        			if (err < 0) {
-        				SNDERR("Unable to find an control port (%s)", id);
-        				return err;
-        			}
-        			if (snd_config_get_ireal(n, &dval) < 0) {
-        				SNDERR("Control port %s has not an float or integer value", id);
-        				return err;
-        			}
-        			err = snd_pcm_ladspa_find_port_idx(&uval, lplug, io->pdesc | LADSPA_PORT_CONTROL, port);
-        			if (err < 0) {
-        				SNDERR("internal error");
-        				return err;
-        			}
-        			initialized[uval] = 1;
-        			array[uval] = (LADSPA_Data)dval;
-        		}
-                }
+
+	return 0;
+}
+
+static int snd_pcm_ladspa_parse_ioconfig(snd_pcm_ladspa_plugin_t *lplug,
+					 snd_pcm_ladspa_plugin_io_t *io,
+					 snd_config_t *conf)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *bindings = NULL, *controls = NULL;
+	int err;
+
+	/* always add default controls for both input and output */
+	err = snd_pcm_ladspa_add_default_controls(lplug, io);
+	if (err < 0) {
+		SNDERR("error adding default controls");
+		return err;
 	}
+		
+	if (conf == NULL) {
+		return 0;
+	}
+
+	if (snd_config_get_type(conf) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("input or output definition must be a compound");
+		return -EINVAL;
+	}
+	snd_config_for_each(i, next, conf) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		if (strcmp(id, "bindings") == 0) {
+			bindings = n;
+			continue;
+		}
+		if (strcmp(id, "controls") == 0) {
+			controls = n;
+			continue;
+		}
+	}
+
+	/* ignore values of parameters for output controls */
+	if (controls && !(io->pdesc & LADSPA_PORT_OUTPUT)) {
+ 		err = snd_pcm_ladspa_parse_controls(lplug, io, controls);
+		if (err < 0) 
+			return err;
+	}
+
+	if (bindings) {
+ 		err = snd_pcm_ladspa_parse_bindings(lplug, io, bindings);
+		if (err < 0) 
+			return err;
+	}
+
+
 	return 0;
 }
 

--AqsLC8rIMeq19msA--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
