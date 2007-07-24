From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How to get correct midi timings from ALSA using
 the library only
Date: Tue, 24 Jul 2007 12:24:15 +0200
Message-ID: <1185272655.7458.1201738081@webmail.messagingengine.com>
References: <46A5BFDF.4040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AB07E1038BA
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 12:24:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A5BFDF.4040906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Carlo Florendo <subscribermail@gmail.com>, alsa-devel@alsa-project.org
Cc: linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Carlo Florendo wrote:
> (1) I've written a command line MIDI sequencer for lightweight systems and 
> am successful in making it work using the ALSA queue API.  However, one 
> drawback of the API is its lack of callback functions.  I wish to be able 
> to track events as they are drained by the queue.
> 
> (2) I know and have successfully worked on a work around whereby the 
> application itself subscribes to the output port so as to see events as 
> they are played.

You could also send special user-defined events just to yourself, but
the principle is the same.

> However, I wish to be able to make the sequencer or player work without the 
> use of the ALSA queue nor the workaround in (2).

Why?

> How could I get the app to <u|nano>sleep() in the most accurate way in 
> userspace without using the ALSA queue nor the extra subscription to an 
> output port?

On newer kernels, you could try POSIX interval timers.

> Or, is there a drain or output routine that supports callbacks?

Why can't you simply call the callback when some event has been
received?


Regards,
Clemens
