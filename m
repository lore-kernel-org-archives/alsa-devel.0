From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] Gemini lake audio firmware
Date: Fri, 3 Mar 2017 09:52:07 -0800
Message-ID: <20170303175207.GZ13400@bombadil.infradead.org>
References: <20170303133525.GT2843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id CD5442668AC
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 18:52:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170303133525.GT2843@localhost>
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

On Fri, Mar 03, 2017 at 07:05:25PM +0530, Vinod Koul wrote:
> Hi,
> 
> Please pull to receive the Geminilake audio firmware used in Intel Geminilake
> devices with Audio DSP.
> 
> The following changes since commit 4b9559fb0565f582a21a4070a81a3b6a7d77610b:
> 
>   linux-firmware: update firmware file for atusb (2016-12-07 01:01:04 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git glk
> 
> for you to fetch changes up to dc76591484e43cc031a28eeecae68196a98a1550:
> 
>   linux-firmware: intel: Add Geminilake audio firmware (2017-03-03 15:40:35 +0530)
> 

Pulled, thanks Vinod.

regards, Kyle

> ----------------------------------------------------------------
> Subhransu S. Prusty (1):
>       linux-firmware: intel: Add Geminilake audio firmware
> 
>  WHENCE                     |   6 ++++++
>  intel/dsp_fw_glk.bin       |   1 +
>  intel/dsp_fw_glk_v1814.bin | Bin 0 -> 505608 bytes
>  3 files changed, 7 insertions(+)
>  create mode 120000 intel/dsp_fw_glk.bin
>  create mode 100644 intel/dsp_fw_glk_v1814.bin
> 
> Thanks
> -- 
> ~Vinod
