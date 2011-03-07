From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Add firmware ID for older
	AES32 cards.
Date: Mon,  7 Mar 2011 19:10:11 +0100
Message-ID: <1299521411-14403-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The current AES32 firmware revision ID is 234, however, a user confirmed
that everything works fine with the previous revision, too.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 0ed4b4e..a323eaf 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -527,6 +527,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_MADIFACE_REV	213
 #define HDSPM_AES_REV		240
 #define HDSPM_AES32_REV		234
+#define HDSPM_AES32_OLD_REV	233
 
 /* speed factor modes */
 #define HDSPM_SPEED_SINGLE 0
@@ -6397,6 +6398,7 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 		break;
 	case HDSPM_AES_REV:
 	case HDSPM_AES32_REV:
+	case HDSPM_AES32_OLD_REV:
 		hdspm->io_type = AES32;
 		hdspm->card_name = "RME AES32";
 		hdspm->midiPorts = 2;
-- 
1.7.4.1
