From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: Fix null pointer pdata
 access in I2C probe()
Date: Wed, 30 Oct 2013 09:31:51 +0800
Message-ID: <20131030013150.GC9605@MrMyself>
References: <1383037587-19439-1-git-send-email-b42378@freescale.com>
 <20131029163556.GI16686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 by alsa0.perex.cz (Postfix) with ESMTP id B99A6261AE4
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 02:38:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131029163556.GI16686@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 29, 2013 at 09:35:56AM -0700, Mark Brown wrote:
> > -	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
> > -		if (pdata->gpio_init[i]) {
> > +	for (i = 0; i < ARRAY_SIZE(wm8962->pdata.gpio_init); i++)
> > +		if (wm8962->pdata.gpio_init[i]) {
> 
> ...it'd be neater to just ensure that pdata is always initialised.

I considered about that, and the patch could be neater. But then I
just found the code around this part are all using wm8962>pdata.*
pattern. So I stick the modification to it.

Thank you,
Nicolin Chen
