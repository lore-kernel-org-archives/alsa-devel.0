From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Re: Pop and offsets at start of audio playback/record
 for SGTL5000 on i.MX28
Date: Mon, 17 Nov 2014 11:35:07 +1100
Message-ID: <546942BB.8070804@beamcommunications.com>
References: <54655E35.9000807@beamcommunications.com>	<CAOf5uwkh7inpgOO8affswziTnKV3-9_4U6v2G55JnTHb-RkCyA@mail.gmail.com>	<546561D0.9090401@beamcommunications.com>
 <CAOf5uw=weZczcJNegd6P9Q7tnE3grbiLzYUHJo6xEOijYfeDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0056.outbound.protection.outlook.com [134.170.140.56])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E31E2612D6
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 01:35:21 +0100 (CET)
In-Reply-To: <CAOf5uw=weZczcJNegd6P9Q7tnE3grbiLzYUHJo6xEOijYfeDRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14/11/14 13:04, Michael Trimarchi wrote:
>
> Hi
>
> Il 14/nov/2014 09:58 "Craig McQueen" 
> <craig.mcqueen@beamcommunications.com 
> <mailto:craig.mcqueen@beamcommunications.com>> ha scritto:
> >
> > On 14/11/14 12:45, Michael Trimarchi wrote:
> >>
> >> Hi
> >>
> >> Il 14/nov/2014 09:44 "Craig McQueen" 
> <craig.mcqueen@beamcommunications.com 
> <mailto:craig.mcqueen@beamcommunications.com>> ha scritto:
> >> >
> >> > I'm testing the 3.14.19 kernel for i.MX28 EVK, which has an 
> SGTL5000 CODEC. I've also tested on the 3.18-rc4 kernel and confirmed 
> this issue still occurs.
> >> >
> >>
> >> Are you using it in master or slave mode?
> >
> >
>
> Try to change the pin mux of data line in order to be hz in idle mode 
> and add a small pull down resistor. Can you check if the dataline is 
> up when clocks go off?
>

Is it the I2S_DIN pin you're referring to?

This is the Freescale i.MX28 EVK we're talking about, so it's best to 
have a software fix that works on the stock EVK hardware. I'm checking 
the schematics and I don't see a pull-down. The following is in the 
imx28.dtsi device tree source:

                 saif0_pins_b: saif0@1 {
                     reg = <1>;
                     fsl,pinmux-ids = <
                         MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK
                         MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK
                         MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0
                     >;
                     fsl,drive-strength = <MXS_DRIVE_12mA>;
                     fsl,voltage = <MXS_VOLTAGE_HIGH>;
                     fsl,pull-up = <MXS_PULL_ENABLE>;
                 };

However on the i.MX28 I don't think the SAIF0_SDATA0 pin actually has a 
pull-up (only a few pins do).

Anyway, I will look into that soon.

-- 
Craig McQueen
