From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
	DAPM_SUPPLY to be used for dai
Date: Mon, 29 Aug 2011 14:41:30 +0300
Message-ID: <11979330.WnlDKWFkCB@barack>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<4740107.jCnGMjlvlq@barack>
	<20110829091603.GA9477@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A147C246CB
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 13:41:26 +0200 (CEST)
In-Reply-To: <20110829091603.GA9477@opensource.wolfsonmicro.com>
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

On Monday 29 August 2011 11:16:04 Mark Brown wrote:
> That's not what you said before...  I did post the sequence I was
> suggesting and you seemed fine with it.  Please try to be clear about
> what you're trying to do here - previously you'd just said that you
> needed to make sure the CODEC was powered down prior to the CPU being
> stopped but now you're adding additional stuff here.

Hrm, yes i did agreed with your sequence until I started to look at the oth=
er =

implications. However at least I was consistent in the commit messages abou=
t =

the sequence requirements (OMAP4 McPDM should be stopped after the codec's =

DAC/ADC).
 =

> Could you please clarify what exactly the system looks like here and
> what you need to do?  I'm struggling to understand how you've got PDM
> output links providing clocks back into the CPU - usually a PDM output
> is two wires going in one direction.

McPDM uses 5 wires.
clks is coming from the codec, and this signal is used within OMAP4 McPDM a=
s =

functional clock (we have frame sync, ul data, dl data, and clock loopback =

wires). Chapter 23.6.2.2 of OMAP4430_ES2.x_PUBLIC_TRM_vW.pdf

The sequence I'm looking for is:
1. pcm_trigger: stop DMA
2. DAPM sequence starts
3. DAC is turned off on the codec side
4. OMAP4 McPDM can be stopped - stop it
5. DAPM finishes up
6. codec can be turned off

> I also don't entirely understand
> why your current approach will be robust, though it should be an
> improvement on the original change to just put a delay in the shutdown.
> You can't rely on pmdown_time happening at all as it's user configurable
> and only happens for some cases even when it's there.

I'm not relaying on the pmdown_time but I'm relying on DAPM to handle the =

power down of the cpu_dai. The pmdown_time does not matter anymore.
I do not remember saying that it is robust, but I might meant that this =

approach needs small amount of code, and it is handled by a well tested/pro=
ven  =

piece of code (DAPM).

> Like I say I'm not convinced I understand what you need to do yet.  It
> would be easier if we could merge the updated McPDM driver and worry
> about this separately; I don't understand why you can't just inline the
> event into the regular teardown (it will be noisy but it should at least
> run).

OK, let's take this part out for now.

I'll send a single patch for replacing the legacy driver with the new one, =
but =

without the pop avoiding delay magic.

--
P=E9ter
