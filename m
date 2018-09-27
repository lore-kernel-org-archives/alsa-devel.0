From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm9712: fix unused variable warning
Date: Thu, 27 Sep 2018 10:12:52 +0100
Message-ID: <20180927091252.GP1653@imbe.wolfsonmicro.main>
References: <20180926193750.2468414-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 859F42677FE
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2018 11:16:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180926193750.2468414-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 26, 2018 at 09:37:40PM +0200, Arnd Bergmann wrote:
> The 'ret' variable is now only used in an #ifdef, and causes a
> warning if it is declared outside of that block:
> 
> sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
> sound/soc/codecs/wm9712.c:641:6: error: unused variable 'ret' [-Werror=unused-variable]
> 
> Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
