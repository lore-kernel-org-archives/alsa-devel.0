From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY?on
	headsetl_event: POST_PMD
Date: Mon, 18 May 2009 10:46:17 +0300
Message-ID: <200905181046.17781.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090514125333.GA9471@rakim.wolfsonmicro.main>
	<200905150930.08224.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 14F10244C7
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 09:46:45 +0200 (CEST)
In-Reply-To: <200905150930.08224.peter.ujfalusi@nokia.com>
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
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "getarunks@gmail.com" <getarunks@gmail.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday 15 May 2009 09:30:08 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Thursday 14 May 2009 15:53:34 ext Mark Brown wrote:
> > It might help to have the mixers and muxes maintain some state when they
> > change?  It's just a suggestion, I'm not familiar enough with the codec
> > to know if it's a sensible one for this device or if it's more trouble
> > than it's worth.
>
> I have given this one a though and it might be not that problematic. What
> I'm afraid is that there are some corner cases, which might need some
> special attention.

I have tried this. Worked well with the playback stop/start, but than getti=
ng =

the loopbacks working again proven to be close to impossible...
Anyway I have tried another approach, which seams to be working in all =

scenarios for the twl4030 codec.
It does not involve changes outside of the twl4030.c.
I will clean up the code and send the patches for testing.
In short:
I have moved the APGA control from the SND_SOC_DAPM_PGA to SND_SOC_DAPM_MIX=
ER, =

also I have added another level of mixer for the digital path, which actual=
ly =

controls the DAC state.
Than I have SND_SOC_DAPM_PGA_E for the headset outputs.

Now the power up and power down order is correct and a minimal (almost no) =
pop =

can be heard on startup and on standby.

I know that this is kind of a hack, but there seams to be no other way to =

handle the twl4030 codec power on/off sequences.

-- =

P=E9ter
