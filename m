From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] move dereference after null check
Date: Mon, 16 Nov 2009 10:36:49 +0000
Message-ID: <1258367809.3570.9.camel@odin>
References: <alpine.DEB.2.00.0911151555010.12810@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C3AF10388B
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:36:54 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so1995080fgg.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 02:36:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911151555010.12810@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-11-16 at 11:06 +0200, Dan Carpenter wrote:
> The 'jack' variable was dereference before the NULL check so this patch 
> moves the dereference later.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> 
> --- orig/sound/soc/soc-jack.c	2009-11-14 11:04:04.000000000 +0200
> +++ devel/sound/soc/soc-jack.c	2009-11-14 11:05:01.000000000 +0200
> @@ -58,7 +58,7 @@
>   */
>  void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
>  {
> -	struct snd_soc_codec *codec = jack->card->codec;
> +	struct snd_soc_codec *codec;
>  	struct snd_soc_jack_pin *pin;
>  	int enable;
>  	int oldstatus;
> @@ -67,6 +67,7 @@
>  		WARN_ON_ONCE(!jack);
>  		return;
>  	}
> +	codec = jack->card->codec;
>  
>  	mutex_lock(&codec->mutex);
>  
