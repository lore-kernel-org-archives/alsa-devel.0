From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Improving wine support for alsa.
Date: Fri, 07 May 2004 07:03:45 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405071103.i47B3jj4003195@dhin.linuxaudiosystems.com>
References: <20040507040214.GK30822@zewt.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out001.verizon.net (out001pub.verizon.net [206.46.170.140])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA27931
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 13:03:54 +0200
In-reply-to: Your message of "Fri, 07 May 2004 00:02:14 EDT."
             <20040507040214.GK30822@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <g_sf@zewt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>On Thu, May 06, 2004 at 09:49:31PM -0400, Paul Davis wrote:
>> at the risk of endlessly repeating myself,
>
>If you're being asked this frequently, I'd recommend adding some notes to

I'm not. I'm just a big mouth who always pipes up when SIGIO is mentioned.

>the documentation, recommending using poll() and not SND_PCM_ASYNC, and
>offering a brief explanation like this one.

Well, since I disagree with other people on the ALSA project about the
wisdom of supporting SIGIO, this hasn't happened. But yes, even a note
to make it clear that there is disagreement about whether it should be
used would be a good idea.

>> SIGIO is basically
>> useless. your handler executes in signal-handling context, and can do
>> very, very little. not even all system calls are legal in this context.
>> SIGIO is basically a "poor man's thread system", and not much more.
>
>Practical use aside, isn't that common conditions for a sound callback
>(which under some architectures, as I understand it, are called from an
>interrupt)?

Only MacOS "Classic" did this, and Apple moved away from that design
as soon as they could. The key part of the design that needs to be
retained is the "callback model". Using poll to implement it is, IMHO,
a very, very much better design than using SIGIO.

>By the way, do you have a reference to system calls which are not legal

I have a list of the legal calls in a book on pthreads
programming. I'm afraid I don't feel like typing it in, but someone
already posted another reference.

--p


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
