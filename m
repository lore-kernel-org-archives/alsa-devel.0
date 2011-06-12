From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] ALSA: hdspm - Add firmware revision ID for
	RME MADI PCI version
Date: Sun, 12 Jun 2011 17:26:19 +0200
Message-ID: <1307892379-31179-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

The PCI version of the RME HDSP MADI card uses 0xcf as revision ID. Just
add this to the list of supported cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d03ef94..3f08afc 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -521,6 +521,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_DMA_AREA_KILOBYTES (HDSPM_DMA_AREA_BYTES/1024)
 
 /* revisions >= 230 indicate AES32 card */
+#define HDSPM_MADI_OLD_REV	207
 #define HDSPM_MADI_REV		210
 #define HDSPM_RAYDAT_REV	211
 #define HDSPM_AIO_REV		212
@@ -6379,6 +6380,7 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 
 	switch (hdspm->firmware_rev) {
 	case HDSPM_MADI_REV:
+	case HDSPM_MADI_OLD_REV:
 		hdspm->io_type = MADI;
 		hdspm->card_name = "RME MADI";
 		hdspm->midiPorts = 3;
-- 
1.7.5.4
