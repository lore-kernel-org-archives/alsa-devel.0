From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: [GIT PULL]: kbl audio firmware update
Date: Thu, 1 Feb 2018 10:22:52 -0500
Message-ID: <CA+5PVA5CmtqY9HSUwQNqGxYCv89ki8zF8-6u_x0xF6dgFdJAWQ@mail.gmail.com>
References: <20180131095102.GX18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id D2FB5266D71
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 16:29:59 +0100 (CET)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C01EC21798
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 15:22:53 +0000 (UTC)
Received: by mail-qk0-f182.google.com with SMTP id a5so19816017qkg.10
 for <alsa-devel@alsa-project.org>; Thu, 01 Feb 2018 07:22:53 -0800 (PST)
In-Reply-To: <20180131095102.GX18649@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, Linux Firmware <linux-firmware@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 31, 2018 at 4:51 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> Hi,
>
> Please PULL to receive the update for KBL audio DSP firmware.
>
> The following changes since commit 2a713be25a44bd6cec90d8affc54b246a2ca9c7b:
>
>   amdgpu: update uvd firmware for polaris asics (2018-01-19 07:16:32 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git kbl
>
> for you to fetch changes up to aab8b6fff9417a9938f6393dc09cf6ce90e55565:
>
>   linux-firmware: intel: Update Kabylake audio firmware (2018-01-30 15:42:45 +0530)
>
> ----------------------------------------------------------------
> Guneshwor Singh (1):
>       linux-firmware: intel: Update Kabylake audio firmware
>
>  WHENCE                     |   4 +++-
>  intel/dsp_fw_kbl.bin       |   2 +-
>  intel/dsp_fw_kbl_v3266.bin | Bin 0 -> 243016 bytes
>  3 files changed, 4 insertions(+), 2 deletions(-)
>  create mode 100644 intel/dsp_fw_kbl_v3266.bin

Merged and pushed out.  Thanks.

josh
