From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/3] ALSA: pcxhr: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:10 +0530
Message-ID: <1502873051-28437-3-git-send-email-bhumirks@gmail.com>
References: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2F12674DE
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 10:45:27 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id 83so4746344pgb.4
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 01:45:27 -0700 (PDT)
In-Reply-To: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/pcxhr/pcxhr_mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr_mixer.c b/sound/pci/pcxhr/pcxhr_mixer.c
index 36875df..d9a1c6c 100644
--- a/sound/pci/pcxhr/pcxhr_mixer.c
+++ b/sound/pci/pcxhr/pcxhr_mixer.c
@@ -185,7 +185,7 @@ static int pcxhr_analog_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_analog_level = {
+static const struct snd_kcontrol_new pcxhr_control_analog_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -409,7 +409,7 @@ static int pcxhr_pcm_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_pcxhr_pcm_vol =
+static const struct snd_kcontrol_new snd_pcxhr_pcm_vol =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
-- 
1.9.1
