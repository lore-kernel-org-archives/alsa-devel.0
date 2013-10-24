From: Mihai Moise <mihai.moise5@gmail.com>
Subject: Re: Bug report Realtek ALC887-VD HDA Intel tone://15000
Date: Thu, 24 Oct 2013 15:12:47 -0400
Message-ID: <CAEha1fQvv_D13gEo0hJc8FDc-AS-cS2hYbcgi=FDSwfY_TWoPQ@mail.gmail.com>
References: <CAEha1fQ6sTp6dXfX3_88raLG6YJJX23ECi8skPVmD5mmj3eVsA@mail.gmail.com>
 <CAEha1fTEsqXNMEhepG+t=68RxDpHkNFOG9VFga2jmNmRZSXfJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 93BE1261599
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 21:20:55 +0200 (CEST)
Received: by mail-vb0-f48.google.com with SMTP id w16so1567227vbf.21
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 12:20:54 -0700 (PDT)
In-Reply-To: <CAEha1fTEsqXNMEhepG+t=68RxDpHkNFOG9VFga2jmNmRZSXfJA@mail.gmail.com>
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

This e-mail might not be threaded well. It is a follow-up to:

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067158.html

I found what causes the ALSA bug I wrote about on 10 Oct. aplay uses this:

Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
Converter: linear-interpolation

It is located at alsa-lib-1.0.27.2.10.gc1fbd/src/pcm/pcm_rate_linear.c
It apears to be a resampler with linear interpolation.

The bug I wrote about is caused because linear interpolation is not
good. I don't mean that there is a programming error. I mean that the
mathematical theory is flawed.

Linux-3.12-rc4 has a resampler at sound/core/oss/rate.c which I'm
guessing is ALSA's OSS compatibility layer (OSS for short). It uses
linear interpolation and is mathematically equivalent to the alsa-libs
resampler. Then it should sound as bad, but the OSS driver in my
Slackware-64 14, which is ALSA's OSS compatibility layer, sounds
inexplicably good even on a sine generator. So I started thinking that
ALSA's OSS compatibility layer puts the Realtek ALC887-VD in 44.1 KHz
mode.

I have been messing up linux-3.12-rc4 adding printk(KERN_ERRs to see
where the code goes through and changing the ALSA's OSS resamplers
so they only play garbage sound. But my song still sounds good when
played with sox's option -r 44100 -t oss -d So far, everything has
held up to my hypothesis.

I added this line to
linux-3.12-rc4/sound/pci/hda/hda_codec.c:snd_hda_query_supported_pcm

                u32 rates = 0;
                for (i = 0; i < AC_PAR_PCM_RATE_BITS; i++) {
                        if (val & (1 << i))
                                rates |= rate_bits[i].alsa_bits;
                }
                printk(KERN_ERR "mihai rates = %d decimal\n", rates);

Result:

mihai rates = 5312 decimal
mihai rates = 5856 decimal

I don't know what these numbers mean. According to
linux-3.12-rc4/include/sound/pcm.h that would mean 192KHz. So that's
not the interpretation.

I added this line to linux-3.12-rc4/sound/core/oss/rate.c:resample_expand:

printk(KERN_ERR "Entered resample_expand\n");

Result: nothing in /var/log/syslog, even after playing 44.1KHz audio
through sox's option -r 44100 -t oss -d

I added this line to linux-3.12-rc4/sound/core/oss/rate.c:resample_shrink:

printk(KERN_ERR "Entered resample_shrink\n");

Result: nothing in /var/log/syslog

I made  linux-3.12-rc4/sound/core/oss/rate.c:resample_expand play
garbage audio like this:

                        *dst = val;
                        if(((long)dst) & 4) *dst = 32767;
                        else *dst = -32767;
                        dst += dst_step;

And I made linux-3.12-rc4/sound/core/oss/rate.c:resample_shrink play
garbage audio like this:

                                *dst = val;
                                if(((long)dst) & 4) *dst = 32767;
                                else *dst = -32767;
                                dst += dst_step;

Result: playing a 44.1KHz song through sox's option -r 44100 -t oss -d
plays just fine.

I would appreciate if someone would clarify me if ALSA's OSS
compatibility layer puts the Realtek ALC887-VD in 44.1KHz mode.
