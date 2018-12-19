From: Antonio Ospite <ao2@ao2.it>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Wed, 19 Dec 2018 21:59:11 +0100
Message-ID: <20181219215911.6876b18d44c34318fe01a650@ao2.it>
References: <20181216185429.GA20408@gerhold.net>
 <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net>
 <20181217204320.GC10938@gerhold.net>
 <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
 <20181219130747.GA83656@gerhold.net>
 <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
 <fae4f9e7-5ec6-307f-c862-47f25dbc2cfc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (mail.ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 938EA26782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 21:59:13 +0100 (CET)
In-Reply-To: <fae4f9e7-5ec6-307f-c862-47f25dbc2cfc@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Dec 2018 15:23:13 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> =

> On 19-12-18 15:04, Pierre-Louis Bossart wrote:
> > On 12/19/18 7:07 AM, Stephan Gerhold wrote:
[...]
> >> I have tested the patch above on my device with:
> >> =A0 - as-is, without any modifications:
> >> =A0=A0=A0=A0 -> "Falling back to Baytrail-CR platform", sound now work=
ing
> >> =A0 - a simulated "BYT-T" device: (copied the IRQs from the DSDT of th=
e T100TA)
> >> =A0=A0=A0=A0 -> "BYT-CR not detected" - uses 5th IRQ, sound working
> >> =A0 - a simulated "BYT-CR" device (made is_byt_cr() return "true" and
> >> =A0=A0=A0 copied the IRQs from the DSDT of the T100TAF)
> >> =A0=A0=A0=A0 -> "Detected Baytrail-CR platform" - uses IRQ at index 0,=
 sound working
> >>
> >> Let me know what you think!
> > =

> > Sounds good, playing with resources is what I had in mind rather than a=
n interrupt count which isn't necessarily safe. The only improvement I woul=
d suggest is to add this test inside of is_byt_cr(). This routine will be m=
oved as a helper outside of sst_acpi to be reused for SOF, so if we can mak=
e this test more self-contained it's more future-proof.
> =

> AFAICT this will not fix all cases of this, so it might be better to see =
if
> we can make is_byt_cr() return true on these devices in some other way.
> =

> E.g. the "Teclast X98 Air 3G" Antonio reported does list 5 IRQs, but we
> should still use the first IRQ and not the 5t.
> =

> Antonio, do you know if your device uses SSP0 ?
> =


TBH I don't remember off the top of my head, I'll check my notes and
get back on that when I also report back about recent kernels on my
device.

Ciao,
   Antonio

-- =

Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
