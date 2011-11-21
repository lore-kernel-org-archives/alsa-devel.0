From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Fix PCI ID for PCIe RME MADI
	cards
Date: Mon, 21 Nov 2011 16:15:36 +0100
Message-ID: <1321888536-30937-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <20111121140221.GY10381@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20111121140221.GY10381@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: robert.steffens@iosono-sound.com, Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

Commit c09403dcc5698abf214329fbbf3cf8dbb5558bea has introduced a
regression: PCIe versions of RME MADI were no longer detected, because
the MADIface ID (0xd5) was used instead of the correct 0xd2.

This commit fixes the problem.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e760ada..19ee220 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6518,7 +6518,7 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 			hdspm->io_type = AES32;
 			hdspm->card_name = "RME AES32";
 			hdspm->midiPorts = 2;
-		} else if ((hdspm->firmware_rev == 0xd5) ||
+		} else if ((hdspm->firmware_rev == 0xd2) ||
 			((hdspm->firmware_rev >= 0xc8)  &&
 				(hdspm->firmware_rev <= 0xcf))) {
 			hdspm->io_type = MADI;
-- 
1.7.7.1
