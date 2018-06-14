From: noman pouigt <variksla@gmail.com>
Subject: Slow SPI reads in ALSA causing mic recording error
Date: Thu, 14 Jun 2018 02:12:35 -0700
Message-ID: <CAES_P+96hMOrbtVekpUC6dJg8Znmq9a8VSVU7hNAA5XG00eYjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F8652673F2
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 11:12:38 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so2641697pgr.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 02:12:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Folks,

I have a DSP hardware connected over SPI
to SoC with extra interrupt line.

I am getting buffer overrun problem in DSP
while doing MIC recording. SoC SPI consecutive reads
are two slow and it is not able to empty DSP buffers
in time which causes DSP to issue overruns interrupts
to SoC and causes bad mic data recording.

ARECORD properly records mic data but when I try to use
AudioFlinger(android) then I see buffer overrun issue in
DSP. Period size is same in both arecord and AudioFlinger case.

system: arm64, latest mainline kernel, latest alsa-lib

I have below platform ops
static const struct snd_pcm_ops platform_ops = {
     .open    = platform_open,
     .ioctl      = snd_pcm_lib_ioctl,
     .pointer  = platform_pcm_pointer,
     .mmap    = snd_pcm_lib_default_mmap,
     .page      = snd_pcm_lib_get_vmalloc_page,
 };

What baffles me is that consecutive SPI read(while loop
in a workqueue) doesn't have any relation with userspace
as it is interrupt driven (DSP interrupt) but still with
audio flinger overrun happens. In the workqueue, between
SPI reads, driver calls  elapsed function to notify the userspace
to read 1 period data whenever data crosses period boundary.
I don't think that causes any issues. Aforementioned workqueue
stops only when userspace closes it so I don't know how
userspace application can slow down SPI reads?

I have also used high priority workqueues but that didn't
help either. Wondering if I can get some pointers to debug this?
also if there any alsa-utility which can simulate closely audio flinger?

Thanks,
