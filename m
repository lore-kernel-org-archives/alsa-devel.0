From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 10/10] ALSA: hda: replace .wallclock by
	.get_time_info
Date: Sat, 20 Dec 2014 14:07:44 +0800
Message-ID: <CAN8cciZS2d68UFRN08dHcyjN8Ajud-_JRyoMLcK9-ZEp2cQhTw@mail.gmail.com>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1419009913-3686-11-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f47.google.com (mail-qa0-f47.google.com
 [209.85.216.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CC0B260525
 for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2014 07:07:45 +0100 (CET)
Received: by mail-qa0-f47.google.com with SMTP id n4so1505707qaq.34
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 22:07:44 -0800 (PST)
In-Reply-To: <1419009913-3686-11-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> No real functional change, only take wall clock and system time
> in same routine and add accuracy report.
>
>
> +               *audio_ts = ns_to_timespec(nsec);
> +
> +               audio_tstamp_report->actual_type =
SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
> +               audio_tstamp_report->accuracy_report = 1; /* rest of
structure is valid */
> +               audio_tstamp_report->accuracy_m = 42; /* 24 MHz WallClock
== 42ns resolution */
> +               audio_tstamp_report->accuracy_e = 0;
> +

Do you mean wall clock run at 48000 * 500 Hz ? 42.666ns

Those aureal sound cards also can provide time stamp using VORTEX_SMP_TIME
mmio register which tick at 48000 * 256 Hz ?
