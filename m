From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Don't set "(null)" as a driver
	name
Date: Fri, 20 May 2011 13:32:31 +0100
Message-ID: <4DD65F5F.9060908@ti.com>
References: <1305894086-9851-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D4C424399
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 14:32:37 +0200 (CEST)
In-Reply-To: <1305894086-9851-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/05/11 13:21, Jarkko Nikula wrote:
> Commit 22de71b ("ASoC: core - allow ASoC more flexible machine name")
> writes "(null)" to driver name string in struct snd_card if card->driver_name
> is NULL. This causes segmentation faults with some user space ALSA utilities
> like aplay and arecord.
> 
> Fix this by using null terminated string instead as this was the case before.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 5968745..ab05f42 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1930,7 +1930,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
>  	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
>  		 "%s", card->long_name ? card->long_name : card->name);
>  	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
> -		 "%s", card->driver_name);
> +		 "%s", card->driver_name ? card->driver_name : "");
>  
>  	if (card->late_probe) {
>  		ret = card->late_probe(card);


This looks good but we may want to make the default driver name (if no driver name is specified) to be the card->name instead of " " and should return an error if card->name is NULL.

Liam
