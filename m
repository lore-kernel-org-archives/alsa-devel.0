From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Please add snd-ice1712 problem to "Known bugs"	page
Date: Wed, 10 Sep 2003 22:37:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F5F99AA.5040506@superbug.demon.co.uk>
References: <200309101206.h8AC6xW9005709@oud> <7616-64105@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7616-64105@sneakemail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam <4l8uie002@sneakemail.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sam wrote:
> On Wed, 2003-09-10 at 05:06, Paul Davis wrote:
> 
>>although it makes me happy to see you feeling this way, i felt
>>compelled to add that i'm not necessarily sure that the linux way *is*
>>better. its more flexible, that's true. but the two different
>>standards for "input maximum signal level" are just that - standards -
>>and the fader to control this makes it much harder to switch between
>>the two levels that all of my equipment uses.
> 
> 
> This is a good point.  Maybe my sound problem is only my poor skill at
> setting the output signal level appropriately.
> 
> Chances are M-Audio put some thought into the +4dBu,
> Consumer, and -10dbV presets.  Does anyone know how we could map these
> to the corresponding 7 bit values?  I could probably patch envy24control
> to add analog signal presets so we could have the best of both features.
> 
> Sam
> 
I think this highlights a particular problem with the current alsa mixer.
It might have a value from 0 to 100%. Percent of what?
I think that this should all be changed to signed values, with a max and 
a min setting. With a value of 0 being equivalent to no-gain, 
no-attenuation. Each alsa-driver would then convert this signed value 
into a value actually written to the hardware register via a lookup table.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
