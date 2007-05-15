From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: Can someone verify support for "AzTech
	Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
	-	FCC-ID:I38-MMSN846" ?
Date: Tue, 15 May 2007 12:16:07 +0200
Message-ID: <20070515101607.GT5690@sygehus.dk>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by alsa0.perex.cz (Postfix) with ESMTP id A882324803
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 12:16:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4648DA4E.8050107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, ramkromberg@mail.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 14, 2007 at 11:53:18PM +0200, Rene Herman wrote:
> --- a/sound/isa/Kconfig
> +++ b/sound/isa/Kconfig
> @@ -177,6 +177,19 @@ config SND_ES18XX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called snd-es18xx.
>  
> +config SND_GALAXY
> +	tristate "Aztech Sound Galaxy Driver"
> +	depends on SND
> +	select SND_CS4231_LIB
> +	select SND_MPU401_UART
> +	select SND_OPL3_LIB
> +	select SND_PCM
> +	help
> +	  Say Y here to include support for Aztech Sound Galaxy cards.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-galaxy.
> +
>  config SND_GUS_SYNTH
>  	tristate
>  

   Like you said yourself, there are a lot of different Sound Galaxy cards,
not all of which are CS42xx compatible. Perhaps be a bit more specific as to
which ones are expected to work (or not work) with the driver.

-- 
Rask Ingemann Lambertsen
