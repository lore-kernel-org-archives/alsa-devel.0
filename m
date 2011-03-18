From: sudarshan.bisht@nokia.com
Subject: [PATCH] alsa-lib: fixed coverity reported issues under
	"RESOURCE_LEAK" checker.
Date: Fri, 18 Mar 2011 10:24:20 +0200
Message-ID: <1300436660-12981-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9076924435
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 09:26:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Sudarshan <sudarshan.bisht@nokia.com>

---
 modules/mixer/simple/sbase.c   |    1 +
 modules/mixer/simple/sbasedl.c |    2 +-
 src/conf.c                     |    4 ++++
 src/control/control_hw.c       |    4 +++-
 src/pcm/pcm_file.c             |    4 +++-
 src/pcm/pcm_ladspa.c           |   20 ++++++++++++++------
 src/pcm/pcm_plug.c             |    9 +++++++--
 src/pcm/pcm_rate.c             |    4 ++++
 src/rawmidi/rawmidi.c          |    4 +++-
 9 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/modules/mixer/simple/sbase.c b/modules/mixer/simple/sbase.c
index 97feee8..bb2f59d 100644
--- a/modules/mixer/simple/sbase.c
+++ b/modules/mixer/simple/sbase.c
@@ -377,6 +377,7 @@ static int simple_event_add1(snd_mixer_class_t *class,
 		if (ctype != SND_CTL_ELEM_TYPE_BOOLEAN) {
 		      __invalid_type:
 		      	snd_mixer_selem_id_free(id);
+			free(hsimple);
 			return -EINVAL;
 		}
 		break;
diff --git a/modules/mixer/simple/sbasedl.c b/modules/mixer/simple/sbasedl.c
index 0137586..494802f 100644
--- a/modules/mixer/simple/sbasedl.c
+++ b/modules/mixer/simple/sbasedl.c
@@ -99,7 +99,7 @@ int mixer_simple_basic_dlopen(snd_mixer_class_t *class,
       __error:
       	if (initflag)
       		free(priv);
-	if (h == NULL)
+	if (h)
 		snd_dlclose(h);
 	free(xlib);
 	return -ENXIO;
diff --git a/src/conf.c b/src/conf.c
index 8939d62..c4daae7 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -638,6 +638,7 @@ static int get_char_skip_comments(input_t *input)
 			fd = malloc(sizeof(*fd));
 			if (!fd) {
 				free(str);
+				snd_input_close(in);
 				return -ENOMEM;
 			}
 			fd->name = str;
@@ -1847,6 +1848,7 @@ int snd_config_delete(snd_config_t *config)
 		list_del(&config->list);
 	free(config->id);
 	free(config);
+	config = NULL;	  	
 	return 0;
 }
 
@@ -4589,6 +4591,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
 		if (err < 0) {
 		_err:
 			free(val);
+			if (sub)
+				snd_config_delete(sub);
 			return err;
 		}
 		free(val);
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index cf258b4..29cbbc6 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -230,8 +230,10 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
 		return -errno;
 	}
 	if (op_flag == 0) {
-		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size)
+		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
+			free(xtlv);
 			return -EFAULT;
+		}
 		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
 	}
 	free(xtlv);
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index bfa1cc8..adba7c0 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -226,7 +226,9 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
 					file->final_fname);
 			return -errno;
 		}
