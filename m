From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/8] ASoC: TWL4030: DAPM implementation for
	outputs (playback)
Date: Tue, 9 Dec 2008 08:51:58 +0200
Message-ID: <200812090851.58378.peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<20081208132040.GJ5159@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A41791037F1
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 07:52:05 +0100 (CET)
In-Reply-To: <20081208132040.GJ5159@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Monday 08 December 2008 15:20:41 ext Mark Brown wrote:
> On Mon, Dec 08, 2008 at 10:09:00AM +0200, Peter Ujfalusi wrote:
> > Based on the output routing selections all the corresponding DAC and
> > analog PGA on the chain will be powered on.
>
> One other question: how does this all interact with the existing power
> control in set_bias_level()?

This is a good question.
As I see: when the twl4030_power_down is called from the =

twl4030_set_bias_level (SND_SOC_BIAS_STANDBY, SND_SOC_BIAS_OFF) it sets the =

codec to power-off state (CODEC_MODE:CODECPDZ =3D 0), which effectively tur=
ns =

off the digital filter, analog section, so basically everything.
When the CODECPDZ is 0, APGA, DAC, analog output settings have no effect (t=
hey =

are powered off)

-- =

P=E9ter
