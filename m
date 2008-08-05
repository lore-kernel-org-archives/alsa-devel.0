From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: wss_lib: fix AZT2320 probe.
Date: Tue, 05 Aug 2008 09:49:52 +0200
Message-ID: <48980620.3050504@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010905020004010504060906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id DE8A024597
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 09:49:56 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010905020004010504060906
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

The attached is needed and sufficient to get AZT2320 back in line. 
Trouble is with non-settable MIC gain bits on AZT2320 which fools
snd_ad1848_probe() and makes snd-azt2320 fail to load after the wss_lib 
merge.

Krzysztof should ACK/NAK this -- he was busy there with CS4248 and might 
have other plans for it.

Krzysztof, do you? I'm rather itching to rewrite that function 
otherwise. It's horrible.

Rene.

--------------010905020004010504060906
Content-Type: text/plain;
 name="0001-ALSA-wss_lib-fix-AZT2320-probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-ALSA-wss_lib-fix-AZT2320-probe.patch"

>From 988ae22373fafa8a0059457eafc737a01c471fe4 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Tue, 5 Aug 2008 09:33:33 +0200
Subject: [PATCH] ALSA: wss_lib: fix AZT2320 probe.

After the transition from cs4321_lib to wss_lib, azt2320 probe visits
snd_ad1848_probe during detection. It expects register 0 (LEFT_INPUT)
to be able to retain the value 0xaa during detection but AZT2320 does
not support MIC gain meaning it reads back as 0x8a instead.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/isa/wss/wss_lib.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index f2df77b..955db45 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1168,11 +1168,13 @@ static int snd_ad1848_probe(struct snd_wss *chip)
 				ad1847 = 1;
 				break;
 			}
-			if (snd_wss_in(chip, CS4231_LEFT_INPUT) == 0xaa &&
-			    rev == 0x45) {
-				spin_unlock_irqrestore(&chip->reg_lock, flags);
-				id = 1;
-				break;
+			if (rev == 0x45) {
+				rev = snd_wss_in(chip, CS4231_LEFT_INPUT);
+				if (rev == 0xaa || rev == 0x8a) {
+					spin_unlock_irqrestore(&chip->reg_lock, flags);
+					id = 1;
+					break;
+				}
 			}
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
 		}
-- 
1.5.5


--------------010905020004010504060906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010905020004010504060906--
