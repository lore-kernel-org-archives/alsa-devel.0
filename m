From: Uli Franke <uli.franke@weiss.ch>
Subject: Re: Constraints and hw_params with highly configurable
 HW
Date: Wed, 04 Sep 2013 11:42:09 +0200
Message-ID: <52270071.9030500@weiss.ch>
References: <5226041B.4010105@weiss.ch> <5226232C.5080803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [80.190.249.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3392654D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 11:42:10 +0200 (CEST)
In-Reply-To: <5226232C.5080803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Daniel Weiss <weiss@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rolf Anderegg <Rolf.Anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

> Then the constraints should be read from the device in the PCM open
> callback.

No, that's not possible as the constraints will/can change in case you
request a different sample rate for instance. Therefore the constraints
won't be known until you set the rate for instance. And you will never
be able to pre-fetch this information reliably as the DICE firmware is
allowed to change its setup arbitrarily.

> (If the settings can be controlled by software, they should by locked
> as long as some PCM device is open.)

This is obvious and is implemented like this.

But you have to keep in mind that there are other things which can not
be locked. For instance the locking: If a device is synchronized to an
external clock source, this clock source can disappear or be
reconfigured at any time. How the device behaves in such situations
depends strongly on the firmware. For example some devices provide
autolocking which scans for lockable clocks in all frequency ranges.
Others simply switch to internal clock. In all those situations its very
likely that the stream layout will change. Even the clock caps can
change at any time.

>> Therefore I had the idea to define some maximum constraints and let the
>> ALSA hw_params callback fail in case some settings or combinations are
>> determined to be not supported during its invocation.
> 
> It wouldn't be a nice thing to do for the driver to set constraints
> that it already _knows_ it will not be able to support.

Of course the driver should not set constraints which will never be
supported. We're discussing the constraints which can not be determined
without knowing some actual parameters.

As far as I can deduce from the call sequence the constraints are just a
convenient way to let the user space open fail before .hw_params is
actually called and free the programmer from the burden to formulate
those similar and recurring checks over and over again in case the
device constraints are static.

If the device reveals certain constraints only when some parameters are
actually set and if the parameters are only known at .hw_param time, the
constraint system must be bypassable. I don't see any drawback from this
for other parts of the system. It only shows that the ALSA API simply
can not abstract all devices perfectly. But that's OK and normal in real
world applications. The important thing is that the user space
application can assume equivalent behavior in either case. That's what's
we're heading for.

Again: If I should miss something: I'm curious to learn about it.

> In the most common case, the hw_param callback happens immediately after
> the open callback, so it makes sense for .open to set constraints that
> reflect the current state of the device. 

Yes, but the "current state of the device" is not valid until you set
the actual parameters which are not known at .open time.

> It is still possible for the
> device state to change between .open and .hw_params, but that's the best
> the driver can do.
> 
> (What happens if the user flicks a switch while the software is
> playing?)

If the user flicks a switch while the software is playing the driver
will get a notification and should take the appropriate measures to
handle the new setup in case it changed. The driver already has been
adapted to do so. For instance
 * react on locking events: pausing the PCM substreams in case the lock
    is lost
 * react on isochronous stream reconfiguration events: continue
    streaming when isochronous layout is compatible, kill streaming
    if not

>> would EINVAL an appropriate error code to return?
Great.

Regards
Uli
