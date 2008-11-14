From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Fix for master playback/capture
	volume range for TWL4030 codec
Date: Fri, 14 Nov 2008 08:54:44 +0200
Message-ID: <200811140854.44877.peter.ujfalusi@nokia.com>
References: <1226645009-28029-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AD32243AF
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 07:54:57 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAE6ssi8001811
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:54:55 +0200
In-Reply-To: <1226645009-28029-1-git-send-email-peter.ujfalusi@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Disregard this patch, I'll resend it.
I have just noticed that the playback and capture ranges are
different.


On Friday 14 November 2008 08:43:29 Peter Ujfalusi wrote:
> FGAIN for playback/capture is in range of 0-0x3f.
> The original value of 128 (0x7f) would also modify the
> CGAIN, which gives undesired results.
> Separate control for CGAIN?
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/twl4030.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 90f3b4d..95946d2 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -192,10 +192,10 @@ static void twl4030_init_chip(struct snd_soc_codec =
*codec)
>  static const struct snd_kcontrol_new twl4030_snd_controls[] =3D {
>  	SOC_DOUBLE_R("Master Playback Volume",
>  		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> -		0, 127, 0),
> +		0, 0x3f, 0),
>  	SOC_DOUBLE_R("Capture Volume",
>  		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> -		0, 127, 0),
> +		0, 0x3f, 0),
>  };
>  =

>  /* add non dapm controls */


-- =

P=E9ter
