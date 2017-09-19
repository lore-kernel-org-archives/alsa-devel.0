From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 29/38] axfer: add options for plugins in
	alsa-lib
Date: Tue, 19 Sep 2017 09:44:09 +0900
Message-ID: <20170919004418.24668-30-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E1182266EFE
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:30 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As of 2017, two userspace library implementations are known; alsa-lib and
tinyalsa. The latter is simple I/O library to use ALSA PCM interface. On
the other hand, alsa-lib is more complicated than it. This is because it's
designed to add features to transmission of data frames; e.g. sample
resampling. To achieve this, alsa-lib has its configuration space and
plugin system.

In aplay, some options are implemented as a flag for the plugins in
alsa-lib. The flag is given to snd_pcm_open(). This commit adds support
for the flags.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c        | 17 +++++++++++++++++
 axfer/options.h        |  6 ++++++
 axfer/xfer-libasound.c |  8 ++++++++
 3 files changed, 31 insertions(+)

diff --git a/axfer/options.c b/axfer/options.c
index aaeba5f2..2770b719 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -19,6 +19,10 @@ enum no_short_opts {
 	OPT_TEST_NOWAIT,
 	OPT_PERIOD_SIZE,
 	OPT_BUFFER_SIZE,
+	OPT_DISABLE_RESAMPLE,
+	OPT_DISABLE_CHANNELS,
+	OPT_DISABLE_FORMAT,
+	OPT_DISABLE_SOFTVOL,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -348,6 +352,11 @@ int context_options_init(struct context_options *opts, int argc,
 		{"avail-min",		1, 0, 'A'},
 		{"start-delay",		1, 0, 'R'},
 		{"stop-delay",		1, 0, 'T'},
+		/* For plugins in alsa-lib. */
+		{"disable-resample",	0, 0, OPT_DISABLE_RESAMPLE},
+		{"disable-channels",	0, 0, OPT_DISABLE_CHANNELS},
+		{"disable-format",	0, 0, OPT_DISABLE_FORMAT},
+		{"disable-softvol",	0, 0, OPT_DISABLE_SOFTVOL},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
@@ -409,6 +418,14 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->msec_for_start_threshold = parse_l(optarg, &err);
 		else if (c == 'T')
 			opts->msec_for_stop_threshold = parse_l(optarg, &err);
+		else if (c == OPT_DISABLE_RESAMPLE)
+			opts->no_auto_resample = true;
+		else if (c == OPT_DISABLE_CHANNELS)
+			opts->no_auto_channels = true;
+		else if (c == OPT_DISABLE_FORMAT)
+			opts->no_auto_format = true;
+		else if (c == OPT_DISABLE_SOFTVOL)
+			opts->no_softvol = true;
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
diff --git a/axfer/options.h b/axfer/options.h
index 63b36364..95012ad3 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -45,6 +45,12 @@ struct context_options {
 	unsigned int msec_for_start_threshold;
 	unsigned int msec_for_stop_threshold;
 
+	/* For plugins in alsa-lib. */
+	bool no_auto_resample;
+	bool no_auto_channels;
+	bool no_auto_format;
+	bool no_softvol;
+
 	/* For debugging. */
 	bool dump_hw_params;
 	bool finish_at_xrun;
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 40222e91..488d5a60 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -15,6 +15,14 @@ static int get_mode(struct context_options *options)
 
 	if (options->nonblock)
 		mode |= SND_PCM_NONBLOCK;
+	if (options->no_auto_resample)
+		mode |= SND_PCM_NO_AUTO_RESAMPLE;
+	if (options->no_auto_channels)
+		mode |= SND_PCM_NO_AUTO_CHANNELS;
+	if (options->no_auto_format)
+		mode |= SND_PCM_NO_AUTO_FORMAT;
+	if (options->no_softvol)
+		mode |= SND_PCM_NO_SOFTVOL;
 
 	return mode;
 }
-- 
2.11.0
