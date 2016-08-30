From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Tue, 30 Aug 2016 15:19:46 +0900
Message-ID: <1b8df791-0c18-50f7-6a64-ee1bccc30c8f@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8tve4yfb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8F74726608F
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 08:19:49 +0200 (CEST)
In-Reply-To: <s5h8tve4yfb.wl-tiwai@suse.de>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, clemens@ladisch.de, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

On Aug 30 2016 14:29, Takashi Iwai wrote:
> On Tue, 30 Aug 2016 01:44:42 +0200,
> Takashi Sakamoto wrote:
>>
>> TLV feature of control interface is originally introduced at
>> commit 42750b04c5ba ("[ALSA] Control API - TLV implementation for
>> additional information like dB scale") and commit 8aa9b586e420 ("[ALSA]
>> Control API - more robust TLV implementation"). In this time,
>> snd_kcontrol_tlv_rw_t is for generating and transferring information about
>> threshold level for applications.
>>
>> This feature can transfer arbitrary data in a shape of an array with
>> members of unsigned int type, therefore it can be used to deliver quite
>> large arbitrary data from user space to in-kernel drivers via ALSA control
>> character device. Focusing on this nature, commit 7523a271682f ("ASoC:
>> core: add a helper for extended byte controls using TLV") introduced
>> snd_soc_bytes_tlv_callback() just for I/O operations.
>>
>> In this case, typically, APIs return operated length, while TLV feature
>> can't. This is inconvenient to applications.
>
> The ASoC TLV (ab)usage still takes / receives the length field of
> TLV.  What's missing there?

I don't get exactly what you mean.

The issue in which I'm interested is that applications cannot get to 
know length of actual processed bytes. Nothing others.

When pure threshold level information is transferred, applications can 
get its length of TLV packet payload, because we have a loose protocol 
to store the length of data in second element of the payload. The size 
of 2 elements plus the length equals to the length of TLV packet payload.

When using TLV feature just for I/O, this protocol is not kept, as we 
can see implementation of 'soc_bytes_ext' operation. Thus, the number of 
processed bytes should be returned to applications, by any ways. This 
patchset uses 'length' field in TLV packet header.


Regards

Takashi Sakamoto
