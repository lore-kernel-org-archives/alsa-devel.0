From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 11:21:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110B8BA.30002@wildgooses.com>
References: <200408040018.i740ITg5017942@localhost.localdomain>	<Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz> <s5h8ycvqltj.wl@alsa2.suse.de> <4110B29B.4020006@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4110B29B.4020006@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ed Wildgoose wrote:

>
>>> It won't help. We don't convert count of periods in the plug plugin.
>>> The only one solution is that the application will start using
>>> an external timing source for PCM (see set/get_tick_time functions)
>>> - or another timer available for applications - in this case when 
>>> hardware has this constraint.   
>>
>> Hmm, basically RME h/w can generate enough fine interrupts with a
>> small period size, but it can handle only two periods.
>>
>> If we have an intermediate buffer, any number of periods must be able
>> to handle (only when the given period size or size/N is supported by
>> hw)...
>
> Are you implying that this is possible with the code today, or only 
> that it's theoretically possible to add code to the plug device to do 
> this?
>
> Clearly the plug device could emulate a larger buffer with more 
> periods and then run it's own thread to spool the stuff to the 
> hardware in slow time.  However, whether this is desirable is another 
> matter.


Of course this functionality is already in dmix isn't it?  ie DMix will 
emulate a virtual device with arbitrary sized buffers and periods?  Or 
does it just let you select values but require that they correspond to 
those that the hardware is capable of supporting?

I have tried a few quick workarounds to find something which would 
emulate a device with higher latency.  Jack was the obvious one, but 
even there it seems to only show the underlying hardware and hence you 
are back to 2 periods again.

Hacking mplayer is proving a little more tricky... I will take my 
thoughts to the mplayer list, but it looks as though the main decoding 
loop can't quite get down to very low latencies, the process of 
alternating between decoding a video frame, then adding some audio is 
still causing the odd dropout, and presumably this is caused by the 
video decoding phase (more testing needed)

Thanks for any ideas on workarounds

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
