From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 3/3] snd_pcm_start_at: Implement
 snd_pcm_start_at for system and audio tstamp types.
Date: Thu, 18 Dec 2014 07:37:50 +0800
Message-ID: <CAN8cciYLnTBreS=wf4Ax4o8r-zLJ9fYaTXeyQd-fosaXdn_nVA@mail.gmail.com>
References: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
 <1418837365-19398-3-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f169.google.com (mail-qc0-f169.google.com
 [209.85.216.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F18F226145B
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 00:37:50 +0100 (CET)
Received: by mail-qc0-f169.google.com with SMTP id w7so86449qcr.14
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 15:37:50 -0800 (PST)
In-Reply-To: <1418837365-19398-3-git-send-email-timcussins@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>
Cc: nstoughton@aether.com, tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

>
> System tstamp types rely on high-res timers.
> Audio tstamp types delegate to the pcm driver.
> Current start_at timer is cancelled on attempt to change stream state.

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=test/timer.c;hb=HEAD

Are there any difference between sound card's timer with high res
timer/wall clock time stamp ?

It seem those sound cards timer have resolution and max tick

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/ymfpci?id=6e2efaacb3579fd9643d0dc59963b58b801c03a1

snd_timer_status_get_resolution

The clock tick counters are 32 bits and wrap around

This may mean that snd_pcm_start_at can only start within certian time
interval
