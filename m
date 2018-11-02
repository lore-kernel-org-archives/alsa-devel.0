From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] [v2] ASoC: wm97xx: fix uninitialized
 regmap pointer problem
Date: Fri, 2 Nov 2018 16:01:39 +0000
Message-ID: <20181102160139.GQ16508@imbe.wolfsonmicro.main>
References: <20181102151922.889131-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CBCCD2678F7
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 17:01:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181102151922.889131-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, Fabio Estevam <fabio.estevam@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 02, 2018 at 04:18:21PM +0100, Arnd Bergmann wrote:
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

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
