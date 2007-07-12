From: TJ <tj.trevelyan@gmail.com>
Subject: Re: [RFC] SGI O2 MACE audio ALSA module
Date: Thu, 12 Jul 2007 14:24:00 +0100
Message-ID: <6849c8890707120624o308d53ep88c5b8939903449f@mail.gmail.com>
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
	<s5hejjpaiwa.wl%tiwai@suse.de>
	<6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
	<s5h644rjmn2.wl%tiwai@suse.de>
	<37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 130F024361
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 15:24:01 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so169492wag
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 06:24:00 -0700 (PDT)
In-Reply-To: <37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "sknauert@wesleyan.edu" <sknauert@wesleyan.edu>
Cc: Linux MIPS List <linux-mips@linux-mips.org>, ALSA Dev List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

All playback sounds too fast, some players seem faster then others,
but I maybe wrong on that. The source file's sample rate seems to make
no difference, i've tried 22k,34k,44k,48k.

I have now been given a sin wave generator script, which I've been
meaning to try, but I lack an OCR so I will have to rely on my
hearing.

ALSA doesn't need to change sample rate, nor will it if the sample is
within the range supported/reported by the driver (as far as i know).

Mace audio supports 8k to 48k. You can look at the set clock speed for
the DAC in /proc/asound/card0/ad1843

You can manually override the clock speed by playing with
ad1843_setup_dac in ad1843.c

You can try lying to ALSA by playing with snd_mace_audio_hw[1] (or
sma_audio_hw[1]) in mace_audio.c

If anyone can see why it plays too fast, please let me know.

Thorben

On 12/07/07, sknauert@wesleyan.edu <sknauert@wesleyan.edu> wrote:
> Okay, I got the module compiled and it and ALSA installed.
>
> I noticed the timing bug, I doubt its a frequency issue as the ALSA guides
> to downsample (i.e. if it were doing 48kHz instead of 44.1kHz) didn't
> help.
>
> You mentioned on some players it would sound okay? I tried everything from
> aplay to xmms and always seemed to play too fast. What CPU are you running
> this on, by the way? Aplay does give underruns if I'm heavily
> multitasking, though sound output seems the same.
>
>
