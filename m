From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: channel names
Date: Fri, 08 Feb 2013 15:00:20 +0100
Message-ID: <511504F4.1010307@ladisch.de>
References: <51141B43.7070108@drcomp.erfurt.thur.de>
 <s5hbobv8fga.wl%tiwai@suse.de> <51150004.7000203@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 0D9C02615E5
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 15:00:23 +0100 (CET)
In-Reply-To: <51150004.7000203@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Knoth wrote:
> I'm afraid the channel map may not work for pro-audio interfaces. While
> consumer devices will surely benefit from a label like
>
>    SNDRV_CHMAP_RRC,        /* rear right center */
>
> professional-grade cards simply don't have such channel names.
>
> Instead, "our" channels have names like
>
>    ADAT 7
>    Line 12
>    Bus 14L
>
> or however else the vendor decided to call (and physically label) them.

That's what the SNDRV_CHMAP_DRIVER_SPEC flag is for.

Furthermore, there isn't necessarily a 1:1 mapping between PCM channels
and physical I/Os.

> How about struct snd_pcm_channel_info?
>
> Maybe there are better places for such an extension, I'm not an ALSA-API
> expert.

That place would be the ALSA media controller API.
(I should implement it some day ...)


Regards,
Clemens
