From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v1] sound: pci: ymfpci: ymfpci_main:- Handle return NULL
 error from ioremap_nocache
Date: Mon, 23 Jan 2017 08:24:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1701230820240.2116@hadrien>
References: <1485155413-23672-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485155413-23672-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some comments on the patch header:

* No need to put v1 on a patch.  If you are asked to revise it, then you
can start with v2.

* sound: pci: ymfpci: ymfpci_main is not the proper subject line for this
file.  Do git log --oneline and see what others have done.

* There should not be a - after the final colon in the subject line.

* I'm not sure why I was included in this patch.  get_maintainers by
default gives the names of a lot of people.  For general cleanup patches
like this one, you can use the following options, that will just send the
patch to the maintainers, and not to everyone who has ever touched the
file:

scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback --norolestats

julia

On Mon, 23 Jan 2017, Arvind Yadav wrote:

> Here, If ioremap_nocache will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/pci/ymfpci/ymfpci_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
> index ffee284..8590c3f 100644
> --- a/sound/pci/ymfpci/ymfpci_main.c
> +++ b/sound/pci/ymfpci/ymfpci_main.c
> @@ -2392,6 +2392,10 @@ int snd_ymfpci_create(struct snd_card *card,
>  	chip->rev = pci->revision;
>  	chip->reg_area_phys = pci_resource_start(pci, 0);
>  	chip->reg_area_virt = ioremap_nocache(chip->reg_area_phys, 0x8000);
> +	if (!chip->reg_area_virt) {
> +		pci_disable_device(pci);
> +		return -ENOMEM;
> +	}
>  	pci_set_master(pci);
>  	chip->src441_used = -1;
>
> --
> 1.9.1
>
>
