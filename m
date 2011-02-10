From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2.6.38] ASoC: CX20442: fix wrong
	reg_cache_default content
Date: Thu, 10 Feb 2011 13:24:32 +0100
Message-ID: <201102101324.40463.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA2D244D3
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 13:25:32 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Content of the CX20442's snd_soc_codec_driver.reg_cache_default pointed 
area, introduced with my recent NULL pointer dereferece fix (commit 
f019ee5feb344ff0b22b58df4568676295aae14f), occured wrong after further 
testing, more thorough than just booting successfully. There are two 
problems with it:

1) It should read
	(1 << CX20442_TELOUT) | (1 << CX20442_MIC),
   not 
	CX20442_TELOUT | CX20442_MIC.

2) While correctly matching actual codec hardware state on boot when 
   fixed per 1), a few more code modifications would still be required 
   to reflect that state not only into register cache, but also force 
   them into DAPM pins state, otherwise an inconsitency occures which 
   may prevent further codec state changes from being applied correctly. 
   As a result, the phone stops ringing after reboot, until someone 
   picks up the handset for the first time.

Revert that reg_cache_default content to a working, previous de facto 
default value of 0, in hope this change can still be accepted as an rc 
cycle fix.

Created and tested against linux-2.6.38-rc4

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 sound/soc/codecs/cx20442.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- git/sound/soc/codecs/cx20442.c.orig	2011-02-10 00:52:33.000000000 +0100
+++ git/sound/soc/codecs/cx20442.c	2011-02-10 12:17:31.000000000 +0100
@@ -367,7 +367,7 @@ static int cx20442_codec_remove(struct s
 	return 0;
 }
 
-static const u8 cx20442_reg = CX20442_TELOUT | CX20442_MIC;
+static const u8 cx20442_reg;
 
 static struct snd_soc_codec_driver cx20442_codec_dev = {
 	.probe = 	cx20442_codec_probe,
