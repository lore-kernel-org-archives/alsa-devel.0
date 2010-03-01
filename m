From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/3] ALSA: usb-audio: support multiple
 formats with audio class v2 devices
Date: Mon, 1 Mar 2010 15:26:34 +0100
Message-ID: <20100301142634.GK28972@buzzloop.caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<1267194883-6854-3-git-send-email-daniel@caiaq.de>
	<1267194883-6854-4-git-send-email-daniel@caiaq.de>
	<4B8BA4BA.8040609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B5D510386F
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 15:26:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B8BA4BA.8040609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2010 at 12:27:54PM +0100, Clemens Ladisch wrote:
> Change the parser to correctly handle v2 descriptors with multiple
> format bits set.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

I got compile errors with that one, and needed the patch below to fix
them. Want to squash that into your commit and resend?

Daniel


>From 56ee3facfc825e68ed49c6cefac644d33b82dd71 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Mon, 1 Mar 2010 15:22:54 +0100
Subject: [PATCH] ALSA: usb-audio: fix quirk formats

'struct audioformat' takes a bit field of supported rates now rather
than one fixed value. Adopt that change at two more places.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/quirks-table.h |    2 +-
 sound/usb/quirks.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index ff2df4e..2107d00 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2233,7 +2233,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S24_3BE,
+					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 00e8a97..0119fa0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -89,7 +89,7 @@ static int create_ua1000_quirk(struct snd_usb_audio *chip,
 			       const struct snd_usb_audio_quirk *quirk)
 {
 	static const struct audioformat ua1000_format = {
-		.format = SNDRV_PCM_FORMAT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 		.fmt_type = UAC_FORMAT_TYPE_I,
 		.altsetting = 1,
 		.altset_idx = 1,
-- 
1.6.6.2
