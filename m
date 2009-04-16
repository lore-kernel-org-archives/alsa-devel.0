From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 16:50:36 +0530
Message-ID: <dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
	<dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
	<20090416101216.GI16318@sirena.org.uk>
	<dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
	<20090416101945.GJ16318@sirena.org.uk>
	<20090416133143.10cbd1bf.jarkko.nikula@nokia.com>
	<20090416103358.GL16318@sirena.org.uk>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id DA1E210381E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:20:37 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so231867tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 04:20:36 -0700 (PDT)
In-Reply-To: <20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 4:17 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wr=
ote:
> On Thu, 16 Apr 2009 12:33:58 +0200
> ext Mark Brown <broonie@sirena.org.uk> wrote:
>
>> On Thu, Apr 16, 2009 at 01:31:43PM +0300, Jarkko Nikula wrote:
>> > ext Mark Brown <broonie@sirena.org.uk> wrote:
>>
>> > > Could you try the test with no data on the left channel? =A0I
>> > > suspect that the LSB of the left channel may be being processed
>> > > as the MSB of the right channel.
>>
>> > I'm wondering why the left channel is still playing fine?
>>
>> If you drop the LSB of data it will normally sound fine but the signal
>> level will be reduced - the effects are much less obvious when testing
>> by ear than errors in the MSB.
>
> I meant if there is one bit difference or bit clock polarity is wrong
> then the both channels should be corrupted? At least the AIC33 is
> behaving so.
>
> I was thinking can the codec go out-of-sync during bit transmission
> of left followed by right channel data and resynchronize back after next
> FS change but this really sounds bit too far reason to me.

Hi Guys,

I had done some mistake while applying the Jarkko's patch previously.
Now its working fine.
Sorry for the confusion caused.

Arun
>
>
> Jarkko
>
