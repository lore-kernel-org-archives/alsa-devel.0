From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] ALSA: usb: supply channel maps even when
 wChannelConfig is unspecified
Date: Mon, 04 Nov 2013 10:20:12 +0100
Message-ID: <527766CC.2050609@canonical.com>
References: <1383320339-22666-1-git-send-email-david.henningsson@canonical.com>
 <s5hzjpkr1ai.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 59CA5261A54
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 10:20:15 +0100 (CET)
In-Reply-To: <s5hzjpkr1ai.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/04/2013 09:58 AM, Takashi Iwai wrote:
> At Fri,  1 Nov 2013 16:38:59 +0100,
> David Henningsson wrote:
>>
>> If wChannelconfig is given for some formats but not others, userspace
>> might not be able to set the channel map.
>>
>> This is RFC because I'm not sure what the best behaviour is - to guess
>> the channel map from the given number of channels (it's quite likely
>> that one channel is MONO and two channels is FL FR), or just to supply
>> UNKNOWN for all channels.
>>
> 
> In the case of USB-audio, I guess this is OK to fill the guessed
> chmaps, especially for the mono channel.  So I can take this patch if
> you already tested on your device.
> 
>> But the complete lack of channel map for a format leads userspace to
>> believe that the format is not available at all. Or am I
>> misunderstanding how this should be used?
> 
> The chmap is just an optional information, thus excluding the format
> due to the lack of chmap doesn't sound right.  The lack of chmap means
> merely that the hardware doesn't give the chmap information, but the
> format itself must be available.
> 
> So, in the case of PA, I'd expect it handles such a format as is of
> now, just guessing / using the pre-defined chmaps.

Ok, can you clarify this (theoretical) example:

I wanted to use the channel mapping API to distinguish between 2.1
surround and 4.0 surround.
Now assume we're connected to some device, successfully set hw params to
four output channels.
When then asking for maps through query_chmaps, it returns one chmap
only, and its value is "FL FR".

What should PA do in this situation?

 1) Skip both 2.1 and 4.0 surround, after all, it supports only FL FR chmap.

 2) Allow both 2.1 and 4.0 surround, since we did not get a chmap that
had the same amount of channels as we set the hwparams to.

 3) Either option 1 or 2, but also complain loudly about the fact that
we set the hwparams to 4 channels but got a chmap that wasn't 4
channels, and ask ALSA developers to fix the driver.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
