From: Kyler Laird <kyler-dated-1204639464.53c18d@lairds.com>
Subject: [PATCH] hda/patch_sigmatel.c Panasonic CF-74 speaker
	output
Date: Thu, 28 Feb 2008 09:11:49 -0500
Message-ID: <20080228141132.GW15570@lairds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.phaseit.net (smtp.phaseit.net [66.90.70.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 37FAF10382F
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 15:11:58 +0100 (CET)
Received: from [127.0.0.1] (helo=flews.lairds.us)
	by smtp.phaseit.net with esmtp (Exim 4.62)
	(envelope-from <kyler@lairds.com>) id 1JUjX4-0000LN-TU
	for alsa-devel@alsa-project.org; Thu, 28 Feb 2008 14:14:47 +0000
Received: from kyler by flews.lairds.us with local (Exim 4.67)
	(envelope-from <kyler@lairds.com>) id 1JUjUD-0001jv-7r
	for alsa-devel@alsa-project.org; Thu, 28 Feb 2008 09:11:49 -0500
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch causes ALSA to send sound to the speakers of a Panasonic
CF-74 (Toughbook) instead of just its headphone jack.

--kyler

diff -Naur linux-2.6.24.1/sound/pci/hda/patch_sigmatel.c
linux-2.6.24.1-ALSA_CF74/sound/pci/hda/patch_sigmatel.c
--- linux-2.6.24.1/sound/pci/hda/patch_sigmatel.c       2008-02-08
14:55:30.000000000 -0500
+++ linux-2.6.24.1-ALSA_CF74/sound/pci/hda/patch_sigmatel.c
2008-02-11 12:05:11.824064617 -0500
@@ -2467,6 +2467,11 @@
                spec->init = stac9200_core_init;
        spec->mixer = stac9200_mixer;

+       /* Kyler - fix for CF-74 speaker */
+       spec->gpio_mask = 0x00000009;
+       spec->gpio_data = 0x00000000;
+       stac92xx_enable_gpio_mask(codec);
+
        err = stac9200_parse_auto_config(codec);
        if (err < 0) {
                stac92xx_free(codec);
