From: sudarshan.bisht@nokia.com
Subject: [PATCH] alsa-lib: fixed coverity reported issues under
	"FORWARD_NULL" checker.
Date: Mon, 21 Mar 2011 10:43:43 +0200
Message-ID: <1300697023-4949-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id E84DB103856
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 09:45:30 +0100 (CET)
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
 modules/mixer/simple/sbasedl.c |    2 +-
 src/conf.c                     |    1 +
 src/hwdep/hwdep.c              |    1 +
 src/pcm/pcm_hooks.c            |    1 +
 src/pcm/pcm_simple.c           |    2 +-
 src/rawmidi/rawmidi.c          |    1 +
 src/rawmidi/rawmidi_virt.c     |    8 +++++---
 7 files changed, 11 insertions(+), 5 deletions(-)

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
index 8939d62..ddefff6 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3268,6 +3268,7 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
 		snd_config_iterator_t i, next;
 		if (snd_config_get_type(func_conf) != SND_CONFIG_TYPE_COMPOUND) {
 			SNDERR("Invalid type for func %s definition", str);
+			err = -EINVAL;
 			goto _err;
 		}
 		snd_config_for_each(i, next, func_conf) {
diff --git a/src/hwdep/hwdep.c b/src/hwdep/hwdep.c
index b882b35..5dc791c 100644
--- a/src/hwdep/hwdep.c
+++ b/src/hwdep/hwdep.c
@@ -78,6 +78,7 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
 	if (err >= 0) {
 		if (snd_config_get_type(type_conf) != SND_CONFIG_TYPE_COMPOUND) {
 			SNDERR("Invalid type for HWDEP type %s definition", str);
+			err = -EINVAL;
 			goto _err;
 		}
 		snd_config_for_each(i, next, type_conf) {
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index 3a99d55..404d51e 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -385,6 +385,7 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
 	if (err >= 0) {
 		if (snd_config_get_type(type) != SND_CONFIG_TYPE_COMPOUND) {
 			SNDERR("Invalid type for PCM type %s definition", str);
+			err = -EINVAL;
 			goto _err;
 		}
 		snd_config_for_each(i, next, type) {
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
index b28488a..0bd6b96 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -201,6 +201,7 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
 	if (err >= 0) {
 		if (snd_config_get_type(type_conf) != SND_CONFIG_TYPE_COMPOUND) {
 			SNDERR("Invalid type for RAWMIDI type %s definition", str);
+			err = -EINVAL;
 			goto _err;
 		}
 		snd_config_for_each(i, next, type_conf) {
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
