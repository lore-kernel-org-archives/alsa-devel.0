From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 1/1] ALSA: ice1724 - Check for ac97
	to avoid kernel oops
Date: Thu,  5 Jan 2012 23:05:18 +0100
Message-ID: <1325801118-3996-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

Cards with identical PCI ids but no AC97 config in EEPROM do not have
the ac97 field initialized. We must check for this case to avoid kernel oops.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/amp.c b/pci/ice1712/amp.c
index e328cfb..e525da2 100644
--- a/pci/ice1712/amp.c
+++ b/pci/ice1712/amp.c
@@ -68,8 +68,11 @@ static int __devinit snd_vt1724_amp_init(struct snd_ice1712 *ice)
 
 static int __devinit snd_vt1724_amp_add_controls(struct snd_ice1712 *ice)
 {
-	/* we use pins 39 and 41 of the VT1616 for left and right read outputs */
-	snd_ac97_write_cache(ice->ac97, 0x5a, snd_ac97_read(ice->ac97, 0x5a) & ~0x8000);
+	if (ice->ac97)
+		/* we use pins 39 and 41 of the VT1616 for left and right
+		read outputs */
+		snd_ac97_write_cache(ice->ac97, 0x5a,
+			snd_ac97_read(ice->ac97, 0x5a) & ~0x8000);
 	return 0;
 }
 
-- 
1.7.0.4
