From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 21:30:28 +0200
Message-ID: <4888D854.40509@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>	<20080724072620.4197510c.krzysztof.h1@poczta.fm>	<4888B993.2040101@keyaccess.nl>
	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F64E103821
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 21:28:09 +0200 (CEST)
In-Reply-To: <20080724204734.0ae77007.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 24-07-08 20:47, Krzysztof Helt wrote:

>> *** 0005-wss_lib-use-wss-constants-instead-of-ad1848-ones.patch
>>
>>> --- a/sound/isa/ad1848/ad1848_lib.c
>>> +++ b/sound/isa/ad1848/ad1848_lib.c
>>> @@ -283,14 +283,12 @@ static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
>>>                         return 0;
>>>                 }
>>>                 snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
>>> -               chip->mode |= AD1848_MODE_RUNNING;
>> Is this now done in generic code? Not necessary anymore? Was no comment 
>> in the changelog.
> 
> The MODE_RUNNING is not used at all in the cs4231 code. I wonder what the purpose of it.

It was used by the AD1848 code though; snd_ad1848_trigger() set/reset it 
on start/stop and it was then tested by snd_ad1848_interrupt() to decide 
whether or not to call snd_pcm_period_elapsed().

> If switches like these generates more than one warnings by the
> checkpatch script I change them to be on safer side with "checkpatch
> fundamentalists". Ok?

Yeah, sure. Just hoping to convince Takashi that checkpatch makes some 
things worse instead of better.

>> *** 0009-wss_lib-use-wss-pcm-code-instead-of-ad1848-one.patch
>>
>>> --- a/sound/isa/wss/wss_lib.c
>>> +++ b/sound/isa/wss/wss_lib.c
>>> @@ -363,7 +363,7 @@ static void snd_wss_busy_wait(struct snd_wss *chip)
>>>         for (timeout = 5; timeout > 0; timeout--)
>>>                 wss_inb(chip, CS4231P(REGSEL));
>>>         /* end of cleanup sequence */
>>> -       for (timeout = 250;
>>> +       for (timeout = 2500;
>>>              timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
>>>              timeout--)
>>>                 udelay(10);
>> Was this intentional? You comment on this in 10/10...
> 
> Yes. It was. The original ad1848 loop is 12000 x 100us. The cs4231 loop
> was 250 x 10us. The code I tested had 2500 x 100us but I lowered the udelay()
> argument for cs4231chips which were much faster (only few if any 10us 
> during tests). I forgot to retest it again on the original ad1848 so the patch
> went in with the error.
> 
> If this kind of change should be in a separate patch it must be a patch
> before this patch otherwise we end up with perfectly bisectable error
> the author was aware of while sending patches (so there is no point
> in applying only one and no bisecting then).

Okay...

> I'll do fold the fix, but new limits for opti cards I would like to keep
> as a separate one (missing it is not a regression).

Yep.

>> It's probably all fine, but snd_ad1848 function changed 
>> very significantly in the move and I'd rather it not do that. A patch
>> 12 alone is much easier reviewable and any possible difficulty much 
>> easier bisectable. Could you do that?
> 
> It can be done but the patch which merges the code will incorrectly
> detect chips (tested that it does). So both must be applied together.

Okay, I see this was specifically tested and all. Try and see if you can 
put something sensible in the changelog about it. It's _very_ hard to be 
too verbose in changelogs...

> You may try merging opti92x-ad1848 and opti92x-cs4231 drivers now.
> There are only few lines of difference (e.g. timer creation). I haven't
> done this as I do not have these chips.

Have a ton of them. Yes, I may try for merging opti92x and opti93x as 
well in fact. Also have all 93x cards to test. Don't yet know if it'll 
end up clumsy, not started.

> Yes. Try if older codecs (not yet tested) are correctly detected. Especially, 
> these with special code paths in the detection function:
> ad1847,

This one I don't think I have... (damnit!)

> cmi8330, 

Yup.

> cs4248,

Yup.

> Also try if they are working as they may require even longer delays.
> 
> The cs4231 chips are much simpler as you have the revision register
> so I do not have problem here. I would like to have tested the 
> integrated or compatible cs4231 codecs:
> yamaha opl3sa2 

Yup.

> interwave

Nope. Many people are _still_ deluded by the GUS name and believe that 
(even) a GUS PnP is worth something, so I've upto now told people where 
to stick the GUS PnPs they tried to sell me (but I do have classic, max 
and extreme).

> If you have any of these please post results of your tests.

Will wait for V2 and will do; make take some time. I hope to not have 
time over the coming weekend...

> I did tests on cs4232 chip inside the Dell Laptitue CP250 and it
> works. It is found by the PNP bios and configured automatically (the
> anti-crash patch I posted is needed). The chip is detected as CS4236,
> however. The cs4231 revision is 0x03 which code detects as CS4236B. I
> cannot open the laptop (it is not mine) so I assume the Dell replaced
> older chip with newer one but left the same BIOS.

I'm not surprised. The CS4232 part of your chip will advertise itself 
with ID CSC0000 or CSC0100 in /sys/devices/pnp0/<foo>/id and you 
probably have a CSC0010 or CSC0110 as one of the other devices in there. 
I noticed this before when debugging someone else's system on alsa-user 
a while ago. That latter ID is the CS4236 control port. These things 
should really just be driven as CS4236.

If you have this laptop for long enough, we'll get that going...

Rene.
