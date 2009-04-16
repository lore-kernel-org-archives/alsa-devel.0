From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 19:23:18 +0530
Message-ID: <dfeb90390904160653u2d56d6b3lcc927b593a8fc136@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
	<200904161642.07406.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B4A9243B9
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 15:53:20 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so272880tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:53:18 -0700 (PDT)
In-Reply-To: <200904161642.07406.peter.ujfalusi@nokia.com>
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

On Thu, Apr 16, 2009 at 7:12 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On Thursday 16 April 2009 16:05:34 ext Arun KS wrote:
>>
>> Your patches are working.
>> I tested for DSP_A and DSP_B. Both works fine on osk5912 board.
>
> Thank you very much for testing it!
>
>> But when I2S is used there is no audio on Right channel(left channel
>> is working fine).
>> Thinks something is missing on tlv320aic23 driver.
>
> I have tested the patch, which changes the way how the I2S mode is
> configured and it was working. Also the end result is the same in I2S mode
> as it was before...
> And an obvious question: was the I2S mode worked before my patches?
No. Have to figure it out.

>
> I suppose you used the SND_SOC_DAIFMT_NB_NF with the I2S mode as well (wh=
ich
> should be the correct one)?
Yes.

>
>> Arun
>
> --
> P=E9ter
