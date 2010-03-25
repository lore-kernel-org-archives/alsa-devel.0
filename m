From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix passing platform_data to ac97
 bus users and fix a leak.
Date: Thu, 25 Mar 2010 16:09:32 +0000
Message-ID: <20100325160932.GB3025@rakim.wolfsonmicro.main>
References: <4BA99514.8020708@gmail.com> <20100324130611.GA26910@sirena.org.uk>
	<4BAAACB4.6030303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 523492441C
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 17:09:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BAAACB4.6030303@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Graham Gower <graham.gower@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 25, 2010 at 10:52:12AM +1030, Graham Gower wrote:
> Mark, Liam,
> 
> As requested, this patch removes the initial allocation of codec->ac97.

Please recheck SubmittingPatches - this'd end up in the changelog (and
now your changelog is empty so it's not clear what the actual problem is
any more).  I've applied this with a changelog added and...

>  		}
> -		if (card->dai_link[i].codec_dai->ac97_control) {
> +		if (card->dai_link[i].codec_dai->ac97_control && codec->ac97) {
>  			snd_ac97_dev_add_pdata(codec->ac97,
>  				card->dai_link[i].cpu_dai->ac97_pdata);

...a comment here since otherwise it's not obvious why we're not
complaining about the missing codec->ac97 otherwise.
