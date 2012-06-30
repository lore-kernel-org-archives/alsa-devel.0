From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/2] RFC: support for audio wall clock
Date: Sat, 30 Jun 2012 09:03:49 +0800
Message-ID: <CAN8cciZR73c74p6yTDn7qu4CKJUC_o7d4mwQthFmAtC9j3SzVw@mail.gmail.com>
References: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F1B2B24455
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 03:03:49 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so2671250wgb.20
	for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2012 18:03:49 -0700 (PDT)
In-Reply-To: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Manuel Jander <manuel.jander@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/6/29 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:
> V2 of patches to show how the audio wall clock (eg. the
> HDAudio one) can be used to provide precise audio timestamps and track
> the drift between audio time and system time. On my laptop I am able
> to track a 7ppm delta.
> I will explain in more details how this can be
> used during LPC in San Diego, but with the summer coming I'd like to
> get feedback as there are changes to the core/alsa-lib that haven't
> been modified in years.
>
> TODO:
> - 64-bit alignment, verification of pcm_compat.c changes
> - handling of digital inputs, need to disable wall-clock timestamps in that case (feedback from Clemens)
> - check differences in protocol
> - change timecounter to avoid accumulation of rounding errors in cycle->ns conversions
> - check overflows
> - rework the timecounter init on trigger

Do suspsend/resume affect the usage of the wall clock ?

Those au88x0 also have a 32 bit register which return the ticks from a
12.288 Mz oscillator (i.e. 256 x 48000Hz) , this register wrap around
in around 349.5 seconds

Can this clock be used to determine the drift too ?
