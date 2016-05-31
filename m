From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL]: Add audio firmware for Broxton
Date: Tue, 31 May 2016 18:07:57 -0400
Message-ID: <20160531220757.GJ9173@merlin.infradead.org>
References: <20160531035811.GL16910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id AC4442651D1
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 00:08:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160531035811.GL16910@localhost>
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

On Tue, May 31, 2016 at 09:28:11AM +0530, Vinod Koul wrote:
> Hello Linux firmware maintainers,
> 
> Please PULL to receive the Intel audio firmware for audio DSP in Broxton
> platforms. This firmware comes with same license as audio firmware for
> Skylake and is fully redistributable.
> 
> 
> The following changes since commit 7db6ab934fc0196c41f40ea07218de2cab27abb5:
> 
>   qed: Add FW 8.10.5.0 (2016-05-29 10:16:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git apl
> 

Pulled, thanks Vinod.

regards, --Kyle

> for you to fetch changes up to f5598347032b1e4dd49e15401a1a9b867062625c:
> 
>   linux-firmware: intel: Add Broxton audio firmware (2016-05-31 09:20:44 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Add Broxton audio firmware
> 
>  WHENCE                     |   6 ++++++
>  intel/dsp_fw_bxtn.bin      |   1 +
>  intel/dsp_fw_bxtn_v430.bin | Bin 0 -> 505608 bytes
>  3 files changed, 7 insertions(+)
>  create mode 120000 intel/dsp_fw_bxtn.bin
>  create mode 100644 intel/dsp_fw_bxtn_v430.bin
> 
> Thanks
> -- 
> ~Vinod
