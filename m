From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ASoC: uda1380: split set_dai_fmt into
	_both, _playback and _capture variants
Date: Tue, 3 Feb 2009 16:41:32 +0000
Message-ID: <20090203164132.GG23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-2-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 251EE10385B
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:41:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233677983-23710-2-git-send-email-philipp.zabel@gmail.com>
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

On Tue, Feb 03, 2009 at 05:19:40PM +0100, Philipp Zabel wrote:
> This patch splits set_dai_fmt into three variants (single interface,
> dual interface playback only, dual interface capture only) so that
> data input and output formats can be configured separately for dual
> interface setups.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Is there any reason not to apply this immediately?
