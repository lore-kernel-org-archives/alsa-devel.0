From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ALSA: oxfw: some signedness bugs
Date: Fri, 12 Dec 2014 22:27:03 +0300
Message-ID: <20141212192703.GA22234@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This code tends to use unsigned variables by default and it causes
signedness bugs when we use negative variables for error handling.
The "i" and "j" variables are used to iterated over small positive
values and so they should be type "int".  The "len" variable doesn't
*need* to be signed but it should be signed to make the code easier to
read and audit.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/oxfw/oxfw-proc.c b/sound/firewire/oxfw/oxfw-proc.c
index 604808e..8ba4f9f2 100644
--- a/sound/firewire/oxfw/oxfw-proc.c
+++ b/sound/firewire/oxfw/oxfw-proc.c
@@ -15,7 +15,7 @@ static void proc_read_formation(struct snd_info_entry *entry,
 	struct snd_oxfw_stream_formation formation, curr;
 	u8 *format;
 	char flag;
-	unsigned int i, err;
+	int i, err;
 
 	/* Show input. */
 	err = snd_oxfw_stream_get_current_formation(oxfw,
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index b77cf80..bda845a 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -61,7 +61,8 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 	u8 **formats;
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
-	unsigned int i, err, len;
+	unsigned int len;
+	int i, err;
 
 	if (s == &oxfw->tx_stream) {
 		formats = oxfw->tx_stream_formats;
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 9bc556b..67ade07 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -19,7 +19,7 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 		.min = UINT_MAX, .max = 0, .integer = 1
 	};
 	struct snd_oxfw_stream_formation formation;
-	unsigned int i, err;
+	int i, err;
 
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
 		if (formats[i] == NULL)
@@ -47,7 +47,7 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 	const struct snd_interval *r =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_oxfw_stream_formation formation;
-	unsigned int i, j, err;
+	int i, j, err;
 	unsigned int count, list[SND_OXFW_STREAM_FORMAT_ENTRIES] = {0};
 
 	count = 0;
@@ -80,7 +80,7 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 static void limit_channels_and_rates(struct snd_pcm_hardware *hw, u8 **formats)
 {
 	struct snd_oxfw_stream_formation formation;
-	unsigned int i, err;
+	int i, err;
 
 	hw->channels_min = UINT_MAX;
 	hw->channels_max = 0;
