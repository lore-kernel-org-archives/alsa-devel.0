From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/35] axfer: add options for plugins in
	alsa-lib
Date: Tue, 13 Nov 2018 15:41:39 +0900
Message-ID: <20181113064147.13577-27-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FF92267B2D
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:41 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id t13so2542765ply.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:41 -0800 (PST)
In-Reply-To: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
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
 axfer/xfer-libasound.c | 25 +++++++++++++++++++++++++
 axfer/xfer-libasound.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 1e709e0..a731423 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -13,6 +13,10 @@ enum no_short_opts {
         // 200 or later belong to non us-ascii character set.
 	OPT_PERIOD_SIZE = 200,
 	OPT_BUFFER_SIZE,
+	OPT_DISABLE_RESAMPLE,
+	OPT_DISABLE_CHANNELS,
+	OPT_DISABLE_FORMAT,
+	OPT_DISABLE_SOFTVOL,
 	OPT_FATAL_ERRORS,
 	OPT_TEST_NOWAIT,
 };
@@ -29,6 +33,11 @@ static const struct option l_opts[] = {
 	{"avail-min",		1, 0, 'A'},
 	{"start-delay",		1, 0, 'R'},
 	{"stop-delay",		1, 0, 'T'},
+	// For plugins in alsa-lib.
+	{"disable-resample",	0, 0, OPT_DISABLE_RESAMPLE},
+	{"disable-channels",	0, 0, OPT_DISABLE_CHANNELS},
+	{"disable-format",	0, 0, OPT_DISABLE_FORMAT},
+	{"disable-softvol",	0, 0, OPT_DISABLE_SOFTVOL},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 	{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
@@ -77,6 +86,14 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->msec_for_start_threshold = arg_parse_decimal_num(optarg, &err);
 	else if (key == 'T')
 		state->msec_for_stop_threshold = arg_parse_decimal_num(optarg, &err);
+	else if (key == OPT_DISABLE_RESAMPLE)
+		state->no_auto_resample = true;
+	else if (key == OPT_DISABLE_CHANNELS)
+		state->no_auto_channels = true;
+	else if (key == OPT_DISABLE_FORMAT)
+		state->no_auto_format = true;
+	else if (key == OPT_DISABLE_SOFTVOL)
+		state->no_softvol = true;
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else if (key == OPT_TEST_NOWAIT)
@@ -164,6 +181,14 @@ static int open_handle(struct xfer_context *xfer)
 
 	if (state->nonblock)
 		mode |= SND_PCM_NONBLOCK;
+	if (state->no_auto_resample)
+		mode |= SND_PCM_NO_AUTO_RESAMPLE;
+	if (state->no_auto_channels)
+		mode |= SND_PCM_NO_AUTO_CHANNELS;
+	if (state->no_auto_format)
+		mode |= SND_PCM_NO_AUTO_FORMAT;
+	if (state->no_softvol)
+		mode |= SND_PCM_NO_SOFTVOL;
 
 	err = snd_pcm_open(&state->handle, state->node_literal, xfer->direction,
 			   mode);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 113c1b9..cf940e5 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -43,6 +43,10 @@ struct libasound_state {
 	bool nonblock:1;
 	bool mmap:1;
 	bool test_nowait:1;
+	bool no_auto_resample:1;
+	bool no_auto_channels:1;
+	bool no_auto_format:1;
+	bool no_softvol:1;
 
 	bool use_waiter:1;
 };
-- 
2.19.1
