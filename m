From: Carlo Florendo <subscribermail@gmail.com>
Subject: Re: How to get correct midi timings from ALSA using
 the library only
Date: Wed, 25 Jul 2007 08:54:37 +0800
Message-ID: <46A69F4D.7050002@gmail.com>
References: <46A5BFDF.4040906@gmail.com>
	<1185272655.7458.1201738081@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.hq.astra.ph (unknown [202.78.101.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A41B1037F3
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 02:54:15 +0200 (CEST)
In-Reply-To: <1185272655.7458.1201738081@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
>> However, I wish to be able to make the sequencer or player work without the 
>> use of the ALSA queue nor the workaround in (2).
> 
> Why?

Because the queue output and draining, AFAICS, is implemented in a blocking 
manner.  When events are being played by the queue in the kernel, the 
application blocks, and I have no control on what is being played, except 
that I could raise a SIGTERM anytime and end the app.

AFAIK, using the queue is fine for a simple MIDI player, but not for a 
sequencer, when you need full control of everything that happens with the 
audio output.

>> How could I get the app to <u|nano>sleep() in the most accurate way in 
>> userspace without using the ALSA queue nor the extra subscription to an 
>> output port?
> 
> On newer kernels, you could try POSIX interval timers.

What newer kernels?  Interval timers, as far as I've tested, result in more 
latency than simple sleeps.  And yes, I've tried select(), which seems to 
be more accurate than usleep().

>> Or, is there a drain or output routine that supports callbacks?
> 
> Why can't you simply call the callback when some event has been
> received?

Received by what?  By the extra subscription to the output port?  As I've 
mentioned in the original post, I know this works but for now, I'd want to 
try out simpler sleeps than having an extra output port subscription.

The queue blocks when it plays events.  Thus, the supposed callback 
function which, as you suggest, should be called after the event is 
received, will already be useless since the callback will only be executed 
once the queue unblocks.

Thank you very much.

> 
> 
> Regards,
> Clemens

Best Regards,

Carlo

-- 
Carlo Florendo
Softare Engineer/Network Co-Administrator
Astra Philippines Inc.
UP-Ayala Technopark, Diliman 1101, Quezon City
Philippines
http://www.astra.ph

--
The Astra Group of Companies
5-3-11 Sekido, Tama City
Tokyo 206-0011, Japan
http://www.astra.co.jp
