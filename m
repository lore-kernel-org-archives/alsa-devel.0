From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] fix patch_ucb1400 for proper resume
Date: Wed, 09 Jul 2008 11:59:41 +0300
Message-ID: <48747DFD.10803@compulab.co.il>
References: <486B562B.9040709@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oceanus.site5.com (oceanus.site5.com [67.43.13.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5910324376
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 10:59:58 +0200 (CEST)
Received: from mail.linux-boards.com ([192.114.83.142])
	by oceanus.site5.com with esmtps (TLSv1:DES-CBC3-SHA:168) (Exim 4.69)
	(envelope-from <mike@compulab.co.il>) id 1KGVWl-0005vf-2g
	for alsa-devel@alsa-project.org; Wed, 09 Jul 2008 04:59:56 -0400
Received: from [10.1.1.95] (mike-pc.compulab.local [10.1.1.95])
	by mail.linux-boards.com (8.12.5/8.12.8) with ESMTP id m697mYC8013774
	for <alsa-devel@alsa-project.org>; Wed, 9 Jul 2008 10:48:35 +0300
In-Reply-To: <486B562B.9040709@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Any comments on this?

Mike Rapoport wrote:
> Replace 'snd_ac97_write' with snd_ac97_write_cache' in pacth_ucb1400 to allow
> proper codec wakeup.
> 
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
> index 1292dce..b821874 100644
> --- a/sound/pci/ac97/ac97_patch.c
> +++ b/sound/pci/ac97/ac97_patch.c
> @@ -3633,7 +3633,7 @@ static int patch_ucb1400(struct snd_ac97 * ac97)
>  {
>  	ac97->build_ops = &patch_ucb1400_ops;
>  	/* enable headphone driver and smart low power mode by default */
> -	snd_ac97_write(ac97, 0x6a, 0x0050);
> -	snd_ac97_write(ac97, 0x6c, 0x0030);
> +	snd_ac97_write_cache(ac97, 0x6a, 0x0050);
> +	snd_ac97_write_cache(ac97, 0x6c, 0x0030);
>  	return 0;
>  }
> 

-- 
Sincerely yours,
Mike.
