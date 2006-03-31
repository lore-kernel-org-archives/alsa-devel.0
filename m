From: Robert Hardy <rhardy@webcon.ca>
Subject: Re: Re: [ALSA - driver 0001938]: EPIPE on Audigy with
 surround sound when seeking in 6 channel sound file
Date: Fri, 31 Mar 2006 12:47:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603311238530.12817@thor.webcon.net>
References: <Pine.LNX.4.64.0603291645290.6977@thor.webcon.net>
 <s5h3bh0l10a.wl%tiwai@suse.de> <s5hzmj8jlpx.wl%tiwai@suse.de>
 <Pine.LNX.4.64.0603301053330.11382@thor.webcon.net> <s5hirpv289o.wl%tiwai@suse.de>
 <Pine.LNX.4.64.0603301149200.15984@thor.webcon.net> <s5hvetvn8ff.wl%tiwai@suse.de>
 <Pine.LNX.4.64.0603301317280.20572@thor.webcon.net> <s5hr74ivs1t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr74ivs1t.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Mar 2006, Takashi Iwai wrote:
> At Thu, 30 Mar 2006 18:53:23 -0500 (EST), Robert Hardy wrote:
>> No it only happens when I seek 6 channel audio. I can play something with
>> mplayer -ao alsa -channels 6  and it will play fine _UNTIL_ I seek. Then it
>> blows up.
>>
>> So something like this will immediately fail:
>> mplayer -ao alsa -channels 6 -ss 00:01:00 An_AC3_movie.avi
>>
>> With this stuff:
>> alsa-lib: pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match with appl_ptr (291840) % buf_size (16384)
>> alsa-play: write error: Broken pipe
>> alsa-play: trying to reset soundcard
>>
>> If I switch to a 64 bit chrooted environment with a 64 bit mplayer the audio
>> works properly. But then I can't use any of the 32 bit codecs.
>>
>>>> Is there some way I can comment directly on bug 1938 in Mantis?
>>>
>>> I don't know.  I heard it should be fixed now.
>>
>> The author of the bug seems to think it's still broken and seems to have
>> beat me to posting a backtrace. It's been a busy day here. If you still want
>> me to do this let me know.
>
> I think I got it.  It looks like the old applptr that are not updated
> by the prepare call due to pcm links.
>
> Try the patch below.

*smiles happily*

Your two most recently patches creating the files below fixed my seeking
problems and likely closes bug 1938 on Mantis too.

Thanks a lot for your help!

RCS file: /home/iwai/cvs/alsa/alsa-lib/src/pcm/pcm_hw.c,v
retrieving revision 1.114

RCS file: /home/iwai/cvs/alsa/alsa-lib/src/pcm/pcm_multi.c,v
retrieving revision 1.72


Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
