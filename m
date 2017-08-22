From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ALSA: maestro3: Use common error handling
 code in two functions
Date: Tue, 22 Aug 2017 17:03:43 +0300
Message-ID: <20170822140343.yg7bh3qylthja3tn@mwanda>
References: <e6f4f769-eef7-75e7-19b2-7052328f4b9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F0F266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:04:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e6f4f769-eef7-75e7-19b2-7052328f4b9a@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 22, 2017 at 03:43:03PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 22 Aug 2017 15:00:27 +0200
> 
> Add jump targets so that a bit of exception handling can be better reused
> at the end of these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/pci/maestro3.c | 55 +++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
> index cafea6dc5c01..759c3f6ad7aa 100644
> --- a/sound/pci/maestro3.c
> +++ b/sound/pci/maestro3.c
> @@ -2622,22 +2622,18 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
>  
>  	err = request_firmware(&chip->assp_kernel_image,
>  			       "ess/maestro3_assp_kernel.fw", &pci->dev);
> -	if (err < 0) {
> -		snd_m3_free(chip);
> -		return err;
> -	}
> +	if (err)
> +		goto free_chip;

You never mention in the changelog you've changed these checks from
"if (err < 0)" to "if (err)".  Don't slip in unexpected little changes
like this.

regards,
dan carpenter
