From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/4] ALSA: hdspm - Add updated firmware
	revision for AES32
Date: Mon, 28 Feb 2011 15:14:48 +0100
Message-ID: <1298902490-10950-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298902490-10950-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298902490-10950-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

In contrast to the PCIe version (RME AES), the PCI version (RME AES32)
has a different firmware revision.

This patch adds the missing PCI revision.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 7ce4929..20c54f7 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -526,6 +526,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_AIO_REV		212
 #define HDSPM_MADIFACE_REV	213
 #define HDSPM_AES_REV		240
+#define HDSPM_AES32_REV		234
 
 /* speed factor modes */
 #define HDSPM_SPEED_SINGLE 0
@@ -6393,6 +6394,7 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 		hdspm->midiPorts = 1;
 		break;
 	case HDSPM_AES_REV:
+	case HDSPM_AES32_REV:
 		hdspm->io_type = AES32;
 		hdspm->card_name = "RME AES32";
 		hdspm->midiPorts = 2;
-- 
1.7.4.1
