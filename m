From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ASoC: Blackfin: update SPORT0 port
	selector of i2s driver
Date: Thu, 23 Oct 2008 11:58:34 +0100
Message-ID: <20081023105834.GF10280@sirena.org.uk>
References: <1224752520-25668-1-git-send-email-cooloney@kernel.org>
	<1224752520-25668-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 47CEA10385A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 12:58:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224752520-25668-5-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 05:02:00PM +0800, Bryan Wu wrote:

> +#ifdef CONFIG_BF527_SPORT0_PORTF
> +#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
> +#endif
> +
> +#ifndef CONFIG_BF527_SPORT0_PORTF
> +#define LOCAL_SPORT0_TFS (0)
> +#endif

Perhaps I'm misreading this but shouldn't this just be:

#ifdef CONFIG_BF527_SPORT0_PORTF
#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
#else
#define LOCAL_SPORT0_TFS (0)
#endif
