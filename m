From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [alsa-devel] [PATCH 0/2] dmaengine: Fix compillation issues in
 device_prep_dma_cyclic()
Date: Fri, 12 Oct 2012 16:44:15 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7080FEAB8@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20120924133923.130c4db72aa8105cb5647d7a@canb.auug.org.au>
	<1348473485-5081-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1348473485-5081-1-git-send-email-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-ID: <A827A0995B731A449EDC094624CD43F9@mgd.freescale.com>
Sender: linux-next-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 2:58 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> PS: I did build tested the series on ARM (OMAP), x86_32, x86_64 but not for ppc
> for sure.

For the record, patch #1 fixes the build break on PowerPC.  Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