-		fd = fileno(pipe);
+		fd = dup(fileno(pipe));
+		if (fd >= 0)
+			fclose(pipe);
 	} else {
 		if (file->trunc)
 			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_TRUNC,
diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index c413c10..41e1d38 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -750,8 +750,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                         if (instance->input.data == NULL ||
                             instance->input.m_data == NULL ||
                             instance->output.data == NULL ||
-                            instance->output.m_data == NULL)
+                            instance->output.m_data == NULL) {
+				free(pchannels);
                                 return -ENOMEM;
+			}
 			for (idx = 0; idx < instance->input.channels.size; idx++) {
 			        chn = instance->output.channels.array[idx];
 			        if (pchannels[chn] == NULL && chn < ichannels) {
@@ -761,8 +763,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
 			        instance->input.data[idx] = pchannels[chn];
 			        if (instance->input.data[idx] == NULL) {
                                         instance->input.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 0);
-                                        if (instance->input.data[idx] == NULL)
-                                                return -ENOMEM;
+                                        if (instance->input.data[idx] == NULL) {
+                                                free(pchannels);
+						return -ENOMEM;
+					}
                                 }
                         }
                         for (idx = 0; idx < instance->output.channels.size; idx++) {
@@ -770,8 +774,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                                 /* FIXME/OPTIMIZE: check if we can remove double alloc */
                                 /* if LADSPA plugin has no broken inplace */
                                 instance->output.data[idx] = malloc(sizeof(LADSPA_Data) * ladspa->allocated);
-                                if (instance->output.data[idx] == NULL)
-                                        return -ENOMEM;
+                                if (instance->output.data[idx] == NULL) {
+                                 	free(pchannels);
+					return -ENOMEM;
+				}
                                 pchannels[chn] = instance->output.m_data[idx] = instance->output.data[idx];
                         }
 		}
@@ -793,8 +799,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                                                 instance->output.data[idx] = NULL;
                                         } else {
                                                 instance->output.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 1);
-                                                if (instance->output.data[idx] == NULL)
+                                                if (instance->output.data[idx] == NULL) {
+							free(pchannels);	
                                                         return -ENOMEM;
+						}
                                         }
                                 }
                         }
diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index e9d2923..e80bd3e 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -1298,6 +1298,7 @@ int _snd_pcm_plug_open(snd_pcm_t **pcmp, const char *name,
 		err = snd_pcm_route_load_ttable(tt, ttable, csize, ssize, &cused, &sused, -1);
 		if (err < 0) {
 			snd_config_delete(sconf);
+			free(ttable);
 			return err;
 		}
 	}
@@ -1310,12 +1311,16 @@ int _snd_pcm_plug_open(snd_pcm_t **pcmp, const char *name,
 
 	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
 	snd_config_delete(sconf);
-	if (err < 0)
+	if (err < 0) {
+		free(ttable);
 		return err;
+	}
 	err = snd_pcm_plug_open(pcmp, name, sformat, schannels, srate, rate_converter,
 				route_policy, ttable, ssize, cused, sused, spcm, 1);
-	if (err < 0)
+	if (err < 0) {
+		free(ttable);
 		snd_pcm_close(spcm);
+	}
 	return err;
 }
 #ifndef DOC_HIDDEN
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 70e30e5..cf218ae 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1392,11 +1392,13 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	} else {
 		SNDERR("Invalid type for rate converter");
 		snd_pcm_close(pcm);
+		free(rate);
 		return -EINVAL;
 	}
 	if (err < 0) {
 		SNDERR("Cannot find rate converter");
 		snd_pcm_close(pcm);
+		free(rate);
 		return -ENOENT;
 	}
 #else
@@ -1405,6 +1407,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
 	if (err < 0) {
 		snd_pcm_close(pcm);
+		free(rate);
 		return err;
 	}
 #endif
@@ -1413,6 +1416,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	    ! rate->ops.input_frames || ! rate->ops.output_frames) {
 		SNDERR("Inproper rate plugin %s initialization", type);
 		snd_pcm_close(pcm);
+		free(rate);	
 		return err;
 	}
 
diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index b28488a..25732d2 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -255,8 +255,10 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
 		snd_config_delete(type_conf);
 	if (err >= 0)
 		err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
-	if (err < 0)
+	if (err < 0) {
+		snd_dlclose(h);
 		return err;
+	}
 	if (inputp) {
 		(*inputp)->dl_handle = h; h = NULL;
 		snd_rawmidi_params_default(*inputp, &params);
-- 
1.7.0.4
