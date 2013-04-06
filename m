From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Sat, 06 Apr 2013 20:52:01 +0300
Message-ID: <516060C1.9000101@sonarnerd.net>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <515E8105.9070607@gmail.com>
 <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
 <515F388D.4060707@sonarnerd.net> <515F39B9.90202@sonarnerd.net>
 <5160072E.8020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A4C264FE8
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 19:52:02 +0200 (CEST)
In-Reply-To: <5160072E.8020500@gmail.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

> All audio formats are specified in *bytes* for sample and buffer sizes,
> so we will also keep it that way for DSD.

Umm, IIRC, all the ALSA PCM API snd_pcm_*_period_size() stuff is in 
number of frames? (number of samples per channel) Thus size of the 
buffer is period size * sample size * channels (* nperiods). So if we 
would use 2.8 MHz as sampling rate for DSD, then buffer size would be 
period size * 1/8 * channels, since one sample of DSD is eight' of a byte.

And sampling rate is number of frames per second. So it is quite clear 
and non-confusing.
