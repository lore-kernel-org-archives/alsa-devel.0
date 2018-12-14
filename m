From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: linux-firmware: intel: Update Cannonlake audio
	firmware.
Date: Fri, 14 Dec 2018 08:18:11 -0500
Message-ID: <CA+5PVA5+ozvjT5N0b-4EG9wOzY8GAE6wqxZN5TsN8zLNTpDCPQ@mail.gmail.com>
References: <3BD9CEE4EBD5E74B98FE2D277EB60E0B38E916C2@IRSMSX104.ger.corp.intel.com>
 <d09119be-27f6-0847-3871-520cd5236ba9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 37AA52678D4
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 14:24:24 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BF2621182
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:18:23 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id g125so2966450qke.4
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 05:18:23 -0800 (PST)
In-Reply-To: <d09119be-27f6-0847-3871-520cd5236ba9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pierre-louis.bossart@linux.intel.com
Cc: cezary.rojewski@intel.com, filip.kaczmarski@intel.com, alsa-devel@alsa-project.org, Linux Firmware <linux-firmware@kernel.org>, michal.wasko@intel.com, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 3, 2018 at 11:00 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/3/18 6:06 AM, Rojewski, Cezary wrote:
> > Hello,
> >
> > This change updates the firmware version from .1191 to .1858 for CNL and its child platforms.
> > Kindly pull the new CNL ADSP firmware from the following URL.
> >
> > The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff83e7:
> >
> >    Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-10-26 08:13:19 -0400)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/crojewsk/linux-firmware.git for-upstream
> >
> > for you to fetch changes up to 82f6dbf82d976064db15f4e7f3e770322dc6ce14:
> >
> >    linux-firmware: intel: Update Cannonlake audio firmware. (2018-12-03 03:43:31 +0100)
> >
> > ----------------------------------------------------------------
> > Cezary Rojewski (1):
> >        linux-firmware: intel: Update Cannonlake audio firmware.
> >
> > WHENCE                     |   4 +++-
> > intel/dsp_fw_cnl.bin       |   2 +-
> > intel/dsp_fw_cnl_v1858.bin | Bin 0 -> 583852 bytes
> > 3 files changed, 4 insertions(+), 2 deletions(-)
> > create mode 100644 intel/dsp_fw_cnl_v1858.bin
> > --------------------------------------------------------------------
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=201251
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> Cezary, for future updates (if any) it's advised to use a Signed-Off-By
> tag and remove the confidentiality statement below (it makes no sense
> here). Thanks!

Pulled and pushed out.

josh
