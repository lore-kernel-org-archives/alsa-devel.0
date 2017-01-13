From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] intel: audio firmware updates
Date: Fri, 13 Jan 2017 07:12:18 -0800
Message-ID: <20170113151218.GL13400@bombadil.infradead.org>
References: <20170112094923.GK3573@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 by alsa0.perex.cz (Postfix) with ESMTP id B341E261740
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 16:12:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170112094923.GK3573@localhost>
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

On Thu, Jan 12, 2017 at 03:19:23PM +0530, Vinod Koul wrote:
> Hi,
> 
> Please pull to receive the updated versions of skylake and broxton firmware
> binaries.
> 
> The following changes since commit 4b9559fb0565f582a21a4070a81a3b6a7d77610b:
> 
>   linux-firmware: update firmware file for atusb (2016-12-07 01:01:04 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl
> 

pulled, thanks.

> for you to fetch changes up to 4529fb4b320ba8e71a213723d0ad029058b15912:
> 
>   linux-firmware: intel: Update Broxton audio firmware (2017-01-12 14:58:44 +0530)
> 
> ----------------------------------------------------------------
> Jeeja KP (1):
>       linux-firmware: intel: Update Skylake audio firmware
> 
> Subhransu S. Prusty (1):
>       linux-firmware: intel: Update Broxton audio firmware
> 
>  WHENCE                        |   8 ++++++--
>  intel/dsp_fw_bxtn.bin         |   2 +-
>  intel/dsp_fw_bxtn_v2010.bin   | Bin 0 -> 505608 bytes
>  intel/dsp_fw_release.bin      |   2 +-
>  intel/dsp_fw_release_v969.bin | Bin 0 -> 221184 bytes
>  5 files changed, 8 insertions(+), 4 deletions(-)
>  create mode 100644 intel/dsp_fw_bxtn_v2010.bin
>  create mode 100644 intel/dsp_fw_release_v969.bin
> 
> -- 
> ~Vinod
