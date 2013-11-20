From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Disable runtime PM on
 LynxPoint(-LP) controllers
Date: Wed, 20 Nov 2013 09:54:42 +0100
Message-ID: <528C78D2.6020207@canonical.com>
References: <s5h38msqqqg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040001040206030705040901"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FDC1261ABF
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:54:49 +0100 (CET)
In-Reply-To: <s5h38msqqqg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040001040206030705040901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

(Adding Mengdong to cc)

On 11/19/2013 05:51 PM, Takashi Iwai wrote:
> We got bug reports of the stalled HD-audio, typically after S3 or S4,
> and it turned out that they seemed triggered by runtime PM on Lynx
> Point and Lynx Point-LP controllers.  As there is no way to recover
> properly from the stalled controller, it's safer to disable the
> runtime PM support on these chips for now.

Oh, this is a bit sad news. Have you talked to Intel about it?

Anyway, I saw something similar a while ago, but never with access to
the hardware, and then it was difficult to reproduce for the person on
the other side. Nevertheless, when I read through the PM code I found
that the GCTL register was sometimes accessed with readb (although it is
a 32 bit register), so I wrote a patch for that, but the testing results
of this patch were a bit inconclusive, so I never upstreamed it.

Anyway, I'm attaching the draft patch. Do you think it could be related?

> 
> Further notes:
> I actually could reproduce this on a few HP laptops here.
> Go to S3 after runtime suspend, then the next playback fails,
> resulting in either a codec stall or repeated sounds.
> 
> The problem seems lying in a deeper level.  The complete stall could
> be avoided by disabling the call of azx_stop_chip() in
> azx_runtime_suspend().  More specifically, it's the disablement of
> CORB/RIRB in azx_free_cmd_io().  After removing this call, the sound
> is resumed.
> 
> However, even with that workaround, the first playback after resume
> stalls due to the missing RIRB interrupts (so you get "switch to
> polling mode" kernel warning).  Interestingly, the codec communication
> in the resume procedure does work.  The system goes to runtime suspend
> immediately after resume, then something gets broken at that point.
> 
> This missing interrupt problem happens even if you do nothing in
> runtime suspend/resume callback with empty callbacks.  This implies
> that it's an issue in the underlying layer.  So, the only feasible
> "fix" in the sound driver side to suppress the runtime PM, so far.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Yet another note: the patch is based on v3.12, not on linux-next, so
> that it can be backported cleanly for 3.12 and earlier kernels.
> 
>  sound/pci/hda/hda_intel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 6e61a019aa5e..27fc33e54a50 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -3973,7 +3973,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>  	/* Lynx Point */
>  	{ PCI_DEVICE(0x8086, 0x8c20),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>  	/* Wellsburg */
>  	{ PCI_DEVICE(0x8086, 0x8d20),
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> @@ -3981,10 +3981,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>  	/* Lynx Point-LP */
>  	{ PCI_DEVICE(0x8086, 0x9c20),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>  	/* Lynx Point-LP */
>  	{ PCI_DEVICE(0x8086, 0x9c21),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>  	/* Haswell */
>  	{ PCI_DEVICE(0x8086, 0x0a0c),
>  	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------040001040206030705040901
Content-Type: text/x-patch;
 name="gctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gctl.patch"

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a0a06f7..3725020 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1138,7 +1138,7 @@ static void azx_enter_link_reset(struct azx *chip)
 	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
 
 	timeout = jiffies + msecs_to_jiffies(100);
-	while ((azx_readb(chip, GCTL) & ICH6_GCTL_RESET) &&
+	while ((azx_readl(chip, GCTL) & ICH6_GCTL_RESET) &&
 			time_before(jiffies, timeout))
 		usleep_range(500, 1000);
 }
@@ -1148,10 +1148,10 @@ static void azx_exit_link_reset(struct azx *chip)
 {
 	unsigned long timeout;
 
-	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
+	azx_writel(chip, GCTL, azx_readl(chip, GCTL) | ICH6_GCTL_RESET);
 
 	timeout = jiffies + msecs_to_jiffies(100);
-	while (!azx_readb(chip, GCTL) &&
+	while (!azx_readl(chip, GCTL) &&
 			time_before(jiffies, timeout))
 		usleep_range(500, 1000);
 }
@@ -1181,7 +1181,7 @@ static int azx_reset(struct azx *chip, int full_reset)
 
       __skip:
 	/* check to see if controller is ready */
-	if (!azx_readb(chip, GCTL)) {
+	if (!(azx_readl(chip, GCTL) & ICH6_GCTL_RESET)) {
 		snd_printd(SFX "%s: azx_reset: controller not ready!\n", pci_name(chip->pci));
 		return -EBUSY;
 	}

--------------040001040206030705040901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040001040206030705040901--
