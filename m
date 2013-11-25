From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 25 Nov 2013 15:20:23 +0200
Message-ID: <52934E97.9060701@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>	<loom.20131122T215246-90@post.gmane.org>	<529004F8.7070801@iki.fi>	<20131123154009.6c8c6e97@symphony.aura-online.co.uk>	<5290CD7C.7020907@iki.fi>
 <20131124145737.22056256@symphony.aura-online.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 86D17261A0F
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 14:20:27 +0100 (CET)
In-Reply-To: <20131124145737.22056256@symphony.aura-online.co.uk>
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

24.11.2013 16:57, James Le Cuirot kirjoitti:
> On Sat, 23 Nov 2013 17:45:00 +0200
> Anssi Hannula <anssi.hannula@iki.fi> wrote:
> 
>> 23.11.2013 17:40, James Le Cuirot kirjoitti:
>>> On Sat, 23 Nov 2013 03:29:28 +0200
>>> Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>
>>>> 23.11.2013 03:05, James Le Cuirot kirjoitti:
>>>>> Anssi Hannula <anssi.hannula <at> iki.fi> writes:
>>>>>
>>>>>> Here's another revision of the ATI/AMD multichannel+HBR patchset.
>>>>>
>>>>> Hi Anssi. Many thanks for your work on this. I am very keen to
>>>>> test this new code but have so far been unsuccessful. I have a
>>>>> Radeon 4670 (Sapphire branded) connected to a Yamaha RX-V773. I
>>>>> am running the sound/for-next kernel (82755ab) with your "missing
>>>>> PCM SAD" patch applied.
>>>>>
>>>>> The new kernel has allowed ALSA to recognise the card as
>>>>> multichannel and I can issue the following speaker-test command
>>>>> but I still only hear "Front Left" and "Front Right" and the
>>>>> Yahama seems to report the signal as stereo.
>>>>>
>>>>> # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
>>>
>>>
>>>> ELD stuff is not necessary for playback, it is mostly for
>>>> information (and providing the necessary info for ELD is disabled
>>>> on radeon DRI drivers on some kernels on some GPUs ATM due to some
>>>> issues).
>>>>
>>>> Is there anything interesting in "dmesg"?
>>>
>>> I have attached my dmesg. I enabled ALSA debug and verbose printk
>>> but disabled the on-board HDA audio in the BIOS to make it less
>>> confusing, and also to see if it made any difference, which it
>>> didn't. The only entry I find noteworthy is about the ELD but you
>>> say this isn't required.
>>>
>>> There seems to be little to go on here. Would it be worth enabling
>>> CONFIG_SND_DEBUG_VERBOSE? I gather it's very noisy but maybe that
>>> level of detail is needed. Hopefully you have a better idea.
>>
>> Yeah, that would be useful.
> 
> I have now done that. It was not as noisy as I expected and only added a
> few more messages. I broke the message size limit last time so I have
> posted the log to Gist instead. The timings are noted there.
> 
> https://gist.github.com/chewi/7628058

Unfortunately everything looks OK.

Do you have any custom configuration in /etc/asound.conf or ~/.asoundrc?

To narrow it down a bit, are you able to test any of the following:
- same card on Windows,
- same card on fglrx,
- same receiver with a different AMD card,
- same receiver with an Intel/NVIDIA card?


-- 
Anssi Hannula
