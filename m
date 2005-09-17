From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Mixer improvements
Date: Sat, 17 Sep 2005 19:39:47 +0100
Message-ID: <432C62F3.3050302@superbug.co.uk>
References: <43241A35.8080903@superbug.co.uk> <s5hr7buh3qv.wl%tiwai@suse.de> <Pine.LNX.4.61.0509121434440.9569@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0509121434440.9569@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 12 Sep 2005, Takashi Iwai wrote:
> 
> 
>>>1) Unsigned integer index to percent <-> dB function.
>>>2) Integer for Analog or Digital path. This will indicate which side of 
>>>3) Link information.
>>>4) Alternatively, we could implement this in alsa-lib, and just add 
> 
> 
> I agree that 1 is the main required extension. 2 and 3 are optional in my 
> eyes.

Agreed.

> 
> 
>>Moreover, we should be careful to handle the value <-> dB conversion.
>>The dB isn't integer in general, and defining the fixed resolution is
>>no generic solution.
> 
> 
> It's signed integer - fixed float resolution (* 100) in my implementation. 
> I think that it's enough for our purpose.

I have already checked into the alsa-utils cvs support for this API in 
alsamixer. We just need to add the features to alsa-lib and alsa-driver.

> 
> 
>>Adding a dB info into the driver would be required for the USB and HDA 
>>stuff, at least, since they can (or need) retrieve such information from 
>>the hardware directly. Meanwhile, others are basically given statically 
>>- e.g. a simple table look-up for each ac97 codec.  This isn't 
>>necessarily in the kernel code at all.

> 
> 
> I agree, the alsa-lib should have a database containing this static 
> information. Also, I think that this information does not belong to the 
> universal control API at all. We need to decide, if we need another 
> midlevel module providing this information, or in my eyes, better way 
> might be to use the hwdep device and pass this information to the user 
> space. The alsa-lib modules driving the specific hardware will parse this 
> information and do own things with it. Perhaps, we can pass simple text 
> from the driver to user space. In this way, the procfs or devfs might be 
> used.
> 
> 						Jaroslav
> 

I will take a first bash at it, provide some patch code that we can then 
discuss.

James


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
