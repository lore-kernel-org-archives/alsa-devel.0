From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 00/10] Leftover CONFIG_PROC_FS fixes &
 cleanups
Date: Fri, 29 May 2015 06:28:13 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553BAF9@SHSMSX101.ccr.corp.intel.com>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 367EA260502
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:28:19 +0200 (CEST)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Friday, May 29, 2015 2:06 PM
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] [PATCH 00/10] Leftover CONFIG_PROC_FS fixes &
> cleanups
> 
> Hi,
> 
> here is a patch series to fix / clean up the leftover CONFIG_PROC_FS after
> Keyon's patch to introduce CONFIG_SND_PROC_FS.

Sorry about those leftovers, Takashi. :(

~Keyon

> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (10):
>   ALSA: aloop: Drop unnecessary ifdef CONFIG_PROC_FS
>   ALSA: dummy: Replace CONFIG_PROC_FS with CONFIG_SND_PROC_FS
>   ALSA: opl4: Fix / cleanup ifdef CONFIG_PROC_FS
>   ALSA: ak4xxx-adda: Drop unnecessary ifdef CONFIG_PROC_FS
>   ALSA: ac97: Fix ifdef CONFIG_PROC_FS
>   ALSA: ca0106: Fix/cleanup ifdef CONFIG_PROC_FS
>   ALSA: cs46xx: Fix old ifdef CONFIG_PROC_FS
>   ALSA: emu10k1: Fix/cleanup ifdef CONFIG_PROC_FS
>   ALSA: emux: Fix/cleanup old ifdef CONFIG_PROC_FS
>   ALSA: pci: Drop superfluous ifdef CONFIG_PROC_FS
> 
>  include/sound/emux_synth.h          | 2 +-
>  sound/drivers/aloop.c               | 8 --------
>  sound/drivers/dummy.c               | 4 ++--
>  sound/drivers/opl4/Makefile         | 3 ++-
>  sound/drivers/opl4/opl4_lib.c       | 4 ----
>  sound/drivers/opl4/opl4_local.h     | 7 +++++--
>  sound/drivers/opl4/opl4_proc.c      | 4 ----
>  sound/i2c/other/ak4xxx-adda.c       | 4 ----
>  sound/pci/ac97/Makefile             | 2 +-
>  sound/pci/ac97/ac97_local.h         | 2 +-
>  sound/pci/ak4531_codec.c            | 6 ------
>  sound/pci/atiixp.c                  | 4 ----
>  sound/pci/atiixp_modem.c            | 4 ----
>  sound/pci/ca0106/Makefile           | 3 ++-
>  sound/pci/ca0106/ca0106_main.c      | 2 +-
>  sound/pci/ca0106/ca0106_proc.c      | 4 ----
>  sound/pci/cmipci.c                  | 5 -----
>  sound/pci/cs46xx/cs46xx_lib.c       | 4 ++--
>  sound/pci/cs46xx/cs46xx_lib.h       | 4 ++--
>  sound/pci/cs46xx/dsp_spos.c         | 4 ++--
>  sound/pci/cs46xx/dsp_spos_scb_lib.c | 6 +++---
>  sound/pci/emu10k1/Makefile          | 3 ++-
>  sound/pci/emu10k1/emu10k1_main.c    | 2 +-
>  sound/pci/emu10k1/emuproc.c         | 2 --
>  sound/pci/ice1712/quartet.c         | 7 +------
>  sound/pci/intel8x0.c                | 4 ----
>  sound/pci/intel8x0m.c               | 5 -----
>  sound/pci/oxygen/oxygen_lib.c       | 4 ----
>  sound/synth/emux/Makefile           | 5 +++--
>  sound/synth/emux/emux.c             | 4 ----
>  sound/synth/emux/emux_proc.c        | 4 ----
>  sound/synth/emux/emux_voice.h       | 6 +++++-
>  32 files changed, 36 insertions(+), 96 deletions(-)
> 
> --
> 2.4.2
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
