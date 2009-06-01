From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give better
 shortname
Date: Mon, 1 Jun 2009 23:09:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906012306460.4067@eeebox2.perex-int.cz>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
	<1243884987-20256-1-git-send-email-daniel@caiaq.de>
	<1243884987-20256-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 07398245D4
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 23:09:26 +0200 (CEST)
In-Reply-To: <1243884987-20256-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Jun 2009, Daniel Mack wrote:

> Give the card an 'id' name which will prevent ALSA from calling
> choose_default_name(). This implementation only took the last part of a
> name containing whitespaces which for example caused 'Audio 4 DJ' to be
> shortened to 'DJ', which was not very descriptive.
>
> The implementation now takes the short name and removes all whitespaces
> from it which is much nicer.

Unfortunately, this code does not handle id collisions for multiple cards. 
All IDs must be unique. The best solution is to create a function in the 
snd.ko to assign ID and do collision checks. I'll try to prepare something 
tomorrow.

 					Jaroslav

>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
> sound/usb/caiaq/device.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index 9be0f2e..7fdecde 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -435,6 +435,12 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
> 	strcpy(card->driver, MODNAME);
> 	strcpy(card->shortname, dev->product_name);
>
> +	/* fill card->id with a shortened version of the product string
> +	 * which does not contain any whitespaces */
> +	for (c = card->shortname, len = 0; *c && len < sizeof(card->id); c++)
> +		if (*c != ' ')
> +			card->id[len++] = *c;
> +
> 	len = snprintf(card->longname, sizeof(card->longname),
> 		       "%s %s (serial %s, ",
> 		       dev->vendor_name, dev->product_name, dev->serial);
> -- 
> 1.6.3.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
