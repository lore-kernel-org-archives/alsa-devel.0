From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 10:35:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110ADEB.9050807@wildgooses.com>
References: <200408040018.i740ITg5017942@localhost.localdomain> <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz>
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


>>as i mentioned, try using the pcm device name "plughw:N" where N
>>appropriate. 
>>    
>>
>
>It won't help. We don't convert count of periods in the plug plugin.
>The only one solution is that the application will start using
>an external timing source for PCM (see set/get_tick_time functions)
>- or another timer available for applications - in this case when 
>hardware has this constraint.
>  
>

Hi, as you say, no difference using "plughw:N".  Also, the plug device 
doesn't seem to help with the max period size, which on this hardware 
seems to be 2048 samples.

However, 2048 samples looks to be *just* enough to make mplayer work ok, 
but there are still some problems occuring which look like they might be 
driver related.  Main issue seems to be that the 
"snd_pcm_status_get_avail" function only returns space in whole chunk 
size blocks, ie with a 2048 sample long buffer, then I only get results 
of 2048 or 0 (you never see 4096, the driver feels that this is an 
over-run condition, which I guess is fair enough - some of the other 
drivers, eg my RME96 PAD seem to give you that one remaining tick to try 
and fill the buffer again before overflow...).  Same thing happens in 
mmap mode

Is this acceptable though for the driver to do this?  ie only return 
space in whole chunks?

The same thing is happening with: "snd_pcm_status_get_delay".  It only 
returns one of three values.  Clearly this is undesirable because it 
significantly compromises synchronisation.  However, again is it within 
spec for the driver to do this? 

As an aside, I think mplayer has sufficient code in there already to 
handle short buffers, it appears to be just a case that it's not tuned 
for buffers quite this small.  I think it should be possible fix it ok.  
But the AV-sync is still an issue.

Can I also just check correct usage for setting number of periods and 
period size. I can't see it mentioned in the docs, but empirically I 
find that I have to set period size first, then number of periods, and 
once I have asked for a period size then it's not possible to change it 
(alsa just refuses and gives me the size that I first requested).  This 
is a bit of a pain because it obviously makes it hard to ask for small 
buffers with lots of periods, then change your mind and ask for larger 
buffers when you discover that 2 periods is all you have got. 

Thanks for any help

Ed W



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
