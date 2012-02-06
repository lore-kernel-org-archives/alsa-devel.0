From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda/realtek - cleanup a condition
Date: Mon, 6 Feb 2012 10:52:18 +0300
Message-ID: <20120206075218.GA14304@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 72B6B24461
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 08:52:37 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Sparse complains that "spec->multiout.dac_nids" is a pointer.

sound/pci/hda/patch_realtek.c:2321:37: error: incompatible types for operation (>)
sound/pci/hda/patch_realtek.c:2321:37:    left side has type unsigned short const [usertype] *dac_nids
sound/pci/hda/patch_realtek.c:2321:37:    right side has type int

I think the intent here was just to check if it was non-NULL, but please
double check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have this hardware.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a8e82be..7da4fd7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2318,7 +2318,7 @@ static int alc_build_pcms(struct hda_codec *codec)
 		 "%s Analog", codec->chip_name);
 	info->name = spec->stream_name_analog;
 
-	if (spec->multiout.dac_nids > 0) {
+	if (spec->multiout.dac_nids) {
 		p = spec->stream_analog_playback;
 		if (!p)
 			p = &alc_pcm_analog_playback;
