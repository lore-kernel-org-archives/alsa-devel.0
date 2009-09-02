From: "Narnakaje, Snehaprabha" <nsnehaprabha-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 2/2] ASoC: Davinci: Add audio codec support for DM365
 EVM
Date: Wed, 2 Sep 2009 15:49:52 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0129C1B6D4@dlee02.ent.ti.com>
References: <1251904514-7661-1-git-send-email-miguel.aguilar@ridgerun.com>
	<7A436F7769CA33409C6B44B358BFFF0C0129C1B661@dlee02.ent.ti.com>
	<4A9ED54B.2060504@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A9ED54B.2060504-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Cc: "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Miguel,

Comments below -


<snip>

> >>
> >> +config  SND_DM365_SOC_EVM
> >> +	tristate "SoC Audio support for DaVinci DM365 EVM"
> >> +	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM365_EVM
> >> +	select SND_DAVINCI_SOC_I2S
> >> +	select SND_SOC_TLV320AIC3X
> >> +	help
> >> +	  Say Y if you want to add support for SoC audio on TI
> >> +
> >
> > Do you really need a separate Kconfig option for DM365? Can we re-use
> the SND_DAVINCI_SOC_EVM for DM6446, DM355 and DM365?
> I think this would be fine, actually we can reuse more than just
> SND_DAVINCI_SOC_EVM, we can also reuse evm_snd_devdata because the only
> difference with DM6446 and DM355 is just the name used in
> dm365_snd_soc_card_evm. See one more comment below.

Yes, you can now reuse evm_snd_devdata. Earlier we had the i2c_address main=
tained in this file, so it the structure had to be different for DM365.

<snip>

> >> +
> >> +/* evm audio subsystem */
> >>  static struct snd_soc_device dm6467_evm_snd_devdata =3D {
> >>  	.card =3D &dm6467_snd_soc_card_evm,
> >>  	.codec_dev =3D &soc_codec_dev_aic3x,
> >> @@ -249,6 +265,9 @@ static int __init evm_init(void)
> >>  	} else if (machine_is_davinci_dm355_evm()) {
> >>  		evm_snd_dev_data =3D &evm_snd_devdata;
> >>  		index =3D 1;
> >> +	} else if (machine_is_davinci_dm365_evm()) {
> >> +		evm_snd_dev_data =3D &dm365_evm_snd_devdata;
> >> +		index =3D 0;
> So we can reuse evm_snd_devdata and use it instead of evm_snd_devdata,
> this is use:
>=20
> evm_snd_dev_data =3D &evm_snd_devdata;
>=20
> instead of:
>=20
> evm_snd_dev_data =3D &dm365_evm_snd_devdata;
>=20
>=20
> What do you think about this?

OK, you can change this to reuse the evm_snd_devdata structure.

Thanks
Sneha

>=20
> >>  	} else if (machine_is_davinci_dm6467_evm()) {
> >>  		evm_snd_dev_data =3D &dm6467_evm_snd_devdata;
> >>  		index =3D 0;
> >> --
> >> 1.6.0.4
> >>
> >
>=20
>=20
