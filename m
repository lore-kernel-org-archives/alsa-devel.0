From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME9632 Precise Pointer option problem (attn Thomas Charbonnel)
Date: Mon, 27 Sep 2004 07:12:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409271112.i8RBC6Qc017508@localhost.localdomain>
References: <4157DB53.2030801@wildgooses.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Sep 2004 10:20:19 BST."
             <4157DB53.2030801@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>With this driver the free space call returns only an approximate value, 
>however, the "precise pointer" module option returns apparently garbage 
>(and there are notes in the source to say this).  Looking at the code 
>it's just returning the value from a register, so it's hard to see that 
>the driver is doing anything bad.

correct. this is why this option is an option. its not on by default.

>Does anyone have any insight on whether it's possible to get a good 
>value for free space in the buffers?  From a design point of view is it 

its not. you have to keep in mind that RME designed this hardware
around the ASIO model, in which the h/w ptr position is  essentially
irrelevant. consequently, the way in which the ptr is updated is not
particularly reliable.

>quite accurate estimating the current point location based on counting 
>ticks since we started and noting when we add new data, etc.

you should probably first explain why you want to do this. as i
mentioned, the h/w design is really centered on straightforward double
buffering - the application works on one "buffer" and the hardware
works on the other. 

when you add data to the buffer makes no difference to the location of
the hw ptr, btw.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
