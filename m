From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Major problem with the current alsa mixer.
Date: Fri, 12 Sep 2003 16:44:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F61E9E6.10403@superbug.demon.co.uk>
References: <3F610FE4.2040009@superbug.demon.co.uk>	<Pine.LNX.4.53.0309120917540.17210@pnote.perex-int.cz>	<3F61C02F.3000700@superbug.demon.co.uk> <s5h7k4egjve.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k4egjve.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 12 Sep 2003 13:46:39 +0100,
> James Courtier-Dutton wrote:
>>
>>Zero as a minimum value is not very meaningfull in audio terms. With a 
>>mixer, the zero dB point is probably more use. The minimum value of a 
>>slider should be the equivalent of mute, so I think that instead of a 
>>minimum value, it should display "mute" for the user.
> 
> 
> it's not always true.  some codes provide the minimum value which
> doesn't mean mute.  in this case, another lower value would be needed
> as the meaming of really minimum "mute".
> 
> 
>>The user should be able to reduce the volume, and if they hit the 
>>minimum, mute automatically becomes active, but if they increase the 
>>volume again, mute automatically is disabled. I am thinking about the 
>>way a TV volume/mute control works. If one is muted, turning volume up 
>>or down automatically un-mutes the sound. This programming could 
>>probably be done at the application level, but I think that as so many 
>>people would want it that way, it should maybe move to alsa-lib.
> 
> 
> hmm, it's a question whether it should go into alsa-lib.
> another upper library seems better for me.
> 
> note that i don't mean against this idea at all - i'm absolutely for
> this :)
> the real problem is, of course, how to implement it for _all_
> soundcards and architectures...
>  
> 
> Takashi
> 
> 
So, if we can agree on how the mixers will behave consistently in the 
application. I prefer the dB range myself, with 0 dB or -3.4 dB meaning 
the same thing for all sound cards, and minimul volume causing a "mute" 
to happen. (I think most TV and HiFi's work that way)
If a user has two different sound cards, the same mixer value on both 
cards should give the exact same volume out of the speakers.

We then modify alsa-lib and alsa-kernel to apply this behaviour to all 
sound cards.
I only initially thought that alsa-kernel was the best place, because 
the snd-emu10k1 happens to have a volume lookup table already, so I 
thought that it would be easy to apply that to all sound cards. It seems 
sensible to me, to do all hardware specific activity in a kernel module, 
and anything that it not strictly hardware specific in alsa-lib if 
possible. The kernel module will know if the minimum volume value in the 
volume register is mute or not, and can decide to activate a separate 
mute register if needed. I don't think alsa-lib can really provide this 
hardware specific functionallity.

Are there any sound cards where this "consistency in the application" is 
not possible?

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
