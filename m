From: Paul Davis <pbd@op.net>
Subject: Re: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 12:59:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204191657.SAA07613@alsa.alsa-project.org>
References: <1019231568.20499.5.camel@meowing.memh.uc.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA07613
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 18:57:07 +0200
In-Reply-To: Your message of "19 Apr 2002 11:52:48 EDT."
             <1019231568.20499.5.camel@meowing.memh.uc.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: joy ping <joy@pingfm.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>you (or anyone else regarding asoundrc file), as well as additional info
>regrading polling abilities with the soundcards that have lousy drivers
>due to lack of documentation and/or questionable hardware and are
>therefore unable to provide me with the hardware mixing.

the term "polling" in not very useful here. all ALSA supported
hardware can be "polled" in the sense that a program can stop and wait
for it to be ready to read or write from. no hardware support over and
above the minimum necessary for basic audio i/o is necessary for this.

i think you're describing something that is generally known as
"multi-open", in which the hardware supports multiple independent (but
generally synchronous) streams of audio data to be possible, and each
process that opens the device gets a new stream. the streams are mixed
in hardware before being delivered to the physical outputs.

i am not sure how "polling" (of any kind) relates to this. care to explain?

--p
