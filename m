From: stan <stanl@cox.net>
Subject: Fw: hardware not asking for more data using asyn call
	back
Date: Wed, 30 May 2007 09:58:54 -0700
Message-ID: <20070530095854.5b0a7637@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_q+sc.wXCEC53VaRylwP5UxF
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id AA0A5244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 18:59:05 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao105.cox.net
	(InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
	id <20070530165856.BDMR9600.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2007 12:58:56 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_q+sc.wXCEC53VaRylwP5UxF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Begin forwarded message:

Date: Tue, 29 May 2007 15:19:12 -0400
From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
To: stanl@cox.net, alsa-devel@alsa-project.org
Subject: Re: hardware not asking for more data using asyn call back


Hi,

Thanks Stan, for your response - Instead of copying pcm data from a wav
file, i decided to copy all the data to a master buffer first and then
see if the circular buffer implementation works -

so now instead of copying from the wave file, i m copying data from the
master buffer to the circular buffer.. however, as per your suggestion,
if i copy the data in the while loop in main, then, it might not always
be copied between 2 consecutive callbacks, but maybe more, as the
callbacks are asynchronous.

however, the hardware still does not ask for more data after executing
the callback function about twice -- is there a way to flush the
hardware buffer before beginning playback? I have pasted my code below

Regards,
Ashlesha.

<snip>

I've been doing some thinking about what you are trying to accomplish
and have a suggestion.  I think you would be better off letting jack
handle the back end/sound portion.  Run a daemon/service listening on
an arbitrary tcp/ip port.  On startup it initializes alsa and jack.
When it receives a request, it forks a process which opens a new
channel on jack and creates a buffer for it.  It then plays the sound it
receives on that link via jack, silence when the buffer is empty.  You
would have to write client software for the user on the network to
contact your daemon/service.

You might even find something like this already out there.

--MP_q+sc.wXCEC53VaRylwP5UxF
MIME-Version: 1.0
Content-Type: text/plain


--MP_q+sc.wXCEC53VaRylwP5UxF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_q+sc.wXCEC53VaRylwP5UxF--
