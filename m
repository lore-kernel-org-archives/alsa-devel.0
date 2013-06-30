From: alex.d.wiggins@gmail.com
Subject: [PATCH - oss plugin update revised 2/2] oss: Add user
	variables to set period and buffer config
Date: Sun, 30 Jun 2013 01:47:08 +0100
Message-ID: <51cf803d.0867b40a.36ac.ffffad5f@mx.google.com>
References: <1372553228-6171-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372553228-6171-1-git-send-email-me>
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
Cc: Alex Wiggins <alex.d.wiggins@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alex Wiggins <alex.d.wiggins@gmail.com>

Added 3 user variables to control the OSS period and buffer config:

 - period_size (integer):
   if not set then queries OSS for period size
   (by using SNDCTL_DSP_GETBLKSIZE),
   if positive then sets the OSS period size
   (SND_PCM_IOPLUG_HW_PERIOD_BYTES),
   if negative then allows any power of 2 period size.

 - periods (integer):
   sets the number of OSS periods (SND_PCM_IOPLUG_HW_PERIODS);

 - buffer_size (integer):
   sets the OSS buffer size (SND_PCM_IOPLUG_HW_BUFFER_BYTES).

Note that ALSA performs sanity checks to prevent conflicts.

Signed-off-by: Alex Wiggins <alex.d.wiggins@gmail.com>

