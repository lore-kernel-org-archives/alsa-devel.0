From: Paul Davis <pbd@op.net>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 06 Jun 2002 09:46:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206061341.g56DfbH16112@post2.fast.net>
References: <000601c20d66$07df3890$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA13504
	for <alsa-devel@alsa-project.org>; Thu, 6 Jun 2002 15:41:47 +0200
In-Reply-To: Your message of "Thu, 06 Jun 2002 15:25:14 BST."
             <000601c20d66$07df3890$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

you do it using ~/.asoundrc to define a PCM device that has the
channel characteristics you want.

next, you'll be asking how. that's the part i can't help you with. the
archives have some examples, and there are several people on the list who
can tell you.

>I again sent an email to alsa-devel using the wrong account. I think
>it is all outlook's fault...

nearly everything is outlook's fault ... :)

--p

>--martijn
>
>----- Original Message ----- 
>From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
>To: <alsa-devel@alsa-project.org>
>Sent: Wednesday, June 05, 2002 7:50 PM
>Subject: opening alsa pcm device for input/output on specific channels
>
>
>> is it possible to open a alsa pcm device for input or output on
>> not only a certain number of channels but using a channel mask?
>> e.g. output on channels 1, 2, 5 & 6? i don't seem to find this
>> in the docs.
>> 
>> thanks,
>> 
>> --martijn
>> 
>> 
>> 
>
>
>_______________________________________________________________
>
>Don't miss the 2002 Sprint PCS Application Developer's Conference
>August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
