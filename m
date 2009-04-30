From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Disable DACs in analog
	loopback
Date: Thu, 30 Apr 2009 14:04:42 +0300
Message-ID: <200904301404.42185.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
	<200904301328.48853.peter.ujfalusi@nokia.com>
	<2C7D3DF36ADFFC479B44490D912B616705F63E05C4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 03D021037F3
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 13:04:45 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E05C4@dlee07.ent.ti.com>
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
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 30 April 2009 13:53:19 ext Lopez Cruz, Misael wrote:
> I got your point, thanks for the explanation. I think that we can take
> this part of the patch:
>
> +	/* Enable master analog loopback mode if any analog switch is enabled*/
> +	misc =3D twl4030_read_reg_cache(w->codec, TWL4030_REG_MISC_SET_1);
> +	if (twl4030->bypass_state & 0xF)
> +		misc |=3D TWL4030_FMLOOP_EN;
> +	else
> +		misc &=3D ~TWL4030_FMLOOP_EN;
> +	twl4030_write(w->codec, TWL4030_REG_MISC_SET_1, misc);
>
> This bit MISC_SET_1[FMLOOP_EN] needs to set to 1 when any of the analog
> bypass switches are enabled. Without setting this bit, the loopback is
> kind of weak.
>
> If it's fine for you, I can create a new patch for supporting the
> VDL analog bypass switch and add above change in that same patch.

Yes, this is fine. Please send those as a separate patch (the above mention=
ed =

and the VDL analog bypass).

Thank you,
P=E9ter
