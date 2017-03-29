From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: oxygen - Fix snd_oxygen module not
 loading for some (new?) Xonar DG SI cards.
Date: Wed, 29 Mar 2017 20:56:16 +0200
Message-ID: <51152705-a2af-f1d9-b51a-019237e9d334@ladisch.de>
References: <20170329211311.GA4751@unit02.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D4174267060
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 20:56:47 +0200 (CEST)
In-Reply-To: <20170329211311.GA4751@unit02.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eugene Ganeev <easymodofrf@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Eugene Ganeev wrote:
> My Xonar DG SI card is showing up in lspci but no module is loaded for
> it.
>
> The patch just adds a new value with card's PCI ID to oxygen_ids array.

Is the hardware identical?  Do all the inputs and outputs work?

> Signed-off-by: Eugene Ganeev <easymodofrf@gmail.com>
> ---
>  sound/pci/oxygen/oxygen.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
> index ada6c256378e..99ba0354d4cc 100644
> --- a/sound/pci/oxygen/oxygen.c
> +++ b/sound/pci/oxygen/oxygen.c
> @@ -110,6 +110,7 @@ static DEFINE_PCI_DEVICE_TABLE(oxygen_ids) = {
>  	{ OXYGEN_PCI_SUBID(0x1a58, 0x0910), .driver_data = MODEL_CMEDIA_REF },
>  	/* Asus Xonar DG */
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x8467), .driver_data = MODEL_XONAR_DG },
> +	{ OXYGEN_PCI_SUBID(0x1043, 0x855e), .driver_data = MODEL_XONAR_DG },

Please add the correct name to the names[] array.


Regards.
Clemens
