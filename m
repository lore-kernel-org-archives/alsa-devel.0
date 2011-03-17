From: sudarshan.bisht@nokia.com
Subject: [PATCH 1/1] alsa-lib: fixed coverity reported issues
	under "FORWARD_NULL" checker.
Date: Thu, 17 Mar 2011 11:41:12 +0200
Message-ID: <1300354872-1443-2-git-send-email-sudarshan.bisht@nokia.com>
References: <1300354872-1443-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 366B7103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:42:49 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H9gjxp030262
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:42:48 +0200
In-Reply-To: <1300354872-1443-1-git-send-email-sudarshan.bisht@nokia.com>
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
 modules/mixer/simple/sbasedl.c |    2 +-
 src/conf.c                     |    8 +++++---
 src/hwdep/hwdep.c              |    2 +-
 src/pcm/pcm_hooks.c            |    5 +++--
 src/pcm/pcm_simple.c           |    2 +-
 src/rawmidi/rawmidi.c          |    2 +-
 src/rawmidi/rawmidi_virt.c     |    8 +++++---
 7 files changed, 17 insertions(+), 12 deletions(-)

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
index 8939d62..9b69e12 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3321,9 +3321,11 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
 		snd_config_delete(func_conf);
 	if (err >= 0) {
 		snd_config_t *nroot;
-		err = func(root, config, &nroot, private_data);
-		if (err < 0)
-			SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
+		if (func) {
+			err = func(root, config, &nroot, private_data);
+			if (err < 0)
+				SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
+		}
 		snd_dlclose(h);
 		if (err >= 0 && nroot)
 			err = snd_config_substitute(root, nroot);
diff --git a/src/hwdep/hwdep.c b/src/hwdep/hwdep.c
index b882b35..690d9f6 100644
--- a/src/hwdep/hwdep.c
+++ b/src/hwdep/hwdep.c
@@ -130,7 +130,7 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
        _err:
 	if (type_conf)
 		snd_config_delete(type_conf);
-	if (err >= 0) {
+	if (err >= 0 && open_func) {
 		err = open_func(hwdep, name, hwdep_root, hwdep_conf, mode);
 		if (err >= 0) {
 			(*hwdep)->dl_handle = h;
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index 3a99d55..a0ed0b9 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -445,14 +445,15 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
 		else
 			err = install_func(pcm, args);
 		snd_config_delete(args);
-	} else
+	} else if (install_func)
 		err = install_func(pcm, args);
 
 	if (err >= 0)
 		err = hook_add_dlobj(pcm, h);
 
 	if (err < 0) {
-		snd_dlclose(h);
+		if (h)
+			snd_dlclose(h);
 		return err;
 	}
 	return 0;
diff --git a/src/pcm/pcm_simple.c b/src/pcm/pcm_simple.c
index 975f699..f943ec0 100644
--- a/src/pcm/pcm_simple.c
+++ b/src/pcm/pcm_simple.c
@@ -89,7 +89,7 @@ static int set_hw_params(snd_pcm_t *pcm,
 			return err;
 		if (periods == 1)
 			return -EINVAL;
-		if (*period_time == 0) {
+		if (period_time) {
 			err = INTERNAL(snd_pcm_hw_params_get_period_time)(hw_params, period_time, NULL);
 			if (err < 0)
 				return err;
diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index b28488a..a8d7231 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -253,7 +253,7 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
        _err:
 	if (type_conf)
 		snd_config_delete(type_conf);
-	if (err >= 0)
+	if (err >= 0 && open_func)
 		err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
 	if (err < 0)
 		return err;
diff --git a/src/rawmidi/rawmidi_virt.c b/src/rawmidi/rawmidi_virt.c
index 52b8984..e5b17e4 100644
--- a/src/rawmidi/rawmidi_virt.c
+++ b/src/rawmidi/rawmidi_virt.c
@@ -383,9 +383,11 @@ int snd_rawmidi_virtual_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
  _err:
 	if (seq_handle)
 		snd_seq_close(seq_handle);
-	if (virt->midi_event)
-		snd_midi_event_free(virt->midi_event);
-	free(virt);
+	if (virt) {
+		if (virt->midi_event)
+			snd_midi_event_free(virt->midi_event);
+		free(virt);
+	}
 	if (inputp)
 		free(*inputp);
 	if (outputp)
-- 
1.7.0.4
