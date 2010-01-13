From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Fix typo in comment in
	header file
Date: Wed, 13 Jan 2010 08:56:26 +0200
Message-ID: <201001130856.26704.peter.ujfalusi@nokia.com>
References: <1263312438-4193-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FF4C10384C
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 07:56:32 +0100 (CET)
In-Reply-To: <1263312438-4193-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Thomas Weber <weber@corscience.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 12 January 2010 18:07:18 ext Thomas Weber wrote:
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  sound/soc/codecs/twl4030.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
> index dd6396e..f206d24 100644
> --- a/sound/soc/codecs/twl4030.h
> +++ b/sound/soc/codecs/twl4030.h
> @@ -25,7 +25,7 @@
>  /* Register descriptions are here */
>  #include <linux/mfd/twl4030-codec.h>
> 
> -/* Sgadow register used by the audio driver */
> +/* Shadow register used by the audio driver */
>  #define TWL4030_REG_SW_SHADOW		0x4A
>  #define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)

Oh yes, thank you!

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
