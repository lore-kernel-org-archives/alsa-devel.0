From: Paul Davis <pbd@op.net>
Subject: Re: Starting playback/capture exactly the same time (was: Repeatable exact I/O-delay)
Date: Sun, 28 Jul 2002 10:41:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207281440.QAA29728@alsa.alsa-project.org>
References: <20020728142645.D328C902@mail.it4u.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA29728
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 16:40:00 +0200
In-Reply-To: Your message of "Sun, 28 Jul 2002 16:26:49 +0200."
             <20020728142645.D328C902@mail.it4u.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Tim Goetze <tim@quitte.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Thanks. I'll try this. Not only the hardware can be broken, but also 
>the driver I suppose. It seems like not all have support for 
>snd_pcm_link(), for example my driver for RME96 (I have to do some 
>maintenance work on that soon).

no code is needed to implement support for this. its handled by the
ALSA mid-level layer. its possible that your driver has set or has not
set some flag related to this, making the mid-level code think its not
possible to do it.

>> Implementing memory-mapped IO isn't exactly what you do in a day.
>> jackit.sf.net or the shortly-to-be-released library I'm working on
>> will do it for you. Just replace 'interrupt' above with a 'process'
>> callback and you don't have to care about the exact workings of
>> mmap'd ALSA at all.
>
>This is great, but I don't see why this particular thing would require 
>memory-mapped I/O. If one makes sure to write 4096 silent frames first 
>start playback/capture using snd_pcm_link(), it should work with 
>snd_pcm_read/write too, shouldn't it?

yes, it should.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
