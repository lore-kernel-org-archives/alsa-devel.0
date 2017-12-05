From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: [GIT PULL]: Cannonlake audio firware
Date: Tue, 5 Dec 2017 14:51:27 -0500
Message-ID: <CA+5PVA5KRO55v9CBQ33f7d9ho=Gs+S56Xb7q3pBvt_LaUMvtvA@mail.gmail.com>
References: <20171204034301.GB32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 9950326698E
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 20:51:32 +0100 (CET)
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4941C218B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 19:51:29 +0000 (UTC)
Received: by mail-qt0-f174.google.com with SMTP id 33so3669096qtv.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 11:51:29 -0800 (PST)
In-Reply-To: <20171204034301.GB32417@localhost>
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
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 3, 2017 at 10:43 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> Hi,
>
> Please PULL to recieve the Cannonlake audio firmware.
>
> The following changes since commit 17e6288135d4500f9fe60224dce2b46d850c346b:
>
>   brcm: update firmware for bcm4358 (2017-11-25 10:15:53 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git cnl
>
> for you to fetch changes up to 89c62115f14dd8f414dfd2702913a6f1fcac3287:
>
>   linux-firmware: intel: Add Cannonlake audio firmware (2017-12-04 09:04:57 +0530)
>
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Add Cannonlake audio firmware
>
>  WHENCE                     |   5 +++++
>  intel/dsp_fw_cnl.bin       |   1 +
>  intel/dsp_fw_cnl_v1191.bin | Bin 0 -> 583852 bytes
>  3 files changed, 6 insertions(+)
>  create mode 120000 intel/dsp_fw_cnl.bin
>  create mode 100644 intel/dsp_fw_cnl_v1191.bin

Merged and pushed out.  Thanks.

josh
