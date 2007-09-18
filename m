From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 03:57:43 +0200
Message-ID: <46EF3097.7060300@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id EBA2524355
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 03:58:34 +0200 (CEST)
In-Reply-To: <46EF18FF.7070906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 02:17 AM, Rene Herman wrote:

>> Second, schedule_timeout() returns immediately unless you have set the
>> task state to TASK_UNINTERRUPTIBLE or TASK_INTERRUPTIBLE.  I don't see
>> anywhere where this is done, so the 250ms delay is in fact a busy loop.
>> The call to schedule_timeout() appears to be quite pointless.
> 
> That mce_down code was changed over the last week by Krzysztof, myself 
> and Takashi so not sure what version you've been looking at, but the 
> (original) version that the quoted patch was against didn't use 
> schedule_timeout, but a timeout based sleeping loop for cs4231 and 
> schedule_timeout_interruptible() for ad1848 which sets the state itself.

Oh. This discrepency is caused by the fact that I work against the kernel 
and only check ALSA HG every once in a while. Too infrequently it seems as 
the _interruptible was recently (and yes, wrongly) removed from ALSA:

http://hg.alsa-project.org/alsa-kernel/rev/1768363a5f1e

It's still there in 2.6.22.x which I run. The setup has been changed around 
in the meantime again anyway in this case but I guess I'll make a point of 
working against HG more directly.

Rene.
