From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] sound:pci:Change return type of function,
	shift_bits in xonar_dg.c to avoid overflow
Date: Thu, 12 Mar 2015 00:35:46 -0400
Message-ID: <1426134946-21167-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id AD73A2654E0
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 05:35:54 +0100 (CET)
Received: by ieclw3 with SMTP id lw3so16026838iec.2
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 21:35:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This changes the return type of the function,shift_bits to unsigned
long in order to avoid overflowing issues with this function when
called as found when running sparse on the kernel source tree.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 sound/pci/oxygen/xonar_dg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 4cf3200..2337a76 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -238,7 +238,7 @@ void set_cs4245_adc_params(struct oxygen *chip,
 	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
 }
 
-static inline unsigned int shift_bits(unsigned int value,
+static inline unsigned long shift_bits(unsigned int value,
 				      unsigned int shift_from,
 				      unsigned int shift_to,
 				      unsigned int mask)
-- 
2.1.0
