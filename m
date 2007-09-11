From: Rene Herman <rene.herman@gmail.com>
Subject: Re: tiwai long downtime in this week
Date: Tue, 11 Sep 2007 22:08:13 +0200
Message-ID: <46E6F5AD.9030108@gmail.com>
References: <s5h7imyqjqq.wl%tiwai@suse.de>	<46E5BF4A.7000509@gmail.com>
	<s5hps0p56c0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1722724362
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 22:08:22 +0200 (CEST)
In-Reply-To: <s5hps0p56c0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/11/2007 09:51 PM, Takashi Iwai wrote:

>> Does this mean it might be better to delay the impending 1.0.15 for 1 more 
>> week? You're sort of vital to this ALSA thingy...
> 
> I guess the next rc will be delayed anyway since Jaroslav is already
> in the conference.

Mmm. Good :-)

>> Also, although I don't care deeply, I'd also sort of like to get the new 
>> Sound Galaxy driver in there and while all the AZT2316 cards are fully 
>> functional, AZT1605 is giving me a little grief. The configuration part of 
>> its EEPROM is mapped out and the driver is working well, but I haven't yet 
>> found a way to know which one of the two I'm looking at runtime and I need 
>> to know that to know what configuration register layout I need to use.
>>
>> The simplest way might in fact be to introduce sound/isa/galaxy/ and provide 
>> seperate snd-azt1605 and snd-azt2316 drivers that just share a lot of code 
>> through a common galaxy.c (and then just move over snd-azt2320 to there as 
>> well ofcourse).
> 
> Maybe it's the only way if there is really no difference in the
> signature or the beginning of EEPROM...

I haven't yet looked at the storing of volumes in the EEPROM (which azt1605 
does, and azt2316 not). Requires some reverse engineering again, but that 
might provide a method.

When I find something, I'll also need to base my nicely simple and direct 
setup in the ISA match() method around a bit, since I'll certainly not know 
at _that_ stage. AZT1605 eeprom/config-register layout difference and it in 
fact supporting different IRQs for MPU-401 (and SB, but that's not used in 
these drivers)...

For now I've done a seperate azt1605 though and I sort of expect I'm going 
to try for just splitting the common code of into a galaxy.c and building 
the two modules from that. I'll not wait too long with submitting the next 
version, so you'll still have time to slap me around when you really do 
desperately want a merged driver (azt1605 is really utterly ancient by now 
though, and an even older galaxy I have will also need differences).

Rene.
