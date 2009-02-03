From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASoC: pxa2xx-i2s: remove GPIO pin setup
Date: Tue, 3 Feb 2009 16:32:23 +0000
Message-ID: <20090203163223.GE23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-4-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 68DD6103857
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:32:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233677983-23710-4-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 05:19:42PM +0100, Philipp Zabel wrote:
> This should be done during board init via pxa2xx_mfp_config instead.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

It should, but you need to update all the affected boards too.
