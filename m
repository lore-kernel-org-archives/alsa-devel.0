From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda: Abort capability probe at
 invalid register read
Date: Tue, 17 Oct 2017 22:45:08 +0530
Message-ID: <20171017171508.GU30097@localhost>
References: <20171017144711.23962-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 91845266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 19:10:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171017144711.23962-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 17, 2017 at 04:47:11PM +0200, Takashi Iwai wrote:
> The loop in snd_hdac_bus_parse_capabilities() may go to nirvana when
> it hits an invalid register value read:
> 
>  BUG: unable to handle kernel paging request at ffffad5dc41f3fff
>  IP: pci_azx_readl+0x5/0x10 [snd_hda_intel]
>  Call Trace:
>   snd_hdac_bus_parse_capabilities+0x3c/0x1f0 [snd_hda_core]
>   azx_probe_continue+0x7d5/0x940 [snd_hda_intel]
>   .....
> 
> This happened on a new Intel machine, and we need to check the value
> and abort the loop accordingly.

okay and what machine is the problem here. I have had a similar bug report
from Gfx CI guys on  CFL machine. Turns out the BIOS was buggy and we fixed
that up by upgrading the BIOS.

Yes it is a good idea to keep this guard but -1 would mean that HW read is
failing which points to some other issue here

> 
> [Note: the fixes tag below indicates only the commit where this patch
>  can be applied; the original problem was introduced even before that
>  commit]
> 
> Fixes: 6720b38420a0 ("ALSA: hda - move bus_parse_capabilities to core")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/hda/hdac_controller.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
> index 978dc1801b3a..f6d2985b2520 100644
> --- a/sound/hda/hdac_controller.c
> +++ b/sound/hda/hdac_controller.c
> @@ -284,6 +284,11 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
>  		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
>  			(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
>  
> +		if (cur_cap == -1) {
> +			dev_dbg(bus->dev, "Invalid capability reg read\n");
> +			break;
> +		}
> +
>  		switch ((cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF) {
>  		case AZX_ML_CAP_ID:
>  			dev_dbg(bus->dev, "Found ML capability\n");
> -- 
> 2.14.2
> 

-- 
~Vinod