diff --git a/oss/pcm_oss.c b/oss/pcm_oss.c
index d5b5bc4..a92c3e9 100644
--- a/oss/pcm_oss.c
+++ b/oss/pcm_oss.c
@@ -60,6 +60,12 @@ typedef struct snd_pcm_oss {
 	unsigned int period_shift;
 	unsigned int periods;
 	unsigned int frame_bytes;
+	/* user variables set using ALSA config files */
+	/* included here as this snd_pcm_oss_t struct
+	   is stored in io->private_data */
+	long int user_period_size;
+	long int user_periods;
+	long int user_buffer_size;
 } snd_pcm_oss_t;
 
 static snd_pcm_sframes_t oss_write(snd_pcm_ioplug_t *io,
@@ -408,6 +414,7 @@ static int oss_hw_constraint(snd_pcm_oss_t *oss)
 	unsigned int nchannels;
 	unsigned int channel[6];
 	/* period and buffer bytes must be power of two */
+	/* minimum: 2^8 = 256; maximum: 2^23 = 8388608 */
 	static const unsigned int bytes_list[] = {
 		1U<<8, 1U<<9, 1U<<10, 1U<<11, 1U<<12, 1U<<13, 1U<<14, 1U<<15,
 		1U<<16, 1U<<17, 1U<<18, 1U<<19, 1U<<20, 1U<<21, 1U<<22, 1U<<23
@@ -500,20 +507,97 @@ static int oss_hw_constraint(snd_pcm_oss_t *oss)
 	if (err < 0)
 		return err;
 
-	/* period size (in power of two) */
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-					    ARRAY_SIZE(bytes_list), bytes_list);
-	if (err < 0)
-		return err;
-	/* periods */
-	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS, 2, 1024);
-	if (err < 0)
-		return err;
-	/* buffer size (in power of two) */
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_BUFFER_BYTES,
-					    ARRAY_SIZE(bytes_list), bytes_list);
-	if (err < 0)
-		return err;
+	/* period and buffer sizes: default behaviour below is to
+	   query period size from OSS */
+
+	/* consider user set paramaters
+	   (period_size; periods; buffer_size) */
+
+	/* note: ALSA performs sanity checks
+		 to prevent conflicting parameters */
+
+	/* period_size */
+	if (oss->user_period_size < 0) {
+		/* period_size set to negative value:
+		   allow any power of 2 period size */
+		err = snd_pcm_ioplug_set_param_list(io,
+			SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+			ARRAY_SIZE(bytes_list), bytes_list);
+		if (err < 0)
+			return err;
+	} else {
+		if (oss->user_period_size > 0) {
+			/* period_size set to positive value:
+			   use user set period size */
+			const unsigned int user_period_size
+			  = oss->user_period_size;
+			err = snd_pcm_ioplug_set_param_list(io,
+				SND_PCM_IOPLUG_HW_PERIOD_BYTES, 1,
+				&user_period_size);
+		} else {
+			/* query OSS for period size (called fragment size) */
+			unsigned int fragsize;
+			if (ioctl(oss->fd, SNDCTL_DSP_GETBLKSIZE, &fragsize)
+				< 0)
+				fprintf(stderr,
+"*** alsa-plugins-oss: error querying SNDCTL_DSP_GETBLKSIZE.\n");
+
+			/* note: second query of SNDCTL_DSP_GETBLKSIZE
+				 can give different result
+				 (i.e. 4096 instead of 2048) */
+			/* in oss_audio_core.c getblksize function,
+			   4096 is the default return value:
+			   so second time probably not reliable */
+
+			/* period size (in power of two) */
+			unsigned int x = fragsize;
+			/* check if fragsize is a power of two */
+			if ((x != 0) && ((x & (~x + 1)) == x))
+				err = snd_pcm_ioplug_set_param_list(io,
+					SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+					1, &fragsize);
+			else
+				err = snd_pcm_ioplug_set_param_list(io,
+					SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+					ARRAY_SIZE(bytes_list), bytes_list);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* periods (number of periods per buffer) */
+	if (oss->user_periods > 0) {
+		/* force number of periods to user set periods */
+		const unsigned int user_periods = oss->user_periods;
+		err = snd_pcm_ioplug_set_param_list(io,
+			SND_PCM_IOPLUG_HW_PERIODS, 1, &user_periods);
+		if (err < 0)
+			return err;
+	} else {
+		/* allow any number of periods between 2 and 1024 inclusive
+		  (ALSA can choose) */
+		err = snd_pcm_ioplug_set_param_minmax(io,
+			SND_PCM_IOPLUG_HW_PERIODS, 2, 1024);
+		if (err < 0)
+			return err;
+	}
+
+	/* buffer_size */
+	if (oss->user_buffer_size > 0) {
+		/* force buffer size to user set buffer_size */
+		const unsigned int user_buffer_size = oss->user_buffer_size;
+		err = snd_pcm_ioplug_set_param_list(io,
+			SND_PCM_IOPLUG_HW_BUFFER_BYTES, 1, &user_buffer_size);
+		if (err < 0)
+			return err;
+	} else {
+		/* buffer size (in power of two) */
+		err = snd_pcm_ioplug_set_param_list(io,
+			SND_PCM_IOPLUG_HW_BUFFER_BYTES,
+			ARRAY_SIZE(bytes_list), bytes_list);
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
@@ -558,6 +642,10 @@ SND_PCM_PLUGIN_DEFINE_FUNC(oss)
 	const char *device = "/dev/dsp";
 	int err;
 	snd_pcm_oss_t *oss;
+	/* default values for user variables*/
+	long int user_period_size = 0;
+	long int user_periods = 0;
+	long int user_buffer_size = 0;
 	
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -573,6 +661,30 @@ SND_PCM_PLUGIN_DEFINE_FUNC(oss)
 			}
 			continue;
 		}
+
+		/* user variables */
+		if (strcmp(id, "period_size") == 0) {
+			if (snd_config_get_integer(n, &user_period_size) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			continue;
+		}
+		if (strcmp(id, "periods") == 0) {
+			if (snd_config_get_integer(n, &user_periods) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			continue;
+		}
+		if (strcmp(id, "buffer_size") == 0) {
+			if (snd_config_get_integer(n, &user_buffer_size) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			continue;
+		}
+
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
@@ -597,6 +709,11 @@ SND_PCM_PLUGIN_DEFINE_FUNC(oss)
 		goto error;
 	}
 
+	/* save user variables from ALSA config files */
+	oss->user_period_size = user_period_size;
+	oss->user_periods = user_periods;
+	oss->user_buffer_size = user_buffer_size;
+
 	oss->io.version = SND_PCM_IOPLUG_VERSION;
 	oss->io.name = "ALSA <-> OSS PCM I/O Plugin";
 	oss->io.poll_fd = oss->fd;
-- 
1.8.3.1
