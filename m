From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm97xx: fix uninitialized regmap
	pointer problem
Date: Fri, 2 Nov 2018 14:38:17 +0000
Message-ID: <20181102143817.GP16508@imbe.wolfsonmicro.main>
References: <20181102112341.753642-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 847542675BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 15:38:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181102112341.753642-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, Fabio Estevam <fabio.estevam@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 02, 2018 at 12:23:08PM +0100, Arnd Bergmann wrote:
> gcc notices that without either the ac97 bus or the pdata, we never
> initialize the regmap pointer, which leads to an uninitialized variable
> access:
> 
> sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
> sound/soc/codecs/wm9712.c:666:2: error: 'regmap' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Since that configuration is invalid, it's better to return an error
> here. I tried to avoid adding complexity to the conditions, and turned
> the #ifdef into a regular if(IS_ENABLED()) check for readability.
> This in turn requires moving some header file declarations out of
> an #ifdef.
> 
> The same code is used in three drivers, all of which I'm changing
> the same way.
> 
> Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  static void wm9713_soc_remove(struct snd_soc_component *component)
>  {
> -#ifdef CONFIG_SND_SOC_AC97_BUS
>  	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
>  
> -	if (!wm9713->mfd_pdata) {
> +	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {

Should this one not also have an && !wm9713->mfd_pdata?

Thanks,
Charles

>  		snd_soc_component_exit_regmap(component);
>  		snd_soc_free_ac97_component(wm9713->ac97);
>  	}
> -#endif
>  }
>  
>  static const struct snd_soc_component_driver soc_component_dev_wm9713 = {
> -- 
> 2.18.0
