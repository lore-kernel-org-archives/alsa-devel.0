From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: [GIT PULL] Audio firmware update
Date: Thu, 29 Mar 2018 20:43:49 -0400
Message-ID: <CA+5PVA6z0xq3i15RBFu9koLow8+WXsY4t9C97jFvvNMx+qSajA@mail.gmail.com>
References: <20180323094939.GA6602@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A0192671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 02:49:57 +0200 (CEST)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D8B7217D5
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 00:43:50 +0000 (UTC)
Received: by mail-qk0-f182.google.com with SMTP id j73so7822104qke.6
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 17:43:50 -0700 (PDT)
In-Reply-To: <20180323094939.GA6602@buildpc-HP-Z230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, jeremy.p.lin@intel.com, Linux Firmware <linux-firmware@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 23, 2018 at 5:49 AM, Sanyog Kale <sanyog.r.kale@intel.com> wrote:
> Hi,
>
> Please PULL to receive the update for Skylake, Kabylake, Broxton and
> Geminilake audio DSP firmware.
>
> The following changes since commit 44476f2465dac9c22bce90da66e86b2b56ba34f0:
>
>   BCM-0bb4-0306: Update to Cypress license in WHENCE (2018-03-20 12:20:21 -0400)
>
> are available in the git repository at:
>
>   https://github.com/sanyogrk/firmware kbl
>
> for you to fetch changes up to 9c53767c99f1d393e9c0f566ec17e4699788e95d:
>
>   linux-firmware: intel: Update Geminilake audio firmware (2018-03-23 09:55:51 +0530)
>
> ----------------------------------------------------------------
> Sanyog Kale (4):
>       linux-firmware: intel: Update Skylake audio firmware
>       linux-firmware: intel: Update Broxton audio firmware
>       linux-firmware: intel: Update Kabylake audio firmware
>       linux-firmware: intel: Update Geminilake audio firmware
>
>  WHENCE                         |  16 ++++++++++++----
>  intel/dsp_fw_bxtn.bin          |   2 +-
>  intel/dsp_fw_bxtn_v3366.bin    | Bin 0 -> 505608 bytes
>  intel/dsp_fw_glk.bin           |   2 +-
>  intel/dsp_fw_glk_v3366.bin     | Bin 0 -> 505608 bytes
>  intel/dsp_fw_kbl.bin           |   2 +-
>  intel/dsp_fw_kbl_v3402.bin     | Bin 0 -> 247112 bytes
>  intel/dsp_fw_release.bin       |   2 +-
>  intel/dsp_fw_release_v3402.bin | Bin 0 -> 247112 bytes
>  9 files changed, 16 insertions(+), 8 deletions(-)
>  create mode 100644 intel/dsp_fw_bxtn_v3366.bin
>  create mode 100644 intel/dsp_fw_glk_v3366.bin
>  create mode 100644 intel/dsp_fw_kbl_v3402.bin
>  create mode 100644 intel/dsp_fw_release_v3402.bin

Pulled and pushed out.  Thanks.

josh
