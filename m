From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Sat, 06 Apr 2013 19:58:34 +0200
Message-ID: <5160624A.7070804@gmail.com>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <515E8105.9070607@gmail.com>
 <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
 <515F388D.4060707@sonarnerd.net> <515F39B9.90202@sonarnerd.net>
 <5160072E.8020500@gmail.com> <516060C1.9000101@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5D9265038
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 19:58:27 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id i18so2509811bkv.14
 for <alsa-devel@alsa-project.org>; Sat, 06 Apr 2013 10:58:27 -0700 (PDT)
In-Reply-To: <516060C1.9000101@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 06.04.2013 19:52, Jussi Laako wrote:
>> All audio formats are specified in *bytes* for sample and buffer sizes,
>> so we will also keep it that way for DSD.
> 
> Umm, IIRC, all the ALSA PCM API snd_pcm_*_period_size() stuff is in 
> number of frames? (number of samples per channel)

I was talking about the SND_PCM_FORMAT_ definitions that I augmented.
What they denote is bytes per sample frame, not bits.

> Thus size of the 
> buffer is period size * sample size * channels (* nperiods). So if we 
> would use 2.8 MHz as sampling rate for DSD, then buffer size would be 
> period size * 1/8 * channels, since one sample of DSD is eight' of a byte.

No, you would choose 1/8 of the actual sample rate, because the actual
transport goes in multiple of 8 bits.

> And sampling rate is number of frames per second. So it is quite clear 
> and non-confusing.

... and one frame is also just 8 bits (or 16, for the second format). I
think that matches the logic quite well.


Daniel
