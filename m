From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL]: Add sst audio firmware for Braswell
	platforms
Date: Fri, 6 Feb 2015 03:48:20 -0500
Message-ID: <20150206084820.GD30928@merlin.infradead.org>
References: <20150203054058.GA4489@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D1A2605A9
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 09:48:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150203054058.GA4489@intel.com>
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
Cc: alsa-devel@alsa-project.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 02, 2015 at 09:40:58PM -0800, Vinod Koul wrote:
> Hello Linux firmware maintainers,
> 
> Please PULL to receive the Intel audio firmware for audio DSP in Braswell
> platforms. This firmware is using the same license as the Baytrail firmware
> already available in linux-firmware git.
> 
> The following changes since commit b794c5039dcf0b7ebfeb58929d035f7a1d4c80dd:
> 
>   Merge branch 'marvell-mwifiex' (2015-01-27 10:42:47 -0500)
> 

Thanks, I've applied this to the tree.

One note for the future... is there a version number for this firmware
we could add to WHENCE, or is it not expected to be upgraded in the
future?

regards, Kyle

> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git BSW
> 
> for you to fetch changes up to f692aba54c8c80cb27a3eb5388594a55a30504ea:
> 
>   linux-firmware: add sst audio firmware for braswell platforms (2015-02-02 21:12:22 -0800)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: add sst audio firmware for braswell platforms
> 
>  WHENCE                |    8 ++++++++
>  intel/fw_sst_22a8.bin |  Bin 0 -> 647390 bytes
>  2 files changed, 8 insertions(+)
>  create mode 100644 intel/fw_sst_22a8.bin
> 
> Thanks
> -- 
> ~Vinod
