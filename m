From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for 24
 bit samples
Date: Tue, 09 Oct 2012 14:21:48 +0200
Message-ID: <507416DC.6030207@ladisch.de>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
 <5073F2CD.9010407@gmail.com>
 <20121009102331.GB15207@opensource.wolfsonmicro.com>
 <507403DB.5050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BC16C261601
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 14:17:44 +0200 (CEST)
In-Reply-To: <507403DB.5050003@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On 09.10.2012 12:24, Mark Brown wrote:
>>> On 09.10.2012 11:41, Mike Looijmans wrote:
>>>> Sorry for the lack of quoting, but I onle get the digest.
>>
>>>> These are wrong:
>>
>>>> +       case SNDRV_PCM_FORMAT_U24_LE:
>>>> +       case SNDRV_PCM_FORMAT_S24_LE:
>>
>>>> These pack a 24-bit sample value in a 32-bit word. The codec will
>>>> send 32 bits to the McASP, and you should transfer 32 bits to the
>>>> user, not just 24. Hence, SNDRV_PCM_FORMAT_S24_LE must be treated
>>>> just like SNDRV_PCM_FORMAT_S32_LE.
>>
>> The above explanation isn't quite right.  For 24 bit the CODEC should be
>> working with 24 bits on the wire (though obviously extra BCLKs are
>> allowed) and the AP should be working with 32 bit words in memory.  The
>> issue here is probably that you're working with real 24 bit data in RAM
>> too.
>
> Hmm, I don't understand. I thought S24_3LE exists to denote a 3-byte
> representation

Yes.

The three possibilities to store little-endian signed 24-bit samples in
memory are (where L=LSB, M=MSB):

  0padding LLLLLLLL MMMMMMMM HHHHHHHH  S32_LE
  LLLLLLLL MMMMMMMM HHHHHHHH 0padding  S24_LE
  LLLLLLLL MMMMMMMM HHHHHHHH           S24_3LE

The first two require the DMA controller to transfer four bytes, the
last one, three bytes.

All three use (at least) 24 bits on the wire.

Mark is right, unless your DMA controller actually happens to support
three-byte samples, with all the alignment problems that entails.
S24_3LE was introduced for USB controllers that are too dumb to
differentiate between memory and on-the-wire formats; nobody else
should want to use it.  (But if the hardware supports it, you might
as well allow it, if you implement it correctly.)

> Hence Mike would be right that S24_LE has to use a 4-byte dma transfer
> size, no?

Yes.


Regards,
Clemens
