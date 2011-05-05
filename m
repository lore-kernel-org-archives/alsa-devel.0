From: sudarshan.bisht@nokia.com
Subject: [PATCH 2/2] alsa-lib: fixed coverity reported issues
	under "RESOURCE_LEAK" checker.
Date: Thu,  5 May 2011 16:05:29 +0300
Message-ID: <1304600730-24895-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 918CC103813
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 15:05:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Sudarshan Bisht <sudarshan.bisht@nokia.com>

Coverity Static Analysis helps developers find hard-to-spot,
yet potentially crash-causing defects early in the development phase,
reducing the cost,time, and risk of software errors.

This patch has got fixes for potential memory leaks in error cases.

---
 modules/mixer/simple/sbase.c |    1 +
 src/conf.c                   |    2 ++
 src/control/control_hw.c     |    4 +++-
 src/pcm/pcm_file.c           |    6 +++++-
 src/pcm/pcm_ladspa.c         |   22 +++++++++++++++-------
 src/pcm/pcm_plug.c           |    9 +++++++--
 src/pcm/pcm_rate.c           |    4 ++++
 src/rawmidi/rawmidi.c        |    4 +++-
 8 files changed, 40 insertions(+), 12 deletions(-)

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
diff --git a/src/conf.c b/src/conf.c
index ddefff6..66b0a51 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -4590,6 +4590,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
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
index bfa1cc8..c74e8ab 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -226,7 +226,11 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
 					file->final_fname);
 			return -errno;
 		}
-		fd = fileno(pipe);
+		fd = dup(fileno(pipe));
+		if (fd >= 0)
+			fclose(pipe);
+		else
+			return -errno;
 	} else {
 		if (file->trunc)
 			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_TRUNC,
diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index c413c10..41ad06e 100644
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
-                                                        return -ENOMEM;
+                                                if (instance->output.data[idx] == NULL) {
+							free(pchannels);
+							return -ENOMEM;
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
index 70e30e5..eb35e4a 100644
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
index 0bd6b96..53cd068 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -256,8 +256,10 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
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
