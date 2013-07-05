From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 10/31] ALSA: hdspm - Add support for AEBs on
	RME AIO
Date: Fri,  5 Jul 2013 11:28:02 +0200
Message-ID: <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AIO cards allow to use AEB (Analogue Expansion Boards) to add four
input and/or output channels.

This patch adds the necessary code to detect and enable the additional
I/O channels.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 778fc23..ad41636 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -648,7 +648,8 @@ static char *texts_ports_aio_in_ss[] = {
 	"AES.L", "AES.R",
 	"SPDIF.L", "SPDIF.R",
 	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4", "ADAT.5", "ADAT.6",
-	"ADAT.7", "ADAT.8"
+	"ADAT.7", "ADAT.8",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aio_out_ss[] = {
@@ -657,14 +658,16 @@ static char *texts_ports_aio_out_ss[] = {
 	"SPDIF.L", "SPDIF.R",
 	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4", "ADAT.5", "ADAT.6",
 	"ADAT.7", "ADAT.8",
-	"Phone.L", "Phone.R"
+	"Phone.L", "Phone.R",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aio_in_ds[] = {
 	"Analogue.L", "Analogue.R",
 	"AES.L", "AES.R",
 	"SPDIF.L", "SPDIF.R",
-	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4"
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aio_out_ds[] = {
@@ -672,14 +675,16 @@ static char *texts_ports_aio_out_ds[] = {
 	"AES.L", "AES.R",
 	"SPDIF.L", "SPDIF.R",
 	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
-	"Phone.L", "Phone.R"
+	"Phone.L", "Phone.R",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aio_in_qs[] = {
 	"Analogue.L", "Analogue.R",
 	"AES.L", "AES.R",
 	"SPDIF.L", "SPDIF.R",
-	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4"
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aio_out_qs[] = {
@@ -687,7 +692,8 @@ static char *texts_ports_aio_out_qs[] = {
 	"AES.L", "AES.R",
 	"SPDIF.L", "SPDIF.R",
 	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
-	"Phone.L", "Phone.R"
+	"Phone.L", "Phone.R",
+	"AEB.1", "AEB.2", "AEB.3", "AEB.4"
 };
 
 static char *texts_ports_aes32[] = {
@@ -764,8 +770,8 @@ static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
 	8, 9,			/* aes in, */
 	10, 11,			/* spdif in */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
-	-1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -779,7 +785,8 @@ static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif out */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -792,7 +799,8 @@ static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
 	8, 9,			/* aes in */
 	10, 11,			/* spdif in */
 	12, 14, 16, 18,		/* adat in */
-	-1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -807,7 +815,7 @@ static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif out */
 	12, 14, 16, 18,		/* adat out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -821,7 +829,8 @@ static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
 	8, 9,			/* aes in */
 	10, 11,			/* spdif in */
 	12, 16,			/* adat in */
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -836,7 +845,8 @@ static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif out */
 	12, 16,			/* adat out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -6602,10 +6612,6 @@ static int snd_hdspm_create(struct snd_card *card,
 		break;
 
 	case AIO:
-		if (0 == (hdspm_read(hdspm, HDSPM_statusRegister2) & HDSPM_s2_AEBI_D)) {
-			snd_printk(KERN_INFO "HDSPM: AEB input board found, but not supported\n");
-		}
-
 		hdspm->ss_in_channels = AIO_IN_SS_CHANNELS;
 		hdspm->ds_in_channels = AIO_IN_DS_CHANNELS;
 		hdspm->qs_in_channels = AIO_IN_QS_CHANNELS;
@@ -6613,6 +6619,20 @@ static int snd_hdspm_create(struct snd_card *card,
 		hdspm->ds_out_channels = AIO_OUT_DS_CHANNELS;
 		hdspm->qs_out_channels = AIO_OUT_QS_CHANNELS;
 
+		if (0 == (hdspm_read(hdspm, HDSPM_statusRegister2) & HDSPM_s2_AEBI_D)) {
+			snd_printk(KERN_INFO "HDSPM: AEB input board found\n");
+			hdspm->ss_in_channels += 4;
+			hdspm->ds_in_channels += 4;
+			hdspm->qs_in_channels += 4;
+		}
+
+		if (0 == (hdspm_read(hdspm, HDSPM_statusRegister2) & HDSPM_s2_AEBO_D)) {
+			snd_printk(KERN_INFO "HDSPM: AEB output board found\n");
+			hdspm->ss_out_channels += 4;
+			hdspm->ds_out_channels += 4;
+			hdspm->qs_out_channels += 4;
+		}
+
 		hdspm->channel_map_out_ss = channel_map_aio_out_ss;
 		hdspm->channel_map_out_ds = channel_map_aio_out_ds;
 		hdspm->channel_map_out_qs = channel_map_aio_out_qs;
-- 
1.8.3.1
