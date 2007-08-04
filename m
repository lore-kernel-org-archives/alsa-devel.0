From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] au88x0: mem leak fix in snd_vortex_create()
Date: Sat, 04 Aug 2007 11:47:23 +0200
Message-ID: <46B44B2B.7050609@gmail.com>
References: <200708040209.25589.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A81D410382C
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Aug 2007 11:50:12 +0200 (CEST)
In-Reply-To: <200708040209.25589.jesper.juhl@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Manuel Jander <mjander@embedded.cl>
List-Id: alsa-devel@alsa-project.org

On 08/04/2007 02:09 AM, Jesper Juhl wrote:

> In sound/pci/au88x0/au88x0.c::snd_vortex_create() : 
> The Coverity checker found that if we allocate storage for 'chip' 
> but then leave via the  regions_out:  label, then we end up leaking 
> the storage allocated for 'chip'.
> I believe simply freeing 'chip' before the "return err;" line is 
> all we need to fix this, but please double-check me :)
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
> index 5ec1b6f..f70286a 100644
> --- a/sound/pci/au88x0/au88x0.c
> +++ b/sound/pci/au88x0/au88x0.c
> @@ -232,6 +232,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
>  	pci_disable_device(chip->pci_dev);
>  	//FIXME: this not the right place to unregister the gameport
>  	vortex_gameport_unregister(chip);
> +	kfree(chip);
>  	return err;
>  }

ACK.

Rene.
