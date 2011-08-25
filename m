From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa timing question
Date: Thu, 25 Aug 2011 09:15:46 +0200
Message-ID: <4E55F6A2.3040307@ladisch.de>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B52F110380B
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 09:15:46 +0200 (CEST)
In-Reply-To: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> I'm working on an application where I'd like to have relatively fixed timing
> between calls to snd_pcm_writei.

Why?

> [...] I see is that most calls to snd_pcm_writei are spaced about 50 ms
> apart.  This makes some sense, but I was expecting the calls to be about
> 42.67 ms apart.  However, about every 6th call, the time is just 200 us
> or so.  Why is that?

In theory, when the device is configured for a specific period size, its
interrupts (and therefore the application wakeups) will arrive spaced at
this interval (modulo any scheduling delays).

However, if you're using the dmix plugin, the period size of your
application's device will not necessarily be identical with the period
size of the hardware device.  To see the actual period size, look into
/proc/asound/card?/pcm0p/sub0/hw_params.


Regards,
Clemens
