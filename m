From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problems with snd_pcm_hw_params_can_pause (). etc.
Date: Sun, 13 Oct 2002 00:08:44 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA82CEC.2080307@superbug.demon.co.uk>
References: <Pine.LNX.4.33.0210121533280.1975-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Sat, 12 Oct 2002, James Courtier-Dutton wrote:
>
>  
>
>>Currently, the state of play is that "snd_pcm_hw_params_can_pause ()" 
>>should not be called until one has first done the first 
>>"snd_pcm_hw_params()"
>>
>>I start with
>>snd_pcm_hw_params_any(this->audio_fd, params);
>>then go about setting params, e.g.
>>snd_pcm_hw_params_set_access()
>>snd_pcm_hw_params_set_format()
>>etc.
>>Then
>>snd_pcm_hw_params()
>>then
>>snd_pcm_hw_params_can_pause (params)
>>
>>If the "snd_pcm_hw_params_can_pause (params)" goes before the 
>>"snd_pcm_hw_params()" an invalid result is returned. I.E. the result is 
>>always 1 even for cards which don't support it.
>>
>>I think the documentation should make it clear when one should use 
>>"snd_pcm_hw_params_can_pause ()".
>>or maybe "snd_pcm_hw_params_any()" should be modified to correctly fill 
>>the "can_pause" bit.
>>Maybe I have missunderstood the API, but I would prefer the approach of 
>>first retrieving the current hw params, then go about modifying it, then 
>>writting it back. If one has not set any hw params yet, it would fill 
>>    
>>
>
>But what's "current configuration"? What you want to prefer? rate? 
>channels? period_size? No, application should give these hints to driver.
>
>  
>
>>the structure with the most general case, then allow the application to 
>>set params to further restrict the config.
>>I had assumed that "snd_pcm_hw_params_any()" did the retrieving of the 
>>current hw params, but reset to the least restrictive settings. I don't 
>>think "can_pause" is anything an application can set, the hardware on 
>>the card decides that, so the "snd_pcm_hw_params_any()" should cause 
>>"can_pause" to return a valid setting that matches the hardware, instead 
>>of having to wait for the params to be written to the card with 
>>"snd_pcm_hw_params()" before "can_pause" is set accurately.
>>    
>>
>
>All these functions needs exactly one configuration at input.
>The snd_pcm_hw_params() function chooses one configuration and sets it to 
>hardware. I've updated documentation.
>
>						Jaroslav
>
>  
>

Thanks for the documentation update. I currently use the inline docs 
contained in alsa-lib/pcm/pcm.c. Is that the ones you update ? I only 
mentioned it because I made the mistake of putting the can_pause() 
before the snd_pcm_hw_params() without knowing that it would not work 
correctly, so I just wanted the documentation to be updated so that no 
one else would make the same mistake.
I think the point I was trying to make is that one should be able to call
snd_pcm_hw_can_pause() at any time. One should not have to wait until 
one has snd_pcm_hw_params() has been called. At this point I am assuming 
that the result of "snd_pcm_hw_can_pause()" is always constant, and does 
not depend of any hw_params that have been set. But now I come to think 
of it, this might not be true. I think the SB Live can do pause/resume 
in normal mode, but cannot do it in AC3 passthru mode using the DSP TRAM.

But as a general point, this does not really matter too much to me now, 
because I will be using snd_pcm_hw_params_current() that you have kindly 
added to the API. ;-)
I will have to wait until the next release of alsa09 before I actually 
code the change, because I cannot expect all my users to install alsa09 
from CVS. :-(

As a sub note, maybe snd_pcm_can_pause() should return some sort of 
error code, or throw an assert if the application programmer has put it 
before snd_pcm_hw_params() instead of returning a perfectly useable 
result that is baseless. I think an assert() would be acceptable, as 
this is a application programming error and not a user initiated error. 
It would then force the application programmer to "get it right first 
time". ;-)

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
