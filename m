From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 12:19:41 +0300
Message-ID: <200905141219.41387.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905141109.09084.peter.ujfalusi@nokia.com>
	<20090514120550.88494822.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A302D243B8
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:19:48 +0200 (CEST)
In-Reply-To: <20090514120550.88494822.jhnikula@gmail.com>
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
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 12:05:50 ext Jarkko Nikula wrote:
> Did you implement this fake or actually real PGA between "HeadsetL
> Mixer" and "HSOL"?
>
> I seems that there is an error in audio path that output pin control is
> tied to mixer and there is no widget in audio path defining the output
> amplifier. See
>
> SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
> 	&twl4030_dapm_hsol_controls[0],
> 	ARRAY_SIZE(twl4030_dapm_hsol_controls), headsetl_event,
> 	SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
> ...
> 	{"HSOL", NULL, "HeadsetL Mixer"},
> 	{"HSOR", NULL, "HeadsetR Mixer"},

I have this:
 SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
 	&twl4030_dapm_hsol_controls[0],
 	ARRAY_SIZE(twl4030_dapm_hsol_controls), headsetl_event,
 	SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
...
	SND_SOC_DAPM_PGA_E("HeadsetL fake PGA", SND_SOC_NOPM,
			0, 0, NULL, 0, headsetlfake_event,
 	SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
...
	{"HeadsetL Mixer", "Voice", "VDL_APGA"},
	{"HeadsetL Mixer", "AudioL1", "ARXL1_APGA"},
	{"HeadsetL Mixer", "AudioL2", "ARXL2_APGA"},
	{"HeadsetL fake PGA", NULL, "HeadsetL Mixer"},
...
	{"HSOL", NULL, "HeadsetL fake PGA"},

I have moved the code form the headsetl_event to headsetlfake_event, so the =

ramp is configured in the fake PGA event handler.

>
> So startup/shutdown order should be correct if you define a new PGA
> between the HSOx and Headsetx mixer and let that to manage output pin
> power.

The order between the PGAs are not correct for the startup. In playback cas=
e =

we have two PGA with this new 'fake PGA':
ARXL2_APGA and the "HeadsetL fake PGA"

DAPM is handling first the "HeadsetL fake PGA" than the ARXL2_APGA both for =

startup and for standby. For standby it is OK, but for startup the ARXL2_AP=
GA =

should be handled prior to the "HeadsetL fake PGA" =3D> in reverse order.

-- =

P=E9ter
