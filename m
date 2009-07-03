From: Kenneth Johansson <kenneth@southpole.se>
Subject: [PATCH v2] Sample generation on big endian platforms
	was broken.
Date: Fri, 03 Jul 2009 22:31:38 +0200
Message-ID: <1246653098.31234.4.camel@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Has not worked since commit 3d1fa924906996463ac33cba5b5143f762d913cf

Signed-off-by: Kenneth Johansson <kenneth@southpole.se>
---

Fixes regression for 3 byte format in version 1.
tested on both little and big endian platform

 test/pcm.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/test/pcm.c b/test/pcm.c
index ee27422..0476c5f 100644
--- a/test/pcm.c
+++ b/test/pcm.c
@@ -34,14 +34,10 @@ static void generate_sine(const snd_pcm_channel_area_t *areas,
 	static double max_phase = 2. * M_PI;
 	double phase = *_phase;
 	double step = max_phase*freq/(double)rate;
-	double res;
-	unsigned char *samples[channels], *tmp;
+	unsigned char *samples[channels];
 	int steps[channels];
-	unsigned int chn, byte;
-	union {
-		int i;
-		unsigned char c[4];
-	} ires;
+	unsigned int chn;
+
 	unsigned int maxval = (1 << (snd_pcm_format_width(format) - 1)) - 1;
 	int bps = snd_pcm_format_width(format) / 8;  /* bytes per sample */
 	
@@ -61,12 +57,18 @@ static void generate_sine(const snd_pcm_channel_area_t *areas,
 	}
 	/* fill the channel areas */
 	while (count-- > 0) {
+		int res,i;
 		res = sin(phase) * maxval;
-		ires.i = res;
-		tmp = ires.c;
 		for (chn = 0; chn < channels; chn++) {
-			for (byte = 0; byte < (unsigned int)bps; byte++)
-				*(samples[chn] + byte) = tmp[byte];
+			/* Generate data in native endian format */
+			for ( i=0 ; i < bps ; i++ ){
+#if (__BYTE_ORDER == __BIG_ENDIAN)	
+				*(samples[chn] + bps-1-i) = (res >> i*8) & 0xff;
+#else
+
+				*(samples[chn] + i) = (res >> i*8) & 0xff;
+#endif			
+			}
 			samples[chn] += steps[chn];
 		}
 		phase += step;
-- 
1.6.1.GIT
