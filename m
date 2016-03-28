From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8962: Adjust clk definitions so
 that simple card can work
Date: Mon, 28 Mar 2016 10:32:56 +0100
Message-ID: <20160328093256.GA31814@localhost.localdomain>
References: <1459114573-2006-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F2126517A
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 11:33:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1459114573-2006-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2016 at 06:36:13PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> When trying to use simple card with wm8962 the following probe
> error happens:
> 
> wm8962 0-001a: simple-card: set_sysclk error
> asoc-simple-card sound: ASoC: failed to init 202c000.ssi-wm8962: -22
> asoc-simple-card sound: ASoC: failed to instantiate card -22
> asoc-simple-card: probe of sound failed with error -22
> 
> In simple-card.c the snd_soc_dai_set_sysclk() function is called with
> clk_id as 0, which is an invalid clock for wm8962.
> 
> Adjust the clocks source definitions in wm8962.h so that the
> simple card driver can work successfully.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
