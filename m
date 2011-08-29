From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
 DAPM_SUPPLY to be used for dai
Date: Mon, 29 Aug 2011 10:16:04 +0100
Message-ID: <20110829091603.GA9477@opensource.wolfsonmicro.com>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<1314365603-8947-3-git-send-email-peter.ujfalusi@ti.com>
	<20110826190420.GA2943@opensource.wolfsonmicro.com>
	<4740107.jCnGMjlvlq@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A8BA24575
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 11:16:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4740107.jCnGMjlvlq@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2011 at 11:22:52AM +0300, P=E9ter Ujfalusi wrote:
> On Friday 26 August 2011 21:05:02 Mark Brown wrote:
> > This wasn't really what I meant - what I meant was that we ought to be
> > able to change the ordering of DAPM with regard to the stream shutdown
> > without having to have anything more than flags in the devices that can
> > or need to do it (I'd expect more the CODECs more than the CPUs).

> I see, but this is not what I'm trying to achieve here.
> Even, if we could re-order the stream shutdown (for DAIs mostly) and DAPM =

> sequence it won't work for me:
> I need to make sure that the cpu_dai (McPDM) is shut down _after the DAC/=
ADC, =

> and _before_ the codec is powered down - which would stop the McPDM clock=
s - =

> which in turn used by McPDM as functional clock.

That's not what you said before...  I did post the sequence I was
suggesting and you seemed fine with it.  Please try to be clear about
what you're trying to do here - previously you'd just said that you
needed to make sure the CODEC was powered down prior to the CPU being
stopped but now you're adding additional stuff here.

Could you please clarify what exactly the system looks like here and
what you need to do?  I'm struggling to understand how you've got PDM
output links providing clocks back into the CPU - usually a PDM output
is two wires going in one direction.  I also don't entirely understand
why your current approach will be robust, though it should be an
improvement on the original change to just put a delay in the shutdown.
You can't rely on pmdown_time happening at all as it's user configurable
and only happens for some cases even when it's there.

> If we really want to reorder the stream shutdown and DAPM, we need to qui=
te a =

> bit of change, since we need to be able to 'delay' the shutdown operation=
s for =

> DAIs/platforms at least. But. Since the stream has been already closed, w=
e can =

> not refer to it anymore in case of pmdown_time > 0 (playback only issue).

Part of what I'm suggesting is that we may as well not bother with the
pmdown_time timeout if we need to shut the DAI down while we're shutting
the CODEC down anyway, the whole thing may as well get shut down at once
which will be a little more power efficient.

> These would work, mostly, but I'm not convinced, that it would work for m=
e, so =

> I anyway need to do something similar as in this series.

Like I say I'm not convinced I understand what you need to do yet.  It
would be easier if we could merge the updated McPDM driver and worry
about this separately; I don't understand why you can't just inline the
event into the regular teardown (it will be noisy but it should at least
run).
