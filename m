From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: TWL4030: Use usleep_range when
	appropriate
Date: Fri, 22 Oct 2010 15:23:56 +0300
Message-ID: <201010221523.57077.peter.ujfalusi@nokia.com>
References: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
	<1287749481-12203-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 65CAE24439
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 14:23:59 +0200 (CEST)
In-Reply-To: <1287749481-12203-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 22 October 2010 15:11:21 ext Peter Ujfalusi wrote:
> Change the busy loop delays with usleep_range or msleep calls.

> -	/* wait for offset cancellation to complete */
> +	/*
> +	 * Wait for offset cancellation to complete.
> +	 * Since this takes a while, do not slam the i2c.
> +	 * The least amount of time is not known, but measurement showed, that
> +	 * the cancelation usually finishes 20 - 28 ms, when
> +	 * TWL4030_OFFSET_CNCL_SEL =3D=3D 1.
> +	 * Start polling the status after 10ms.
> +	 */
> +	usleep_range(10000, 11000);
>  	do {
>  		/* this takes a little while, so don't slam i2c */

I'll resend, and remove this comment, since it is not needed anymore...

> -		udelay(2000);
> +		usleep_range(1000, 2000);
>  		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
>  				    TWL4030_REG_ANAMICL);
>  	} while ((i++ < 100) &&


-- =

P=E9ter
