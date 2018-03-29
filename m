From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: usb-audio: silence a static checker
	warning
Date: Thu, 29 Mar 2018 12:03:19 +0300
Message-ID: <20180329090319.GB17927@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DEF0266F69
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 11:03:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

We recently made "format" a u64 variable so now static checkers complain
that this shift will wrap around if format is more than 31.  I don't
think it makes a difference for runtime, but it's simple to silence the
warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/format.c b/sound/usb/format.c
index edbe67eeddfa..49e7ec6d2399 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -55,7 +55,7 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
 		sample_width = fmt->bBitResolution;
 		sample_bytes = fmt->bSubframeSize;
-		format = 1 << format;
+		format = 1ULL << format;
 		break;
 	}
 
