From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: [PATCH] asihpi
Date: Fri, 18 Mar 2005 09:25:41 +1300
Message-ID: <200503180925.41383.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FfeOCZVCYBaLmIC"
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_FfeOCZVCYBaLmIC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Fix underruns for 8kHz mono record.
Update for compatibility with HPK rev 293 (addition of cobranet nodes). (Will 
still compile with a warning with older HPK revisions)
-- 
--
Eliot

--Boundary-00=_FfeOCZVCYBaLmIC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="asihpi.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asihpi.c.patch"

--- alsa-driver-1.0.9rc1_clean/pci/asihpi.c	2005-02-09 10:22:30.000000000 +1300
+++ alsa-driver-1.0.9rc1/pci/asihpi.c	2005-03-18 09:06:12.776382450 +1300
@@ -134,8 +134,8 @@
 	dpcm->pcm_size = params_buffer_bytes(params);
 	dpcm->pcm_count = params_period_bytes(params);
 	dpcm->pcm_jiffie_per_period = (dpcm->pcm_count * HZ / bps);
-	snd_printd("Jiffies per period %ld\n",
-		   (long)dpcm->pcm_jiffie_per_period);
+	snd_printd("Jiffies per period %ld, pcm_size %d, pcm_count %d\n",
+			   (long)dpcm->pcm_jiffie_per_period,dpcm->pcm_size,    dpcm->pcm_count);
 	dpcm->pcm_irq_pos = 0;
 	dpcm->pcm_buf_pos = 0;
 	return 0;
@@ -370,17 +370,17 @@
 	.channels_min = 1,
 	.channels_max = 2,
 	.buffer_bytes_max = MAX_BUFFER_SIZE,
-	.period_bytes_min = MAX_BUFFER_SIZE / 8,
+	.period_bytes_min = MAX_BUFFER_SIZE / 64,
 	.period_bytes_max = MAX_BUFFER_SIZE / 2,
 	.periods_min = 2,
-	.periods_max = 8,
+	.periods_max = 64,
 	.fifo_size = 0,
 };
 
 static void snd_card_asihpi_playback_format(HPI_HOSTREAM hStream,
 					    u64 * formats)
 {
-	HPI_FORMAT hpi_format = { 44100, 128000, 0, 0, 0, 2, 0 };
+	HPI_FORMAT hpi_format = { 48000, 128000, 0, 0, 0, 2, 0 };
 	HW16 wFormat;
 	HW16 err;
 
@@ -639,17 +639,17 @@
 	.channels_min = 1,
 	.channels_max = 2,
 	.buffer_bytes_max = MAX_BUFFER_SIZE,
-	.period_bytes_min = MAX_BUFFER_SIZE / 16,
+	.period_bytes_min = MAX_BUFFER_SIZE / 64,
 	.period_bytes_max = MAX_BUFFER_SIZE,
 	.periods_min = 1,
-	.periods_max = 16,
+	.periods_max = 64,
 	.fifo_size = 0,
 };
 
 static void snd_card_asihpi_capture_format(HPI_HOSTREAM hStream,
 					   u64 * formats)
 {
-	HPI_FORMAT hpi_format = { 44100, 128000, 0, 0, 0, 2, 0 };
+	HPI_FORMAT hpi_format = { 48000, 128000, 0, 0, 0, 2, 0 };
 	HW16 wFormat;
 	HW16 err;
 
@@ -791,7 +791,7 @@
 #ifdef ASI_STYLE_NAMES
 #define ASIHPI_SOURCENODE_STRINGS \
 { \
-	TEXT("none!"), \
+	TEXT("no source"), \
 	TEXT("OutStr"), \
 	TEXT("LineIn"), \
 	TEXT("AesIn"), \
@@ -800,6 +800,7 @@
 	TEXT("Clock"), \
 	TEXT("Bitstr"), \
 	TEXT("Mic"), \
+	TEXT("Cobranet"), \
 }
 #else
 #define ASIHPI_SOURCENODE_STRINGS \
@@ -813,13 +814,11 @@
 	TEXT("Clock"), \
 	TEXT("Bitstream"), \
 	TEXT("Mic"), \
+	TEXT("Cobranet"), \
 }
 #endif
 
-#define NUM_SOURCENODE_STRINGS 9
-#if (NUM_SOURCENODE_STRINGS != (HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_BASE+1))
-#error TEXT("Sourcenode strings don't match #defines")
-#endif
+#define NUM_SOURCENODE_STRINGS 10
 
 #ifdef ASI_STYLE_NAMES
 #define ASIHPI_DESTNODE_STRINGS \
@@ -830,6 +829,7 @@
 	TEXT("AesOut"), \
 	TEXT("RF"), \
 	TEXT("Speak") \
+	TEXT("Cobranet"), \
 }
 #else
 #define ASIHPI_DESTNODE_STRINGS \
@@ -840,11 +840,18 @@
 	TEXT("Digital"), \
 	TEXT("RF"), \
 	TEXT("Speaker") \
+	TEXT("Cobranet"), \
 }
 #endif
-#define NUM_DESTNODE_STRINGS 6
-#if (NUM_DESTNODE_STRINGS != (HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_BASE+1))
-#error "Destnode strings don't match #defines"
+#define NUM_DESTNODE_STRINGS 7
+
+#if ( (NUM_SOURCENODE_STRINGS < (HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_BASE+1)) ||
+(NUM_DESTNODE_STRINGS < (HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_BASE+1)))
+#error "Fewer node strings than #defines - new HPI?"
+#endif
+#if ( (NUM_SOURCENODE_STRINGS > (HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_BASE+1)) ||
+(NUM_DESTNODE_STRINGS < (HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_BASE+1)))
+#warning "More Node strings than HPI defines - old HPI?"
 #endif
 
 static char *asihpi_src_names[] = ASIHPI_SOURCENODE_STRINGS;

--Boundary-00=_FfeOCZVCYBaLmIC--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
