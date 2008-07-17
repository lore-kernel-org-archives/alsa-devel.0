From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: ens1370: communicate PCI device to AC97
Date: Thu, 17 Jul 2008 14:10:07 +0200
Message-ID: <487F369F.4020301@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070204000106090400030805"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CD2C6103806
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 14:08:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070204000106090400030805
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Currently the subsys_vendor/device values always display as 0x0000 in 
the codec97#n/ac97#m-k file at least.

--------------070204000106090400030805
Content-Type: text/plain;
 name="0001-ALSA-ens1370-communicate-PCI-device-to-AC97.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ALSA-ens1370-communicate-PCI-device-to-AC97.patch"

>From b3f151d5100783ff72c08365cec417254a871aad Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Thu, 17 Jul 2008 14:02:16 +0200
Subject: [PATCH] ALSA: ens1370: communicate PCI device to AC97

communicate the ES137x PCI device to the AC97 code for its
subsys_vendor/device values

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ens1370.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 38808fb..7298fe0 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1629,6 +1629,7 @@ static int __devinit snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = ensoniq;
 	ac97.private_free = snd_ensoniq_mixer_free_ac97;
+	ac97.pci = ensoniq->pci;
 	ac97.scaps = AC97_SCAP_AUDIO;
 	if ((err = snd_ac97_mixer(pbus, &ac97, &ensoniq->u.es1371.ac97)) < 0)
 		return err;
-- 
1.5.5


--------------070204000106090400030805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070204000106090400030805--
