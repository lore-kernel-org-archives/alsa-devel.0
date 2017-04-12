From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: line6: constify snd_kcontrol_new
	structures
Date: Wed, 12 Apr 2017 18:40:47 +0530
Message-ID: <1492002647-11016-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 173482665D5
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:10:55 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id o123so5268866pga.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 06:10:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_kcontrol_new strcutures as const as they are only passed as
an argument to the function snd_ctl_new1. This argument is of type const,
so snd_kcontrol_new structures having this property can be made const too.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct snd_kcontrol_new x@p={...};

@ok@
identifier r.x;
position p;
@@
snd_ctl_new1(&x@p,...)

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x@p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct snd_kcontrol_new x;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/usb/line6/pod.c      | 2 +-
 sound/usb/line6/toneport.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 17aa616..358224c 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -380,7 +380,7 @@ static int snd_pod_control_monitor_put(struct snd_kcontrol *kcontrol,
 }
 
 /* control definition */
-static struct snd_kcontrol_new pod_control_monitor = {
+static const struct snd_kcontrol_new pod_control_monitor = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Monitor Playback Volume",
 	.index = 0,
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 8e22f43..ba7975c 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -250,7 +250,7 @@ static void toneport_start_pcm(unsigned long arg)
 }
 
 /* control definition */
-static struct snd_kcontrol_new toneport_control_monitor = {
+static const struct snd_kcontrol_new toneport_control_monitor = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Monitor Playback Volume",
 	.index = 0,
@@ -261,7 +261,7 @@ static struct snd_kcontrol_new toneport_control_monitor = {
 };
 
 /* source selector definition */
-static struct snd_kcontrol_new toneport_control_source = {
+static const struct snd_kcontrol_new toneport_control_source = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Capture Source",
 	.index = 0,
-- 
2.7.4
