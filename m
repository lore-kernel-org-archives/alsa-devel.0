From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: wm8904: harmless underflow in
	wm8904_put_deemph()
Date: Tue, 13 Oct 2015 13:27:11 +0100
Message-ID: <20151013122711.GF8805@ck-lbox>
References: <20151013070818.GB31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B46261A3B
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:46:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151013070818.GB31537@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Morozov <linux@meltdown.ru>, Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 10:08:18AM +0300, Dan Carpenter wrote:
> We try to check that "deemph" is zero or one, but because of an
> underflow bug, it can also be negative.  It's fine, negative values are
> handled as non-zero.  But it's messy and static checkers complain so
> let's fix it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
