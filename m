From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 14:31:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110E53A.8060202@wildgooses.com>
References: <200408041301.i74D1omu022274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408041301.i74D1omu022274@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>I'm not sure what you are saying here.  I have the source code in front 
>>of me in an editor, but I physically can't set the options correctly - 
>>the driver just rejects them?
>>    
>>
>
>you've got things the wrong way around - you get to *ask* for a
>specific h/w setup, the driver gets to accept or reject them. 
>  
>

I think we are saying the same thing.

Basically, I set 1024 as the period size first (since this seems a 
reasonable size), then set periods to be "near" 16, however, the driver 
tells me that I can only have 2.  But at this point I can't go back and 
bump up the period size to 8192 or similar.

Actually just to be clear and avoid confusion, if I try on the RME9632 
to set period size to be "near" 8192 right at the start then I just get 
2048.  Very peculiar.


>>Latest mplayer has jack support via the bio2jack library.
>>    
>>
>
>Yeah, but bio2jack is a (working) hack and half. And it doesn't
>support lowlatency work properly either, because the thread that
>*really* does audio isn't scheduled as part of the JACK graph and
>doesn't get SCHED_FIFO status. I see this in xmms all the time when I
>do a multiway compile - JACK has no (or almost no) xruns, but the
>audio in xmms skips because the "feeder" thread doesn't get scheduled
>in time to fill the intermediate buffer.
>  
>

Agree it's a bit of a hack, but I can't see your problem.  If you 
removed the feeder thread, then presumably the problem would still 
remain because fundamentally xmms needs to be realtime as well or else 
it won't decode fast enough to keep up with JACK?

I think that bio2jack has a large buffer, and presumably this in 
conjunction with Jack waking it up regularly via the call back is about 
as good as you can do anyway no?

I will have to look at bio2jack again though - it's been a while since I 
studied it.  I was going to use it as a quick way to add Jack output to 
Mythtv.

Thanks for any pointers on the 8192 issue.

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
