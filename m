From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Avoid useless loop
Date: Sun, 10 Apr 2011 14:33:40 +0100
Message-ID: <20110410133340.GA1046@sirena.org.uk>
References: <1302477560-23550-1-git-send-email-keroid1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3566D24152
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Apr 2011 15:33:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302477560-23550-1-git-send-email-keroid1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: keroid1@gmail.com
Cc: richard@openedhand.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 10, 2011 at 07:19:20PM -0400, keroid1@gmail.com wrote:

>  	/* bind DAIs */
> -	for (i = 0; i < card->num_links; i++)
> -		soc_bind_dai_link(card, i);
> +	if (card->num_rtds != card->num_links) {
> +		for (i = 0; i < card->num_links; i++)
> +			soc_bind_dai_link(card, i);
> +	}
>  
>  	/* bind completed ? */
>  	if (card->num_rtd != card->num_links) {

It seems odd to have two if statements testing the same condition in
immediate succession, though we do need the second check after the flor
loop to match the final bind.  I'm not sure this is doing much except
adding a little complexity - it's not like this is a hot path.
