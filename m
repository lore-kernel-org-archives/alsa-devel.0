From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Fri, 25 Jul 2008 11:59:16 +0200
Message-ID: <4889A3F4.5050903@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>	<20080724072620.4197510c.krzysztof.h1@poczta.fm>	<4888B993.2040101@keyaccess.nl>	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>	<4888D854.40509@keyaccess.nl>
	<20080724234114.a8f6bcf3.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AE8EF24528
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 11:56:55 +0200 (CEST)
In-Reply-To: <20080724234114.a8f6bcf3.krzysztof.h1@poczta.fm>
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

On 24-07-08 23:41, Krzysztof Helt wrote:

> On Thu, 24 Jul 2008 21:30:28 +0200
> Rene Herman <rene.herman@keyaccess.nl> wrote:

>>>> *** 0005-wss_lib-use-wss-constants-instead-of-ad1848-ones.patch
>>>>
>>>>> --- a/sound/isa/ad1848/ad1848_lib.c
>>>>> +++ b/sound/isa/ad1848/ad1848_lib.c
>>>>> @@ -283,14 +283,12 @@ static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
>>>>>                         return 0;
>>>>>                 }
>>>>>                 snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
>>>>> -               chip->mode |= AD1848_MODE_RUNNING;
>>>> Is this now done in generic code? Not necessary anymore? Was no comment 
>>>> in the changelog.
>>> The MODE_RUNNING is not used at all in the cs4231 code. I wonder what the purpose of it.
>> It was used by the AD1848 code though; snd_ad1848_trigger() set/reset it 
>> on start/stop and it was then tested by snd_ad1848_interrupt() to decide 
>> whether or not to call snd_pcm_period_elapsed().
> 
> It is not used by the cs4231. The only difference is that ad1848 does not 
> call the snd_pcm_period_elapsed() after calling the snd_ad1848_open()
> but before calling the snd_ad1848_trigger() (and similar restriction
> after the snd_ad1848_trigger() and snd_ad1848_close().
> 
> The cs4231 does not use such restriction. I decided it does not really matter.
> The interrupts are not enabled before and after the snd_ad1848_trigger().
> If the cs4231 driver needed this it would be already causing problems.

It seems we are talking at cross purposes. I'm not talking about cs4231. 
I see this MODE_RUNNING thing disappear from ad1848_lib and, unless I've 
missed it, not resurface in wss_lib -- that library that after these 
patches is used to drive AD1848 chips that used to be driven by ad1848_lib.

The MODE_RUNNING looks as something someone will have once added upon 
seeing spurious IRQs and as such, testing that it isn't needed on 
chip/card A, B and C doesn't tell us much. The problem may have been 
observed on type D, E or F and/or under condition foo or bar.

Looking at snd_wss_interrupt() I dom't seem to be seeing a similar guard 
after these patches.

If it's not needed, all for slashing it but please be convincing. Note 
that by now you should know a lot more about the innards of this code 
than I do, so please be as verbose as needed.

Rene.
