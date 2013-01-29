From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Tue, 29 Jan 2013 20:14:47 +0100
Message-ID: <51081FA7.70907@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 85516261609
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 20:14:49 +0100 (CET)
Received: by mail-bk0-f53.google.com with SMTP id j10so463876bkw.40
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 11:14:49 -0800 (PST)
In-Reply-To: <510798CC.3080006@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 29.01.2013 10:39, schrieb Pavel Hofman:
>>> What does the ak4114 regs dump in /proc/asound... dir of your
>>> audiophile192 look like? The snd_ak4114_proc_regs_read method reads real
>>> values from the regs.
>> You know what, there ist no ak4114... See the attached
>> Audiophile192-proc.txt. That's everything in proc.
>> Before I was doing some printk's in snd_ak4114_create() and
>> snd_ak4114_reg_write() and other places. They ended up in kern.log.
>> Then was also fiddling around with the configuration (ak4114_init_vals)
>> which didn't change anything in the capture behaviour. I even entirely
>> removed the snd_ak4114_create() call. It was still just capturing spdif
>> 6 dB to loud with the shifted signals as described before.
>> So the ak4114 code is not in operation at all?
> First, please tell us your alsa version (/proc/asound/version)

~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.25.
Compiled on Jan 28 2013 for kernel 3.5.0-22-generic (SMP).

~$ uname -a
Linux proto2c 3.5.0-22-generic #34-Ubuntu SMP Tue Jan 8 21:41:11 UTC 
2013 i686 athlon i686 GNU/Linux

By the way, I'm compiling a driver snapshot from 24-01-2013. The plain 
1.0.25 gives errors.


> Please move the ak4114 init call from the controls section to the init
> section (just like in juli.c) and test:
>
> diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
> index 7641080..bb6c82a 100644
> --- a/sound/pci/ice1712/revo.c
> +++ b/sound/pci/ice1712/revo.c
> @@ -562,6 +562,9 @@ static int revo_init(struct snd_ice1712 *ice)
>                                                 ice);
>                  if (err < 0)
>                          return err;
> +               err = ap192_ak4114_init(ice);
> +               if (err < 0)
> +                       return err;
>
>                  /* unmute all codecs */
>                  snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
> @@ -597,9 +600,6 @@ static int revo_add_controls(struct snd_ice1712 *ice)
>                  err = snd_ice1712_akm4xxx_build_controls(ice);
>                  if (err < 0)
>                          return err;
> -               err = ap192_ak4114_init(ice);
> -               if (err < 0)
> -                       return err;
>                  break;
>          }
>          return 0;

I did that with no success. Same behaviour, no change, still no ak4114. 
The only difference I got was:

$ diff ~/Audiophile192-proc-a.txt ~/Audiophile192-proc-b.txt
90c90
<   MT05     : 0x08
---
 >   MT05     : 0x00

I printk'ed a message in ap192_ak4114_init() and it's definitely being 
called.

Any other ideas?

- Jonas
