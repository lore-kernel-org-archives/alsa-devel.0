From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/8] ASoC: TWL4030: DAPM implementation for
	outputs (playback)
Date: Tue, 9 Dec 2008 12:07:53 +0200
Message-ID: <200812091207.53905.peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<200812090851.58378.peter.ujfalusi@nokia.com>
	<20081209094700.GA1630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A1F3F10383C
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:08:17 +0100 (CET)
In-Reply-To: <20081209094700.GA1630@sirena.org.uk>
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


On Tuesday 09 December 2008 11:47:01 ext Mark Brown wrote:
> On Tue, Dec 09, 2008 at 08:51:58AM +0200, Peter Ujfalusi wrote:
> > As I see: when the twl4030_power_down is called from the
> > twl4030_set_bias_level (SND_SOC_BIAS_STANDBY, SND_SOC_BIAS_OFF) it sets
> > the codec to power-off state (CODEC_MODE:CODECPDZ =3D 0), which effecti=
vely
> > turns off the digital filter, analog section, so basically everything.
> > When the CODECPDZ is 0, APGA, DAC, analog output settings have no effect
> > (they are powered off)
>
> Right, that's what I thought.  You'll need to fix this in order to use
> bypass paths since it will turn off the analogue.

Yes, that is true.

My plan is (yes I do have one):
1. Proper (at least as close to) implementation for the playback path(s)
2. Proper capture implementation (DAPM, etc)
3. Adding the bypass routes
4. The driver is kind of feature complete

-- =

P=E9ter
