From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 12:16:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110C586.3030100@wildgooses.com>
References: <200408040018.i740ITg5017942@localhost.localdomain> <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz> <4110ADEB.9050807@wildgooses.com> <Pine.LNX.4.58.0408041220190.1857@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408041220190.1857@pnote.perex-int.cz>
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

Jaroslav Kysela wrote:

>On Wed, 4 Aug 2004, Ed Wildgoose wrote:
>
>  
>
>>However, 2048 samples looks to be *just* enough to make mplayer work ok, 
>>but there are still some problems occuring which look like they might be 
>>driver related.  Main issue seems to be that the 
>>"snd_pcm_status_get_avail" function only returns space in whole chunk 
>>size blocks, ie with a 2048 sample long buffer, then I only get results 
>>of 2048 or 0 (you never see 4096, the driver feels that this is an 
>>over-run condition, which I guess is fair enough - some of the other 
>>drivers, eg my RME96 PAD seem to give you that one remaining tick to try 
>>and fill the buffer again before overflow...).  Same thing happens in 
>>mmap mode
>>    
>>
>
>Set precise_ptr module option for your driver.
>  
>

Hmm, well this now seems to give a more accurate space available as you 
say, but it now causes buffer overruns constantly....

I can see that the docs say that this option doesnt work well of 
course..  However, something looks broken here:

Here is some debug I added from the app.  This is typical - notice how 
despite the fact that we can see that we are being called very regularly 
the final call before the overflow is quite reasonable, and yet alsa 
says that an overflow occurred?  Just by eye, there should be no 
overflow here because we would have filled the buffer to the top only a 
few thousand samples before...


alsa-space: free space = 16384, prepared --53/ 50  10% 23%  0.8% 0 0 88%

About to play: 16384 bytes, time since last called: 784.000000
About to play: 3008 bytes, time since last called: 16007.000000
About to play: 3328 bytes, time since last called: 17583.000000
About to play: 3968 bytes, time since last called: 20767.000000
About to play: 5568 bytes, time since last called: 28723.000000
About to play: 0 bytes, time since last called: 13966.000000
alsa-space: xrun of at least 2.831 msecs. resetting stream  0.8% 0 0 87%
alsa-space: free space = 0, xrun --


Any theories on why precise_ptr might be causing this?

Thanks

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
