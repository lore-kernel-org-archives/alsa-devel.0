From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/6] hda_intel: Add Lynx Point HD Audio
 Controller DeviceIDs
Date: Tue, 24 Jan 2012 10:45:36 +0100
Message-ID: <4F1E7DC0.5060208@canonical.com>
References: <201201231624.31275.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id A76BA1039CE
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 10:45:36 +0100 (CET)
In-Reply-To: <201201231624.31275.seth.heasley@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, james.d.ralston@intel.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/24/2012 01:24 AM, Seth Heasley wrote:
> This patch adds the HD Audio DeviceIDs for the Intel Lynx Point PCH.

Thanks. As we asked for oak trail: can you confirm you prefer DMA 
Position buffers for detecting current playback/recording position, over 
using the LPIB register?

Also; these types of quirks should have a line "Cc: stable@kernel.org" 
added to their commit messages, that will make it automatically be 
applied to some of the older kernels in due time.

>
> Signed-off-by: Seth Heasley<seth.heasley@intel.com>
> ---
>   sound/pci/hda/hda_intel.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 0852e20..adb4fa7 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -148,6 +148,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
>   			 "{Intel, PCH},"
>   			 "{Intel, CPT},"
>   			 "{Intel, PPT},"
> +			 "{Intel, LPT},"
>   			 "{Intel, PBG},"
>   			 "{Intel, SCH},"
>   			 "{ATI, SB450},"
> @@ -2989,6 +2990,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>   	{ PCI_DEVICE(0x8086, 0x1e20),
>   	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
>   	  AZX_DCAPS_BUFSIZE},
> +	/* Lynx Point */
> +	{ PCI_DEVICE(0x8086, 0x8c20),
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
> +	  AZX_DCAPS_BUFSIZE},
>   	/* SCH */
>   	{ PCI_DEVICE(0x8086, 0x811b),
>   	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
