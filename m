From: Mihai Moise <mihai.moise5@gmail.com>
Subject: Re: Bug report Realtek ALC887-VD HDA Intel tone://15000
Date: Thu, 24 Oct 2013 08:34:03 -0400
Message-ID: <CAEha1fTEsqXNMEhepG+t=68RxDpHkNFOG9VFga2jmNmRZSXfJA@mail.gmail.com>
References: <CAEha1fQ6sTp6dXfX3_88raLG6YJJX23ECi8skPVmD5mmj3eVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id DC31B261AF8
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 14:34:06 +0200 (CEST)
Received: by mail-vc0-f174.google.com with SMTP id ld13so992952vcb.5
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 05:34:03 -0700 (PDT)
In-Reply-To: <CAEha1fQ6sTp6dXfX3_88raLG6YJJX23ECi8skPVmD5mmj3eVsA@mail.gmail.com>
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

I have written a resampler for ALSA. It uses S+P with a symmetric
predictor which models fourth order polynomials, 8 times oversampling
followed by integration. S+P is described at,

http://www.cipr.rpi.edu/research/SPIHT/EW_Code/ip96_sp.pdf

You can take it for a testdrive:

gcc resample.c -lm -o resample

perl -e '$|++;binmode(STDOUT);$_ = 0;while(1) {print
pack("v",32767.0*sin(($_&(~1))*3.14159265*15000/44100.0));++$_;}' |
./resample | aplay -f dat

sox -V4 mysong.wav -b 16 -c 2 -r 44100 -e signed-integer -t raw - |
./resample | aplay -f dat

I found what causes the ALSA bug I wrote about Oct 10. aplay uses this:

Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
Converter: linear-interpolation

It is located at alsa-lib-1.0.27.2.10.gc1fbd/src/pcm/pcm_rate_linear.c
It apears to be a resampler with linear interpolation.

The bug I wrote about is caused because linear interpolation is not good.

Linux-3.12-rc4 has a resampler at sound/core/oss/rate.c which I'm
guessing is ALSA's OSS compatibility layer (OSS for short). It uses
linear interpolation and is mathematically equivalent to the alsa-libs
resampler. Then it should sound as bad, but the OSS driver in my
Slackware-64 14, which is ALSA's OSS compatibility layer, sounds
inexplicably good even on a sine generator. So I started thinking that
ALSA's OSS compatibility layer puts the Realtek ALC887-VD in 44.1 KHz
mode.

I have been messing up linux-3.12-rc4 adding printk(KERN_ERRs to see
where the code goes through and sabotaging the ALSA's OSS resamplers
so they only play garbage sound. But my song still sounds good when
played with sox's OSS driver. So far, everything has held up to my
hypothesis.

I added this line to linux-3.12-rc4/sound/pci/hda/hda_codec.c :

u32 rates = 0;
                for (i = 0; i < AC_PAR_PCM_RATE_BITS; i++) {
                        if (val & (1 << i))
                                rates |= rate_bits[i].alsa_bits;
                }
                printk(KERN_ERR "mihai rates = %d decimal\n", rates);


On 10/9/13, Mihai Moise <mihai.moise5@gmail.com> wrote:
> I am writing to report a bug with ALSA that affects XMMS and Audacious.
>
> I have a Realtek ALC887-VD HDA Intel. I tested with kernel 3.12-rc4
> and alsa-libs 1.0.27.2.10.gc1fbd and alsa-oss-1.0.25.2.g39df1 library.
> I also compiled and installed alsa-utils-1.0.27.2.6.gf1e99 which made
> me realize I had to move the libraries from /usr/lib to /usr/lib64.
>
> Playing tone://15000 in Audacious or XMMS with the ALSA driver without
> resampling sounds bad (in XMMS there is no resampling option).
>
> How to reproduce the bug:
>
> Play in XMMS tone://10
>
> In Audacious you would have to lower the volume by 6 dB to get the
> same sound volume as in XMMS because it pre-amplifies sounds.
>
> Lower the PC-volume until you stop hearing clicks. To hear the clicks
> you need headphones and to raise the real-life amplifier volume all
> the way up. For me it is,
>
> Master: 91%
> PCM: 100%
> Front: 60%
>
> Select the ALSA driver and no resampling in Audacious (I think
> Audacious comes with no resampling as the default setting which is why
> this is so important).
>
> Play tone://15000
>
> It is supposed to sound like this:
>
> perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
> pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/48000.0));++$_;}' |
> aplay -f dat
>
> but it sounds like this:
>
> perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
> pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/44100.0));++$_;}' |
> aplay -f cd
>
> This is how it sounds like if the OSS driver is invoked:
>
> perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
> pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/44100.0));++$_;}' |
> sox -V4 -b 16 -c 2 -r 44100 -e signed-integer -t raw - -r 44100 -t oss
> -d
>
> On my computer, the first and third command lines sound good, the
> second command line sounds bad.
>
> When using the OSS driver in XMMS it sounds like the first and third
> command lines.
>
> To go into more details: when using the ALSA driver in XMMS, for
> frequencies higher than tone://10000 the main frequency gets swamped
> by lower harmonics, so the frequency heard seems to drop the higher it
> increases. At tone://15000 what is heard is a louder lower harmonic.
>
> My suggestion is: could there be a way to force ALSA to resample the
> sound when using an ALC887-VD and/or a Realtek chipset and/or HDA
> Intel...
>
