From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Constraints and hw_params with highly configurable
 HW
Date: Tue, 03 Sep 2013 19:58:04 +0200
Message-ID: <5226232C.5080803@ladisch.de>
References: <5226041B.4010105@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 88D67265354
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 19:58:51 +0200 (CEST)
In-Reply-To: <5226041B.4010105@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>
Cc: Daniel Weiss <weiss@weiss.ch>, alsa-devel@alsa-project.org, Rolf Anderegg <rolf.anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
> I'm currently debugging and fine-tuning things and that's where some
> questions arose. The initial implementation of Clemens tried to fetch
> all possible configurations of a device during probe in order to have
> all combinations of rates and channels at hand when it comes to
> formulate the constraints set within the ALSA pcm substream open
> callback. That's a nice approach but will fail with a lot of devices as
> their configurations can (and mostly will) be volatile. Our devices for
> instance feature several switches, options and alike which have heavy
> influence on the channel layout and sample rates and combination of both.

Then the constraints should be read from the device in the PCM open
callback.

(If the settings can be controlled by software, they should by locked
as long as some PCM device is open.)

> Therefore I had the idea to define some maximum constraints and let the
> ALSA hw_params callback fail in case some settings or combinations are
> determined to be not supported during its invocation.

It wouldn't be a nice thing to do for the driver to set constraints
that it already _knows_ it will not be able to support.

In the most common case, the hw_param callback happens immediately after
the open callback, so it makes sense for .open to set constraints that
reflect the current state of the device.  It is still possible for the
device state to change between .open and .hw_params, but that's the best
the driver can do.

(What happens if the user flicks a switch while the software is
playing?)

> would EINVAL an appropriate error code to return?

Yes.


Regards,
Clemens
