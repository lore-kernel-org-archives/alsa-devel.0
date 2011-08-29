From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
	DAPM_SUPPLY to be used for dai
Date: Mon, 29 Aug 2011 11:22:52 +0300
Message-ID: <4740107.jCnGMjlvlq@barack>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<1314365603-8947-3-git-send-email-peter.ujfalusi@ti.com>
	<20110826190420.GA2943@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C83E524534
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 10:22:46 +0200 (CEST)
In-Reply-To: <20110826190420.GA2943@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 26 August 2011 21:05:02 Mark Brown wrote:
> This wasn't really what I meant - what I meant was that we ought to be
> able to change the ordering of DAPM with regard to the stream shutdown
> without having to have anything more than flags in the devices that can
> or need to do it (I'd expect more the CODECs more than the CPUs).

I see, but this is not what I'm trying to achieve here.
Even, if we could re-order the stream shutdown (for DAIs mostly) and DAPM =

sequence it won't work for me:
I need to make sure that the cpu_dai (McPDM) is shut down _after the DAC/AD=
C, =

and _before_ the codec is powered down - which would stop the McPDM clocks =
- =

which in turn used by McPDM as functional clock.
So if we would somehow execute the DAPM first followed by the stream shutdo=
wn, =

I can be in a situation, when McPDM is not accessible (missing clocks).

If we really want to reorder the stream shutdown and DAPM, we need to quite=
 a =

bit of change, since we need to be able to 'delay' the shutdown operations =
for =

DAIs/platforms at least. But. Since the stream has been already closed, we =
can =

not refer to it anymore in case of pmdown_time > 0 (playback only issue).

One way would be to have special DAPM widget for DAI/platform event, and ho=
ok =

that up somewhere at some point that it will do what it is intended to be =

doing.
Or some callback function for DAIs/platforms, which would be called from th=
e  =

dapm_power_widgets function.

These would work, mostly, but I'm not convinced, that it would work for me,=
 so =

I anyway need to do something similar as in this series.

--
P=E9ter
