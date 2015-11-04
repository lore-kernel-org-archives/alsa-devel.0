From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL]: Add sst audio firmware for Skylake
Date: Wed, 4 Nov 2015 14:04:54 -0500
Message-ID: <20151104190454.GE12383@merlin.infradead.org>
References: <20151104122631.GL12910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id BE01B2606B8
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 20:04:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151104122631.GL12910@localhost>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 05:56:31PM +0530, Vinod Koul wrote:
> Hello Linux firmware maintainers,
> 
> Please PULL to receive the Intel audio firmware for audio DSP in Skylake
> platforms.
> 

pulled, thanks.

> This firmware uses the Intel binary firmware release licence along with
> newlibc license and is fully redistributable
> 
> The following changes since commit 66d3d8d7607c9a3a7d083f81990f6523f5842065:
> 
>   Add FW binary used by mwlwifi driver. (2015-10-18 19:28:55 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl
> 
> for you to fetch changes up to 33a1bc51b670ee198045b68b968d5575bd49c907:
> 
>   linux-firmware: add Skylake audio firmware (2015-11-04 17:26:40 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: add Skylake audio firmware
> 
>  LICENCE.adsp_sst         | 999 +++++++++++++++++++++++++++++++++++++++++++++++
>  WHENCE                   |  10 +
>  intel/dsp_fw_release.bin | Bin 0 -> 233472 bytes
>  3 files changed, 1009 insertions(+)
>  create mode 100644 LICENCE.adsp_sst
>  create mode 100644 intel/dsp_fw_release.bin
> 
> Thanks
> -- 
> ~Vinod
