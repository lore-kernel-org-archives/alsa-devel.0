From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] Add Kabylake audio firmware
Date: Tue, 12 Jul 2016 15:48:51 -0400
Message-ID: <20160712194851.GK8680@merlin.infradead.org>
References: <20160712092601.GV9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F0526548D
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2016 21:48:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160712092601.GV9681@localhost>
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

On Tue, Jul 12, 2016 at 02:56:01PM +0530, Vinod Koul wrote:
> Hello,
> 
> Please PULL to recive the audio firmware for Kabylake Intel SoC.
> 
> The following changes since commit 1dc99be22222fbf88adc98d85f8ffb7529c6c4e3:
> 
>   amdgpu: update vce firmware for VI asics (2016-07-11 15:18:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git kbl

Pulled, thanks Vinod.

regards, --Kyle

> 
> for you to fetch changes up to 11e3390b4fac69b50a5f88861d295fd94e51ba6c:
> 
>   linux-firmware: intel: Add Kabylake audio firmware (2016-07-12 14:50:59 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Add Kabylake audio firmware
> 
>  WHENCE                    |   6 ++++++
>  intel/dsp_fw_kbl.bin      |   1 +
>  intel/dsp_fw_kbl_v701.bin | Bin 0 -> 238920 bytes
>  3 files changed, 7 insertions(+)
>  create mode 120000 intel/dsp_fw_kbl.bin
>  create mode 100644 intel/dsp_fw_kbl_v701.bin
> 
> Thanks
> -- 
> ~Vinod
