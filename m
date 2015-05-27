From: Adam Goode <adam@spicenitz.org>
Subject: Re: Scarlett 18i8 hardware out of sync with AlsaMixer
Date: Wed, 27 May 2015 08:55:21 -0400
Message-ID: <CADN=WdpM_gUD=TpxP9cJmS3VXRwzgODgNeNE0Z2EwC71mZ8yAw@mail.gmail.com>
References: <CADN=WdobTC9qdHjKD3PyPW99f2pX-j82vVzZ32zp4ed-C0Gbgg@mail.gmail.com>
 <s5h8ucaed12.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C720265967
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 14:55:43 +0200 (CEST)
Received: by oihb142 with SMTP id b142so6385728oih.3
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 05:55:42 -0700 (PDT)
In-Reply-To: <s5h8ucaed12.wl-tiwai@suse.de>
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

The settings were not reset across a mem sleep (echo mem > /sys/power/state).

Hard power off / power on does make the settings get out of sync.




Adam


On Wed, May 27, 2015 at 2:43 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 26 May 2015 21:39:22 -0400,
> Adam Goode wrote:
>>
>> Linux 4.0.2-300.fc22.x86_64
>>
>> Hi,
>>
>> I have the Scarlett 18i8 USB device that is supported by the new
>> scarlett_mixer.c code. I am happy to say that the mixer code works in
>> most cases. But under some conditions, I cannot get any sound out of
>> the device until I go and toggle the "Matrix 01 Input" and "Matrix 02
>> Input" enums up and then down (from PCM 1 and PCM 2). This appears to
>> me to be some kind of cache invalidation bug, where the device is out
>> of sync with kernel mixer state.
>>
>> I will take a look at the code myself at some point, but not for a
>> while. But I am happy to try patches if anyone comes up with anything
>> in the mean time.
>
> Does it happen after some S3/S4 or even during a normal operation
> without power-saving?  The USB-audio device supports autopm, so this
> needs to be checked, too.
>
>
> Takashi
