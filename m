From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] opl3sa2: drop snd_card pointer from the
	snd_opl3sa2 structure
Date: Sun, 17 Aug 2008 20:26:10 +0200
Message-ID: <48A86D42.2090901@keyaccess.nl>
References: <20080817200114.691a99d4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 670C524355
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 20:25:15 +0200 (CEST)
In-Reply-To: <20080817200114.691a99d4.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-08-08 20:01, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Remove card pointer from the snd_opl3sa2
> structure and break circular reference
> snd_card->snd_opl3sa2->snd_card.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: Rene Herman <rene.herman@gmail.com>

Note, you had me worried for a bit as you reminded me I still have a 
patch pending to pass the card->dev to snd_pcm_preallocate_pages() in 
order to stop using the magic "NULL dev means ISA" behaviour in the DMA 
layer (meaning we need a chip->card) but this "chip" isn't in fact "a 
chip" so fine here.

> @@ -298,12 +296,14 @@ static int __devinit snd_opl3sa2_detect(
>  static irqreturn_t snd_opl3sa2_interrupt(int irq, void *dev_id)
>  {
>  	unsigned short status;
> -	struct snd_opl3sa2 *chip = dev_id;
> +	struct snd_card *card = dev_id;
> +	struct snd_opl3sa2 *chip;
>  	int handled = 0;
>  
> -	if (chip == NULL || chip->card == NULL)
> +	if (card == NULL || card->private_data == NULL)

micro-comment: card->private_data can't actually be NULL on initialized 
card (it's card + n) but yes, I guess we're pretending we don't know that...

Rene.
