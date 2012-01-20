From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Improve hw_params documentation -- details of
 constraint resolution
Date: Fri, 20 Jan 2012 14:41:23 +0100
Message-ID: <4F196F03.8080002@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A41782ACA717@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B7A4C2470F
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2012 14:39:26 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 289FE216B7
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2012 08:39:23 -0500 (EST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41782ACA717@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> + *  When a parameter is set or restricted using a snd_pcm_hw_params_set*
> + *  function, all of the other ranges will be updated to exclude as many
> + *  impossible configurations as possible. Attempting to set a parameter
> + *  outside of its acceptable range will result in the function failing
> + *  and an error code being returned.
>
> I'd like to check whether that's exactly what's happening.
>
> 1. Consider the following scenario:
>
> set_hw_params_period_near([in,out]10ms,[out]dir)
> yields 16ms and direction=0 <=> "exact match"
>
> set_hw_params_buffer_size(X)
> set_hw_params()
>
> So far, I thought that if ALSA replied with direction=0, then that
> corner stone of the configuration space was fixed.

This has nothing to do with the dir parameter.

The period_time parameter is fixed when the set(_near) function
returns successfully.

The dir parameter tells whether the value is an exact integer,
or if it's smaller or larger (such as 15.9 or 16.667).

> OTOH, if constraint resolutions occurs at the time of set_hw_params()
> *again and finally*,

Indeed this occurs again because not all parameters might have been
reduced to a single value yet.

> ALSA may realize that the particularly large or
> small buffer size X is not reachable with the 16ms period, whereas
> a 50ms or 5ms period may allow buffer size X.
>
> So what is the outcome?
> b) revised 5 or 50ms period with buffer size X,
>    because 5 or 50ms is a near period?

Setting a parameter always happens in the context of the values of
any other parameters that have been set, and all rules and restrictions
implied by that.

Once a parameter has been reduced to a single value (or just to
a smaller interval), it cannot be changed back.

> c) 16ms period, error from set_buffer_size and success from set_hw_params
>    as ALSA chooses an arbitrary buffer size (typically 4-8 periods)?

Yes.

> The documentation may lead one to believe b) happens.

How so?

> 2.
> + *  Attempting to set a parameter
> + *  outside of its acceptable range will result in the function failing
> + *  and an error code being returned.
>
> That does not seem to apply to the set_*_near() functions.
>
> set_hw_params_period_time(2ms) may fail because it's too small for the
> device at hand, whereas set_hw_params_period_time_near(2ms) causes the
> smallest supported period to be chosen.  Does this need clarification
> or is using *_near not "attempting to set a parameter"?

set_*_near() searches for the nearest value in the acceptable range,
which it then attempts to set.

> *_min and *_max appear to behave likewise: they set lower and upper
> bounds without checking whether these are reachable.

They do not 'set' the value, they just restrict the acceptable range;
a limit that is outside the previously acceptable range is not an error
because this does not result in an 'impossible' configuration.
For example, assume that a device supports period times from 10 ms to
100 ms.  Calling set_period_time_min(2ms) means "I accept anything in
the range from 2 ms to infinity", so the resulting period time is the
interval from 10 ms to 100 ms (i.e., unchanged).  This is correct
because all values in this interval indeed are >= 2 ms.

set_period_time_min(2ms) would fail if the maximum period time is
already less than 2 ms, because then there wouldn't be any valid
period time value left.


Regards,
Clemens
