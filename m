From: Michael Geis <michaelgeis11@yahoo.com>
Subject: Re: alsa sequencer: How to eliminate choking
Date: Sat, 11 Dec 2004 19:51:50 -0800 (PST)
Message-ID: <20041212035150.20862.qmail@web51904.mail.yahoo.com>
References: <Pine.HPX.4.33n.0412081901570.21064-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1519745891-1102823510=:16588"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0412081901570.21064-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-1519745891-1102823510=:16588
Content-Type: text/plain; charset=us-ascii

Michael Geis wrote:
> > I am pretty convinced that the problem is not queue overflow,
> > since I flush queues every two seconds.
>
> What do you mean by "flush"?
>
> -Sorry, I meant drain.

Do you mean snd_seq_drain_output?  This one should be called
immediately after you've written a bunch of events so that the kernel
sequencer sees them.  It isn't related to queues.
 
-Does that mean that I dont have to worry about how much I out into a queue before 
I call snd_seq_drain_output? I thought snd_seq_drain_output empties the pool, and thus
needs to be called regularly to ensure that not more events are attempted to be placed in 
the pool than there is space. So queues and the necessity for draining are seperate facts? 

How much in advance of the delivery time do you send the events?

-Zero. I split the score up into rounds of 2 seconds. At the beginning of each round, I schedule
the events for the coming round and call snd_seq_drain_output. I sleep until the beginning of the next round, where the pattern gets repeated intil all is played. 



 

		
---------------------------------
Do you Yahoo!?
 Yahoo! Mail - now with 250MB free storage. Learn more.
--0-1519745891-1102823510=:16588
Content-Type: text/html; charset=us-ascii

<DIV>Michael Geis wrote:<BR>&gt; &gt; I am pretty convinced that the problem is not queue overflow,<BR>&gt; &gt; since I flush queues every two seconds.<BR>&gt;<BR>&gt; What do you mean by "flush"?<BR>&gt;<BR>&gt; -Sorry, I meant drain.<BR><BR>Do you mean snd_seq_drain_output?&nbsp; This one should be called<BR>immediately after you've written a bunch of events so that the kernel<BR>sequencer sees them.&nbsp; It isn't related to queues.</DIV>
<DIV>&nbsp;</DIV>
<DIV>-Does that mean that I dont have to worry about how much I out into a queue before </DIV>
<DIV>I call snd_seq_drain_output? I thought snd_seq_drain_output empties the pool,&nbsp;and thus</DIV>
<DIV>needs to be called regularly to ensure that not more events are attempted to be placed in </DIV>
<DIV>the pool than there is space.&nbsp;So&nbsp;queues and the necessity for draining are seperate facts?&nbsp;<BR><BR>How much in advance of the delivery time do you send the events?<BR></DIV>
<DIV>-Zero. I split the score up into rounds of 2 seconds. At the beginning of each round, I schedule</DIV>
<DIV>the events for the coming round and call snd_seq_drain_output. I sleep until the beginning of the next round, where the pattern gets repeated intil all is played. <BR></DIV>
<DIV><BR><BR>&nbsp;</DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
Yahoo! Mail - now with 250MB free storage. <a href="http://us.rd.yahoo.com/evt=29914/*http://info.mail.yahoo.com/mail_250">Learn more.</a>
--0-1519745891-1102823510=:16588--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
