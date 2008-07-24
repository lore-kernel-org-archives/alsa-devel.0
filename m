From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 11:31:00 +0200
Message-ID: <48884BD4.3010308@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>
	<20080724072620.4197510c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F00A24933
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 11:28:44 +0200 (CEST)
In-Reply-To: <20080724072620.4197510c.krzysztof.h1@poczta.fm>
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

On 24-07-08 07:26, Krzysztof Helt wrote:

>>> diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
>>> index 5f5271e..3500548 100644
>>> --- a/sound/isa/ad1848/ad1848.c
>>> +++ b/sound/isa/ad1848/ad1848.c
>>> @@ -70,15 +70,15 @@ static int __devinit snd_ad1848_match(struct device *dev, unsigned int n)
>>>                 return 0;
>>>  
>>>         if (port[n] == SNDRV_AUTO_PORT) {
>>> -               snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
>>> +               snd_printk(KERN_ERR "%s: please specify port\n", dev_name(dev));
>>>                 return 0;
>>>         }
>> The comment in dev_name() makes me wonder a bit but I guess we'll deal 
>> with it then if there's anything to deal with.
> 
> This is not my change. It is probably diff between some -mm kernel
> version and alsa-driver. It should not be there as the ad1848.c is
> going to be deleted.

I see. It's definitely from the patch you sent though:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/008978.html

>>> -CS4236_DOUBLE("Master Digital Playback Switch", 0, CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
>>> -CS4236_DOUBLE("Master Digital Capture Switch", 0, CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
>>> +CS4236_DOUBLE("Master Digital Playback Switch", 0,
>>> +               CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
>>> +CS4236_DOUBLE("Master Digital Capture Switch", 0,
>>> +               CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
>> I can't say I'm personally a fan of these kinds of changes. The point of 
>> them would supposedly be to make the code more readable but as far as I 
>> am concerned it does the reverse.
>>
>> I know that Takashi can be an 80-column fundamentalist so I'll not 
>> object I guess. I'd personally like these (all) restored to a single 
>> line but if he doesn't, so be it.
> 
> Exactly. It was done for Takashi.

Yes, he overrides. I'd try to get away with just saying no though. That 
checkpatch thing desperately needs a clue.

>>> +static void snd_wss_playback_format(struct snd_wss *chip,
>> [ ... ]
>>
>>> -                       snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
>>> +                       chip->image[CS4231_PLAYBK_FORMAT] = pdfr;
>>> +                       snd_wss_out(chip, CS4231_ALT_FEATURE_1,
>>> +                                   chip->image[CS4231_ALT_FEATURE_1] &= ~0x10);

Oh, missed commenting on this assignment-in-argument due to commenting 
on the other one...

>> As long as you're at it... could you split this assignment same as you 
>> did above?
>>
> 
> Ok. I did it above because otherwise the line was too long ...

Okay. Style-consistency really is fairly important. Otherwise you each 
time have to "retrain" while reading code. In that sense, even leaving 
them all in would/can be better than some in, some out although in this 
case "all out" is quite preffered.

(I only looked at the patch itself though -- if there are many more of 
these than leaving them in and (perhaps) fixing it in a follow-up might 
be preferred).

>> Right-o. That was a 4000+ line patch and I ran out of evening. Rest will 
>> have to wait for tomorrow then. If you make changes, could you very 
>> specifically indicate those changes so that I might be able to get away 
>> with not reading the entire thing again? :-/
> 
> Yes.

Thank you :-)

Rene.
