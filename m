From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Input/output error while playing a file using aplay
Date: Mon, 25 Jun 2007 13:00:39 +0200
Message-ID: <1182769239.15228.1196888507@webmail.messagingengine.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 40B462434C
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 13:00:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> >The ALSA framework will stop the stream and return the error code EIO
> >when there was no interrupt for ten seconds, i.e., when
> >snd_pcm_period_elapsed() was not called.
> 
> I am getting the interrupts, but why there wont be any interrupt for
> 10 seconds?

I don't quite understand this sentence.  You do get interrupts?
And snd_pcm_period_elapsed() is not called?

> I am setting the periods in prepare as periods = runtime->period, so
> interrupts should at period boundaries.

runtime->periods is the number of periods.  I don't know how your
hardware works, but I guess it wants to know the period size, i.e.,
runtime->period_size converted to bytes.


Regards,
Clemens
