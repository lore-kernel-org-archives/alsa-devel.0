From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how is 'dir' in
 snd_pcm_hw_params_set_periods_near() supposed to work?
Date: Tue, 09 Sep 2008 10:02:15 +0200
Message-ID: <48C62D87.8090303@ladisch.de>
References: <20080908202808.GB5221@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7C7BA10380E
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:15 +0200 (CEST)
In-Reply-To: <20080908202808.GB5221@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> How is the 'dir' argument in snd_pcm_hw_params_set_periods_near()
> supposed to work?

Short answer: use NULL.

Long answer: Before calling the function, -1 means that the number of
periods must be less than 'val', 1 means greater.  After calling the
function, 'dir' is set to -1 to indicate that the actual number of
periods is less than 'val', etc.

> I'd assume that passing dir=1 would mean that it is looked for a
> number of periods that is greater *or equal* to what we request. [...]
> The docs don't really elaborate on this much.

While the docs don't really elaborate on anything, for any ALSA
function, in this case they actually say "<" and not "<=".

> I'd certainly think that having ">=" and "<=" here is much more useful
> and natural than ">" and "<", and hence I was wondering: is this just
> a bug in the software or is it really intended to be this way?

It's intended.

In the configuration space, parameters like the number of periods are
represented as an interval, i.e., as a minimum and a maximum value.
Since it is possible to have values that are not integers (e.g., buffer
size = 1000, period size = 400 => number of periods = 2.5), both bounds
of the interval can be 'open', i.e., the respective boundary value does
not belong the the interval.  In the above example, the minimum would be
2 and the maximum 3, with both values themselves excluded.

It is not very useful to set the 'dir' parameter before calling
snd_pcm_hw_params_set_periods_near(); if you don't want an exact value,
you're more likely to set an interval with *_set_*_min() and *_max()
anyway.

The 'dir' parameter is useful to determine, after the call, that the
value is not an integer.  In this case, <= or >= would not make sense.


Regards,
Clemens
