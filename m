From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Major problem with the current alsa mixer.
Date: Fri, 12 Sep 2003 13:46:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F61C02F.3000700@superbug.demon.co.uk>
References: <3F610FE4.2040009@superbug.demon.co.uk> <Pine.LNX.4.53.0309120917540.17210@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309120917540.17210@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 12 Sep 2003, James Courtier-Dutton wrote:
> 
> 
>>There is a MAJOR problem with the current alsa mixer.
>>How do I set a mixer volume to the 0 db point. I.E. no attenuation, and
>>no gain.
>>Currently, we might have a value from 0 to 100%. Percent of what?
> 
> 
> Percent of the volume range.
> 
> 
>>What this value means varies depending on the sound card hardware being
>>used.
>>I think that this should all be changed to signed values, with a max and
>>a min setting. With a value of 0 being equivalent to no-gain,
>>no-attenuation. Each alsa-driver would then convert this signed value
>>into a value actually written to the hardware register via a lookup table.
> 
> 
> Things are not as easy as you like. Using the signed notation for the
> volume representation does not sound bad, but on the other side, it's
> great to have zero as minimum value as well.

Zero as a minimum value is not very meaningfull in audio terms. With a 
mixer, the zero dB point is probably more use. The minimum value of a 
slider should be the equivalent of mute, so I think that instead of a 
minimum value, it should display "mute" for the user.
The user should be able to reduce the volume, and if they hit the 
minimum, mute automatically becomes active, but if they increase the 
volume again, mute automatically is disabled. I am thinking about the 
way a TV volume/mute control works. If one is muted, turning volume up 
or down automatically un-mutes the sound. This programming could 
probably be done at the application level, but I think that as so many 
people would want it that way, it should maybe move to alsa-lib.

> 
> I have plans to extend the mixer interface to pass (and handle) the dB
> resolution. But it will be done completely in the user space. The alsa-lib
> will analyze information from the driver (hardware components) and then it
> will use a predefined expressions for these transformations. I think that
> we should not polute the kernel space with these "additional" things.

I don't really mind where the code appears, all I care about is what the 
user sees. I just thought that as the hardware module knows best what to 
do with itself, it would be best to handle the volume calculation, but 
it could just as easily pass some equation/table up to alsa-lib to do 
the calculation instead.

One of the reasons for this request is if one has an application that 
defaults the mixer value to 100% because that sounds best for one bit of 
hardware, but finds the a 50% value is better for some other piece of 
hardware, with 100% causing massive distortion for the user due to too 
much gain/clipping. It would be nice for the application to be able to 
set 0 dB and know that it will sound the same for all sound card hardware.


> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 

If your "plans to extend the mixer interface" include my requests, then 
I will be happy to wait for their implementation.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
