From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: ADAU1761 default register value problem
Date: Tue, 3 May 2016 10:16:51 +0200
Message-ID: <alpine.DEB.2.02.1605031003250.31333@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
 <571F2513.1020005@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8865C265019
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 10:17:12 +0200 (CEST)
In-Reply-To: <571F2513.1020005@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 26 Apr 2016, Lars-Peter Clausen wrote:

> On 04/21/2016 04:01 PM, Ricard Wanderlof wrote:
> > =

> > ...
> > The problem I have is that the driver assumes that the CODEC has been =

> > initialized with the default register settings when the system boots. =

> > However, if the system has not been power cycled but just rebooted, thi=
s =

> > is not necessarily the case, as the CODEC has no external reset pin but =

> > derives its reset signal internally from the power level.
> > ...

Sorry I haven't been able to respond earlier.

> I've been thinking about this for the last few days trying to come up wit=
h a
> good solution, but it is really difficult.
> =

> The issue you are describing is simply an oversight from my side.
> =

> One solution would be do drop the register default values and let regmap
> fill the register cache on demand when a read is done the first time for a
> register. The problem with this approach is that we leave the device in an
> unknown state when we probe the driver, but we really want to have it in a
> known state of lowest power.
> =

> The alternative is to write out the register defaults when the device is
> probed, sort of a poor mans software reset, this brings us into a known
> state. This approach has the downside that there is the overhead of having
> to write all registers.
> =

> I don't like either, but given the limitations of the hardware we'll have=
 to
> choose one and in that case I'd slightly lean towards the later solution =
has
> it gives us consistent and predictable behavior and the overhead of writi=
ng
> the registers should be manageable.

Either way, there will be a fair amount of communication with the codec, =

either as a result of setting the default values, or as a result of =

reading the existing ones in order to determine what would be necessary to =

write.

I would think that having the codec in a controlled known (low power) =

state would tip the balance in favor of the second solution.

One question is though should one write out _all_ registers, including =

those not actually used by the driver? I'm thinking of an =

upgrade/downgrade situation, where a previously running kernel version has =

set up a register which the currently running version doesn't need to =

touch.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
