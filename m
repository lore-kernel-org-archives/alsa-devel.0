From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give better
 shortname
Date: Sat, 30 May 2009 23:17:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905302306110.4067@eeebox2.perex-int.cz>
References: <y> <1243715123-16414-1-git-send-email-daniel@caiaq.de>
	<1243715123-16414-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F54B2438F
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 23:17:09 +0200 (CEST)
In-Reply-To: <1243715123-16414-2-git-send-email-daniel@caiaq.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 30 May 2009, Daniel Mack wrote:

> ALSA's core will only take the last part of a string from the shortname,
> hence replace all ' ' by '_'. For example, the card name 'Audio 4 DJ'
> was shortened to 'DJ' before which doesn't look nice at all.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

NAK. It would be better to improve the core function choose_default_id() 
rather than doing this ugly character mangling in the lowlevel driver or 
add a function to set ID (card->id) from the lowlevel driver.

 					Jaroslav

> ---
> sound/usb/caiaq/device.c |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index 9be0f2e..4756b48 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -435,6 +435,11 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
> 	strcpy(card->driver, MODNAME);
> 	strcpy(card->shortname, dev->product_name);
>
> +	/* replace ' ' with '_' in device shortname */
> +	for (c = card->shortname; *c; c++)
> +		if (*c == ' ')
> +			*c = '_';
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
