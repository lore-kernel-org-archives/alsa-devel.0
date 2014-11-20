From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] pcm: add new 32-bit DSD sample format
Date: Thu, 20 Nov 2014 20:59:33 +0200
Message-ID: <546E3A15.2010004@sonarnerd.net>
References: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>
 <546CF486.7010009@sonarnerd.net> <s5hy4r6xkfu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D202605EA
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 19:59:34 +0100 (CET)
Received: from [IPv6:fc00::2] (porkkala.uworld [IPv6:fc00::2])
 by mail.sonarnerd.net (Postfix) with ESMTP id E30EA1966A0A
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 20:59:33 +0200 (EET)
In-Reply-To: <s5hy4r6xkfu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.11.2014 11:58, Takashi Iwai wrote:
>> On 10.09.2014 10:00, Jurgen Kramer wrote:
>>> +	FORMATD(DSD_U32_LE, "Direct Stream Digital, 4-byte (x32), little endian, oldest bits in MSB"),
>>
>> There is bug in this patch. The spec for these formats is, as above says
>> "little endian, oldest bits in MSB", however with the iFi iDSD Nano this
>> doesn't seem to be the case. Oldest bits are in MSB of the byte, but
>> byte order is big endian.
>
> Is it a bug of spec, or a bug of device?
> In the latter case, we'd need to introduce DSD_U32_BE format and apply
> a quirk, for example.

The device should really be flagged as DSD_U32_BE instead. So I would 
propose to add DSD_U16_BE and DSD_U32_BE formats. The DSD_U16_BE just to 
make the format list look tidy, so that when eventually it is needed, 
the formats are not in random order...


	- Jussi
