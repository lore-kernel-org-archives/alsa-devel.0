From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v2 2/4]: ALSA: oxygen: Add mute mask to the
	header file
Date: Thu, 21 Nov 2013 19:24:46 +0400
Message-ID: <20131121192446.5fe8fe7a@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp45.i.mail.ru (smtp45.i.mail.ru [94.100.177.105])
 by alsa0.perex.cz (Postfix) with ESMTP id C02052608B8
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 16:24:53 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I need this mask to mute unnecessary channels

Signed-off-by: Roman I. Volkov <v1ron@mail.ru>
---
diff -uprN linux-3.12/sound/pci/oxygen/oxygen_regs.h linux-3.12-my/sound/pci/oxygen/oxygen_regs.h
--- linux-3.12/sound/pci/oxygen/oxygen_regs.h	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen_regs.h	2013-11-20 12:08:07.000000000 +0400
@@ -318,6 +318,7 @@
 #define  OXYGEN_PLAY_MUTE23		0x0002
 #define  OXYGEN_PLAY_MUTE45		0x0004
 #define  OXYGEN_PLAY_MUTE67		0x0008
+#define  OXYGEN_PLAY_MUTE_MASK		0x000f
 #define  OXYGEN_PLAY_MULTICH_MASK	0x0010
 #define  OXYGEN_PLAY_MULTICH_I2S_DAC	0x0000
 #define  OXYGEN_PLAY_MULTICH_AC97	0x0010
-- 
Kind regards,
Roman Volkov,
v1ron@mail.ru
