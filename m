From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Mon, 17 Dec 2018 21:32:42 +0100
Message-ID: <20181217203242.GB10938@gerhold.net>
References: <20181216185429.GA20408@gerhold.net>
 <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.219])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FCF0267AF9
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 21:32:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 17, 2018 at 01:39:13PM -0600, Pierre-Louis Bossart wrote:
> Thanks for the additional information.
> > The call to iosf_mbi_read() returns 0x400b0100
> > =

> > 	/* bits 26:27 mirror PMIC options */
> > 	bios_status =3D (bios_status >> 26) & 3;
> > =

> > Results in bios_status =3D 0x0
> So that's a fail.
> > =

> > The stock kernel printed this on every startup:
> > =

> > SPID updated according to ACPI Table:
> > 	spid customer id : 0000
> > 	spid vendor id : 0000
> > 	spid manufacturer id : 00ff
> > 	spid platform family id : 0007 --> INTEL_BYT_TABLET
> > 	spid product line id : 0000 --> INTEL_BYT_TABLET_BLK_PRO
> > 	spid hardware id : 0004 --> BYT_TABLET_BLK_8PR0 /* Bay Lake FFRD-8 PR0=
 */
> > 	spid fru[4..0] : 00 00 00 00 00
> > 	spid fru[9..5] : 00 00 00 00 00
> > =

> > Based on spid.h [1] I added the "-->" above. Then I guessed that this is
> > BYT-T (there is another "BYT T CR V2" value), but to be honest I don't
> > know for sure.
> > =

> > [1]: https://github.com/me176c-dev/me176c-kernel/blob/stock/kernel/arch=
/x86/include/asm/spid.h
> =

> Oh man, Bay Lake...this must be at least 6 years old and 30+ kernel versi=
ons
> behind... Only a couple of years and it'll be a collector item=A0 :-)
> =


Yeah, the device was shipped with a 3.10 kernel but I believe that file =

was just copied from an earlier 3.4 kernel. I have never bothered to even =

try to compile that thing, I just use it as reference every now and then. :)

> I can't recall any of the details so we'll have to wing it. it could be t=
hat
> it was baytrail-T but with the software/BIOS for Baytrail-Cr, who knows.
> =

> > =

> > > I don't mean to dismiss your claim, just want to find out if this is =
a case
> > > where the PMIC-type-based byt_cr detection fails or if we have a BIOS=
 issue.
> > > Another smoking gun is if you find in your code traces of SSP0 being =
used.
> > > =

> > The quirks to get sound working with bytcr-rt5640 on that device are:
> > BYT_RT5640_SSP0_AIF1 | BYT_RT5640_IN1_MAP | BYT_RT5640_MCLK_EN
> > =

> > I guess this means that SSP0 is being used?
> =

> Yes indeed, and that makes me think we should force this device to look l=
ike
> Baytrail-CR.
> =

> You can do this with a DMI-based quirk (preferably in is_byt_cr directly =
so
> that I can reuse the code when I move it to a helper at some point).

Okay - thanks! One last question:
I was looking at the ACPI DSDT tables of some similar devices and have =

found two others that look the same (only one IRQ listed). In this case, =

the BYT-T acpi_ipc_irq_index =3D 5 will never work, and we will definitely =

have a better chances with trying Baytrail-CR.

One of them actually had a similar patch proposed at [1] (although they =

did it in a weird way and also need an extra machine driver).

We could also detect this situation in a generic way with something like

  if (platform_irq_count(pdev) =3D=3D 1) {
  	*bytcr =3D true;
	return 0;
  }

... instead of a DMI quirk. What do you think?

[1]: https://patchwork.kernel.org/patch/9764493/#20539549

> =

> Also I guess you'd need a second quirk in bytcr_rt5640 since the default =
is
> SSP0-AIF2.
> =

> -Pierre
> =
