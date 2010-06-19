From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] codecs/tlv320aic23: fix suspend/resume
Date: Sat, 19 Jun 2010 11:59:29 +0100
Message-ID: <20100619105929.GB2409@opensource.wolfsonmicro.com>
References: <1276937814-10510-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D490B10380D
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 12:59:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276937814-10510-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 10:56:54AM +0200, Eric B=E9nard wrote:
> The PWR register actually can't be restored at resume because its
> cached value was set to 0xFFFF when suspending and thus the initial
> state won't be restored. Thus, sound doesn't work after resume (tested
> on an i.MX27).

What is the actual problem here?

> +	/* backup PWR register */
> +	tmp =3D tlv320aic23_read_reg_cache(codec, TLV320AIC23_PWR);
> +	/* turn off the codec */
>  	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);

On power down we put the CODEC into BIAS_OFF...

> -	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> -

...then we bring the power back up on resume.  If there's a problem here
it looks like the bias management functions need fixing but without
knowing what the actual problem with the system is it's not clear what
this is supposed to fix.
