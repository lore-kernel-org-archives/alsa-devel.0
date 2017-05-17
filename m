From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: mixart: constify snd_kcontrol_new
	structures
Date: Wed, 17 May 2017 17:43:30 +0530
Message-ID: <1495023210-26811-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE052664EB
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 14:14:14 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id n23so1542912pfb.3
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 05:14:14 -0700 (PDT)
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

Declare snd_kcontrol_new structures as const as they are only passed an
argument to the function snd_ctl_new1. This argument is of type const,
so snd_kcontrol_new structures having this property can be made const.
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
 sound/pci/mixart/mixart_mixer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 4a4616a..2b9496a 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -404,7 +404,7 @@ static int mixart_analog_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 
 static const DECLARE_TLV_DB_SCALE(db_scale_analog, -9600, 50, 0);
 
-static struct snd_kcontrol_new mixart_control_analog_level = {
+static const struct snd_kcontrol_new mixart_control_analog_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -897,7 +897,7 @@ static int mixart_pcm_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
 static const DECLARE_TLV_DB_SCALE(db_scale_digital, -10950, 50, 0);
 
-static struct snd_kcontrol_new snd_mixart_pcm_vol =
+static const struct snd_kcontrol_new snd_mixart_pcm_vol =
 {
 	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -951,7 +951,7 @@ static int mixart_pcm_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 	return changed;
 }
 
-static struct snd_kcontrol_new mixart_control_pcm_switch = {
+static const struct snd_kcontrol_new mixart_control_pcm_switch = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	/* name will be filled later */
 	.count =        MIXART_PLAYBACK_STREAMS,
-- 
2.7.4
