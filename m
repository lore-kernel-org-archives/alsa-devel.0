From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 18:35:34 +0530
Message-ID: <dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FB982438D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 15:05:36 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so261034tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:05:34 -0700 (PDT)
In-Reply-To: <200904161427.30707.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 4:57 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On Thursday 16 April 2009 14:20:36 ext Arun KS wrote:
>> Hi Guys,
>>
>> I had done some mistake while applying the Jarkko's patch previously.
>> Now its working fine.
>> Sorry for the confusion caused.
>
> :)
> I have digged out an old omap1510 TRM to see what is going on...
>
> Still, while you have the setup, can you give my two patch a try on OMAP1=
 to
> see if it is working correctly?

Your patches are working.
I tested for DSP_A and DSP_B. Both works fine on osk5912 board.

But when I2S is used there is no audio on Right channel(left channel
is working fine).
Thinks something is missing on tlv320aic23 driver.

Arun

>
>>
>> Arun
>>
>> > Jarkko
>
> --
> P=E9ter
