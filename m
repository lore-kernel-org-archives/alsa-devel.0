From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
Date: Tue, 7 Dec 2010 10:52:55 +0200
Message-ID: <201012071052.56009.peter.ujfalusi@nokia.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id D6F65103801
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 09:52:59 +0100 (CET)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7F@dlee06.ent.ti.com>
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
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 December 2010 00:34:40 ext Olaya, Margarita wrote:
> @@ -623,6 +652,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct
> snd_soc_dai *cpu_dai, if (cpu_class_is_omap1()) {
>  			err =3D -EINVAL;
>  			break;
> +		} else if (cpu_is_omap44xx()) {
> +			regs->srgr2     |=3D CLKSM;
> +			break;

Are you sure about this?
You want to select FCLK as functional clock...
So I think you want to have the source from CLKS, and CLKS should have the =

FCLK selected, so I think you want:
~CLKSM in srgr2, and ~CLKME in pcr0

>  		}
>  		err =3D omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
>  					       MCBSP_CLKS_PRCM_SRC);


-- =

P=E9ter
