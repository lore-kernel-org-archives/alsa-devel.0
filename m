From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/4] ALSA: hdspm - AES32: Use define instead of
	hardcoded channel count
Date: Mon, 28 Feb 2011 15:14:47 +0100
Message-ID: <1298902490-10950-2-git-send-email-adi@drcomp.erfurt.thur.de>
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


Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 5dbf620..7ce4929 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -506,6 +506,8 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define AIO_OUT_DS_CHANNELS        12
 #define AIO_OUT_QS_CHANNELS        10
 
+#define AES32_CHANNELS		16
+
 /* the size of a substream (1 mono data stream) */
 #define HDSPM_CHANNEL_BUFFER_SAMPLES  (16*1024)
 #define HDSPM_CHANNEL_BUFFER_BYTES    (4*HDSPM_CHANNEL_BUFFER_SAMPLES)
@@ -6449,9 +6451,9 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 
 	switch (hdspm->io_type) {
 	case AES32:
-		hdspm->ss_in_channels = hdspm->ss_out_channels = 16;
-		hdspm->ds_in_channels = hdspm->ds_out_channels = 16;
-		hdspm->qs_in_channels = hdspm->qs_out_channels = 16;
+		hdspm->ss_in_channels = hdspm->ss_out_channels = AES32_CHANNELS;
+		hdspm->ds_in_channels = hdspm->ds_out_channels = AES32_CHANNELS;
+		hdspm->qs_in_channels = hdspm->qs_out_channels = AES32_CHANNELS;
 
 		hdspm->channel_map_in_ss = hdspm->channel_map_out_ss =
 			channel_map_aes32;
@@ -6466,7 +6468,8 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 		hdspm->port_names_in_qs = hdspm->port_names_out_qs =
 			texts_ports_aes32;
 
-		hdspm->max_channels_out = hdspm->max_channels_in = 16;
+		hdspm->max_channels_out = hdspm->max_channels_in =
+			AES32_CHANNELS;
 		hdspm->port_names_in = hdspm->port_names_out =
 			texts_ports_aes32;
 		hdspm->channel_map_in = hdspm->channel_map_out =
-- 
1.7.4.1
