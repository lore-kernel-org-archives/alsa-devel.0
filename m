From: sudarshan.bisht@nokia.com
Subject: [PATCH 1/1] alsa-lib: fixed coverity reported issues
	under "RESOURCE_LEAK" checker.
Date: Thu, 17 Mar 2011 11:34:37 +0200
Message-ID: <1300354477-1088-2-git-send-email-sudarshan.bisht@nokia.com>
References: <1300354477-1088-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 715AE103984
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:36:12 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-sa01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H9aA4v024531
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:36:11 +0200
In-Reply-To: <1300354477-1088-1-git-send-email-sudarshan.bisht@nokia.com>
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
List-Id: alsa-devel@alsa-project.org

From: Sudarshan <sudarshan.bisht@nokia.com>

---
 modules/mixer/simple/sbase.c   |    1 +
 modules/mixer/simple/sbasedl.c |    2 +-
 src/conf.c                     |    2 ++
 src/control/control_hw.c       |    4 +++-
 src/pcm/pcm_file.c             |    5 +++--
 src/pcm/pcm_ladspa.c           |   20 ++++++++++++++------
 src/pcm/pcm_plug.c             |    5 ++++-
 src/pcm/pcm_rate.c             |    1 +
 src/rawmidi/rawmidi.c          |    4 +++-
 9 files changed, 32 insertions(+), 12 deletions(-)

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
index 8939d62..61b03ec 100644
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
@@ -4589,6 +4590,7 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
 		if (err < 0) {
 		_err:
 			free(val);
+			snd_config_delete(sub);
 			return err;
 		}
 		free(val);
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index cf258b4..281b1a5 100644
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
+	}
 		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
 	}
 	free(xtlv);
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index bfa1cc8..cb61ab9 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -218,7 +218,7 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
 
 	if (file->final_fname[0] == '|') {
 		/* pipe mode */
-		FILE *pipe;
+		FILE *pipe = NULL;
 		/* clearing */
 		pipe = popen(file->final_fname + 1, "w");
 		if (!pipe) {
@@ -226,7 +226,8 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
 					file->final_fname);
 			return -errno;
 		}
-		fd = fileno(pipe);
+		fd = dup(fileno(pipe));
+		fclose(pipe);
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
index e9d2923..7308962 100644
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
@@ -1310,8 +1311,10 @@ int _snd_pcm_plug_open(snd_pcm_t **pcmp, const char *name,
 
 	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
 	snd_config_delete(sconf);
-	if (err < 0)
+	if (err < 0) {
+		free(ttable);
 		return err;
+	}
 	err = snd_pcm_plug_open(pcmp, name, sformat, schannels, srate, rate_converter,
 				route_policy, ttable, ssize, cused, sused, spcm, 1);
 	if (err < 0)
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 70e30e5..065c9da 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1392,6 +1392,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	} else {
 		SNDERR("Invalid type for rate converter");
 		snd_pcm_close(pcm);
+		free(rate);
 		return -EINVAL;
 	}
 	if (err < 0) {
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
