From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 0/5] ALSA: snd-usb: add support for DSD
Date: Wed, 17 Apr 2013 13:03:33 +0200
Message-ID: <516E8185.9050705@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
 <s5hsj2pbexz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 12D8F261616
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 13:03:23 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id y8so709112bkt.38
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 04:03:22 -0700 (PDT)
In-Reply-To: <s5hsj2pbexz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Jussi Laako <jussi@sonarnerd.net>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 17.04.2013 12:59, Takashi Iwai wrote:
> At Wed, 17 Apr 2013 00:01:35 +0800,
> Daniel Mack wrote:
>>
>> In contrast to the first two approaches, this one keeps the userspace
>> unaware of the actual transport on the bus.
>>
>> More specifically, the DSD_U16_LE format may be implemented to actually
>> send DOP samples to the device, depending on the quirks entries.
>>
>> Also, as there is quite some confusion in both data file formats as
>> well as hardware sample formats about whether to stuff the oldest bit
>> in the MSB or the LSB of a byte, ALSA defines that now to be in the
>> MSB, as far as the ALSA userspace layer is concerned. The driver
>> learned functions to re-encode the bytes according to what the hardware
>> supports.
>>
>> I also wrote a very basic test tool which I published here:
>>
>>   https://github.com/zonque/alsa-dsd-player
>>
>>
>> Thanks,
>> Daniel
>>
>> Daniel Mack (5):
>>   ALSA: add DSD formats
>>   ALSA: snd-usb: use ep->stride from urb callbacks
>>   ALSA: snd-usb: add support for DSD DOP stream transport
>>   ALSA: snd-usb: add support for bit-reversed byte formats
>>   ALSA: snd-usb: add quirks handler for DSD streams
> 
> All patches look OK to me through a quick glance, so I'm going to
> apply them later, unless anyone has objection.

I'd like to wait for another day or so for Jussi to state his oppinion.
He seems to be the only one on this list who has ever dealt with DSD on
Linux, so we should listen to him ;)



Thanks,
Daniel
