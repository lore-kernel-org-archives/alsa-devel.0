From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] vga_switcheroo: Fix missing gpu_bound call
 at audio client registration
Date: Mon, 5 Nov 2018 12:55:17 +0100
Message-ID: <20181105115517.56bclhhq2ctaps7u@wunner.de>
References: <20181105110253.8655-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.90.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 65185267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:55:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181105110253.8655-1-tiwai@suse.de>
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, alsa-devel@alsa-project.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 05, 2018 at 12:02:53PM +0100, Takashi Iwai wrote:
> The commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") added a new ops gpu_bound to be called when GPU gets
> bound.  The patch overlooked, however, that vga_switcheroo_enable() is
> called only once at GPU is bound.  When an audio client is registered
> after that point, it would miss the gpu_bound call.  This leads to the
> unexpected lack of runtime PM in HD-audio side.
> 
> For addressing that regression, just call gpu_bound callback manually
> at vga_switcheroo_register_audio_client() when the GPU was already
> bound.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201615
> Fixes: 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for discrete GPU")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/gpu/vga/vga_switcheroo.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index cf2a18571d48..a132c37d7334 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -380,6 +380,9 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>  			mutex_unlock(&vgasr_mutex);
>  			return -EINVAL;
>  		}
> +		/* notify if GPU has been already bound */
> +		if (ops->gpu_bound)
> +			ops->gpu_bound(pdev, id);
>  	}
>  	mutex_unlock(&vgasr_mutex);

If the audio client registers before vga_switcheroo becomes enabled,
->gpu_bound will be executed twice.  AFAICS this only causes a minor
cosmetic issue, namely that dev_info() is called twice for blacklisted
devices in set_default_power_save().  This could be eliminated by
amending the if-condition with "&& vgasr_priv.active".  Since this
is only minor, up to you if you want to respin.

Either way,
Reviewed-by: Lukas Wunner <lukas@wunner.de>
