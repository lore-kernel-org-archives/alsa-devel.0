From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 3/4] ALSA: hda - Fix runtime PM check
Date: Thu, 23 May 2013 14:34:09 +0200
Message-ID: <519E0CC1.4070300@canonical.com>
References: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
 <1369242256-32112-4-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 200972617AC
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 14:34:14 +0200 (CEST)
In-Reply-To: <1369242256-32112-4-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, tiwai@suse.de, intel-gfx@lists.freedesktop.org, xingchao.wang@intel.com, jocelyn.li@intel.com, daniel@ffwll.ch
List-Id: alsa-devel@alsa-project.org

On 05/22/2013 07:04 PM, Wang Xingchao wrote:
> The device can support runtime PM no matter whether
> it support signal wakeup or not. For some chips like Haswell
> which doesnot support PME by default, this patch let haswell
> Display HD-A controller enter runtime suspend, and bring more
> power saving whith power-well feature enabled.
> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> ---
>   sound/pci/hda/hda_intel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 54c7c22..f20a88c 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -3755,7 +3755,7 @@ static int azx_probe(struct pci_dev *pci,
>   			goto out_free_power;
>   	}
>
> -	if (pci_dev_run_wake(pci))
> +	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)

I'm not sure, but shouldn't this be

if (pci_dev_run_wake(pci) || (chip->driver_caps & AZX_DCAPS_PM_RUNTIME))

...in order not to regress power performance of devices which have 
pci_dev_run_wake(pci) but not runtime PM?

>   		pm_runtime_put_noidle(&pci->dev);
>
>   	dev++;
> @@ -3834,7 +3834,7 @@ static void azx_remove(struct pci_dev *pci)
>   	struct snd_card *card = pci_get_drvdata(pci);
>   	struct azx *chip = card->private_data;
>
> -	if (pci_dev_run_wake(pci))
> +	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
>   		pm_runtime_get_noresume(&pci->dev);
>
>   	if (card)
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
