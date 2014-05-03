From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add codec driver
Date: Sat, 3 May 2014 10:42:37 -0700
Message-ID: <20140503174237.GF22111@sirena.org.uk>
References: <1398686350-29771-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5365130617110551127=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3581261675
 for <alsa-devel@alsa-project.org>; Sat,  3 May 2014 19:42:50 +0200 (CEST)
In-Reply-To: <1398686350-29771-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5365130617110551127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 07:59:10PM +0800, Oder Chiou wrote:
> This patch adds the Realtek ALC5645 codec driver. It is the base
> version that because the jack detect function is not implemented to
> it, the headphone and AMIC1 are not workable. We will fill up the
> further functions later.

Applied, thanks.  Like I previously said it really does look like there
is a lot of opportunity to share code here with the other similar
drivers, please look into doing something like the arizona drivers.
Also...

> +	/* I2S2 function select */
> +	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
> +		1, 1),

What functions is this switching?

> +	/* TDM */
> +	SOC_ENUM("TDM Adc Slot0 1 Data", rt5645_tdm_adc_slot0_1_enum),
> +	SOC_ENUM("TDM Adc Slot2 3 Data", rt5645_tdm_adc_slot2_3_enum),
> +	SOC_ENUM("TDM Adc Slot4 5 Data", rt5645_tdm_adc_slot4_5_enum),
> +	SOC_ENUM("TDM Adc Slot6 7 Data", rt5645_tdm_adc_slot6_7_enum),
> +	SOC_ENUM("TDM IF1 ADC DATA Sel", rt5645_tdm_adc_sel_enum),
> +	SOC_SINGLE("TDM IF1_DAC1_L Sel", RT5645_TDM_CTRL_3, 12, 7, 0),
> +	SOC_SINGLE("TDM IF1_DAC1_R Sel", RT5645_TDM_CTRL_3, 8, 7, 0),
> +	SOC_SINGLE("TDM IF1_DAC2_L Sel", RT5645_TDM_CTRL_3, 4, 7, 0),
> +	SOC_SINGLE("TDM IF1_DAC2_R Sel", RT5645_TDM_CTRL_3, 0, 7, 0),

These look like they should be part of DAPM, they're about routing data
as far as I can tell.

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZSqJAAoJELSic+t+oim9fnwP/2FGl+CU4Ft/93WCYkwVm85e
3PoD2TzofC32vDUMmwVVixxN0f44kRE8URl1Ukl31k8O3Q3aLOvlsJ8MxyLoM1VO
jU6cPL2B+dNzGap/BiLcqFxBuHP/G2Je85TymvVFg9VbF2sxy1AS0deZk5Bue500
RTIwLFOko7sHgVsX6D/dT7Xy5pFicCQi3sfWI3U5FVHApYSfN1TikyEA79lJj7Tq
NYbGwlWWbzILVlr2wRejXfm+zRde+zqwJg0AF9QVPr4ix4ws84tQOXmjg5orXIGa
T1HcZTC4aFtX+XT+Jdy/PQyeP4aOhcUrUchO1xcc2u9s7vhJaUsciRhKW2b9Xxhy
JDx4FtVBvkCrKcayjeCOqSKcDAsjdTisb3tWG7DVoc19FjJfLMFLso9B/bbSBBDm
OU06ChEdyL0fE79X86cOcm46uHFVGxHAQujs1I2zS7rRp3EAhzWqulIa5f6nAIeF
NAFBSaQ1ZE+AgOYf73ey3X/tsfyT0oLGwRlhuD67q4ZVxfzlL7gYS9IuzgxzKf5h
vkGudvRDnTSb91TqYEIEoHwfs6nxxkBLURxSCiZuH59hbcqMLTZpby/CKxvbo9HB
zotqVHVakC9sOI05nuSo/cL2bHSJa/bazXMhtmsuPdyQAlQZORmePflNVGvfLDN+
cND1nQgUDZfcOfNCQtPZ
=uu6U
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--

--===============5365130617110551127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5365130617110551127==--
