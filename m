From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Sat, 23 Nov 2013 17:45:00 +0200
Message-ID: <5290CD7C.7020907@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org> <529004F8.7070801@iki.fi>
 <20131123154009.6c8c6e97@symphony.aura-online.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id C4BB3261693
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 16:45:04 +0100 (CET)
In-Reply-To: <20131123154009.6c8c6e97@symphony.aura-online.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

23.11.2013 17:40, James Le Cuirot kirjoitti:
> On Sat, 23 Nov 2013 03:29:28 +0200
> Anssi Hannula <anssi.hannula@iki.fi> wrote:
> 
>> 23.11.2013 03:05, James Le Cuirot kirjoitti:
>>> Anssi Hannula <anssi.hannula <at> iki.fi> writes:
>>>
>>>> Here's another revision of the ATI/AMD multichannel+HBR patchset.
>>>
>>> Hi Anssi. Many thanks for your work on this. I am very keen to test
>>> this new code but have so far been unsuccessful. I have a Radeon
>>> 4670 (Sapphire branded) connected to a Yamaha RX-V773. I am running
>>> the sound/for-next kernel (82755ab) with your "missing PCM SAD"
>>> patch applied.
>>>
>>> The new kernel has allowed ALSA to recognise the card as
>>> multichannel and I can issue the following speaker-test command but
>>> I still only hear "Front Left" and "Front Right" and the Yahama
>>> seems to report the signal as stereo.
>>>
>>> # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
>>
>> I guess it is the same without "-t wav"?
> 
> Yes.
> 
>>> I have the HDMI cable plugged
>>> into the secondary output as my speakerless DVI monitor is plugged
>>> into the primary but I have also tried the HDMI cable in the
>>> primary output by itself.
>>
>> Hmm, I'm not sure what the behavior is supposed to be with multiple
>> video outputs when we have only a single audio output (HDA pin)...
>>
>> What happens if you plug both of your outputs to the A/V receiver,
>> will only one output get audio?
> 
> I tried this and as I expected, it sent the same audio to both outputs.
> Still stereo only though.
> 
>> ELD stuff is not necessary for playback, it is mostly for information
>> (and providing the necessary info for ELD is disabled on radeon DRI
>> drivers on some kernels on some GPUs ATM due to some issues).
>>
>> Is there anything interesting in "dmesg"?
> 
> I have attached my dmesg. I enabled ALSA debug and verbose printk but
> disabled the on-board HDA audio in the BIOS to make it less confusing,
> and also to see if it made any difference, which it didn't. The only
> entry I find noteworthy is about the ELD but you say this isn't
> required.
> 
> There seems to be little to go on here. Would it be worth enabling
> CONFIG_SND_DEBUG_VERBOSE? I gather it's very noisy but maybe that level
> of detail is needed. Hopefully you have a better idea.

Yeah, that would be useful.

Also, forgot to mention, but next time please indicate the part of the
log where you start the multichannel speaker-test command (e.g. timestamps).

-- 
Anssi Hannula
