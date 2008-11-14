From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: [PATCH RESEND 0/2] ALSA SOC driver for uda134x
	codec
Date: Fri, 14 Nov 2008 17:30:54 +0100
Message-ID: <cabda6420811140830r67a29c15s6ce2093700b294c7@mail.gmail.com>
References: <1226590890496-git-send-email-chripell@gmail.com>
	<20081114105521.GD21573@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id B265724343
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:30:55 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1553098rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:30:54 -0800 (PST)
In-Reply-To: <20081114105521.GD21573@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 11:55 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Nov 13, 2008 at 04:41:30PM +0100, Christian Pellegrin wrote:
>
> A couple of minor procedural points:
>  - Normally the patches in a series are numbered starting from 1 with
>   mail 0 being a cover letter ("This series does..." or similar).
>  - Information like the "Generated on" should go after the --- with the
>   diffstat so that it doesn't go in the commit message.
>

ack

>> +++ b/include/sound/uda134x.h
>
>> +extern struct snd_soc_dai uda134x_dai;
>> +extern struct snd_soc_codec_device soc_codec_dev_uda134x;
>
> At least this should be in a header sound/soc/codecs - as I said
> previously that is the idiom used by codec drivers.  However...
>

ack

>
> ...putting this in a separate file in include/sound is a good idea.
>
> Is having UDA1340 as zero a good idea - that'll mean that if someone
> forgets to initialise the model it'll come out as UDA1340?  It might be
> better to start the model numbers from 1 so that it'll be obvious if
> that happens.  Might also be an idea to use an enum rather than the
> series of #defines?
>

good point, ack

>> --- a/sound/soc/codecs/Makefile
>> +++ b/sound/soc/codecs/Makefile
>> @@ -8,6 +8,8 @@ snd-soc-tlv320aic23-objs := tlv320aic23.o
>>  snd-soc-tlv320aic26-objs := tlv320aic26.o
>>  snd-soc-tlv320aic3x-objs := tlv320aic3x.o
>>  snd-soc-twl4030-objs := twl4030.o
>> +snd-soc-l3-objs := l3.o
>> +snd-soc-uda134x-objs := uda134x.o
>
> Please keep this and the other build stuff sorted (it helps merges).
>

I'll sort alphabetically

>> +     if (reg >= UDA134X_REGS_NUM) {
>> +             printk(KERN_ERR "%s unkown register: reg: %d",
>> +                    __func__, reg);
>
> Could use pr_error() here and elsewhere but doesn't make much difference
> either way - up to you.
>

didn't know about it. The next driver will use it because it's shorter.

>> +             pr_debug("%s costrining to %d bits at %d\n", __func__,
>
> constraining.
>

ack

>> +                     codec->write(codec, i, *cache++);
>> +             /* ADC, DAC on */
>> +             reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
>> +             uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
>> +             break;
>
> This should probably be done when going into SND_SOC_BIAS_STANDBY or at
> least _PREPARE.  The codec will be brought up to _ON whenever a playback
> or record is active, spending most of the rest of the time at _STANDBY.
> The result will be that you're syncing the register cache to the codec
> every time playback starts, even if the codec is already on.  _ON is
> expected to be very quick.

ack, I was thinking to put it in prepare but I wasn't sure.

>
>> +EXPORT_SYMBOL(uda134x_dai);
>
> Note that since ASoC core is all EXPORT_SYMBOL_GPL() it'll be difficult
> for anyone to actually use this from non-GPLed code.
>

ack

>> +             printk(KERN_ERR "UDA134X SoC codec: "
>> +                    "unsupported model\n");
>> +             return -EINVAL;
>
> Probably worth printing out what the model was set to if it's not
> recognised.
>

ack

>
> The #else should be with the definition of the functions so there's no
> need for a conditional here.
>

ack


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
