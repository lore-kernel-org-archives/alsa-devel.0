From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports
	start from 1, not 0
Date: Tue, 3 Feb 2009 16:47:16 +0000
Message-ID: <20090203164715.GH23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EC53A103879
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:47:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
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

On Tue, Feb 03, 2009 at 05:19:41PM +0100, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Meh, all the display names use the documentation names and the id is
used for indexing into arrays (which may well be why you're not getting
any audio out...).  I'd be more inclined to leave this as-is but if not
it needs to adjust all the array usages.
