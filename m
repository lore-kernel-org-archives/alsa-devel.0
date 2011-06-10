From: =?iso-8859-1?q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv2] ASoC: omap-mcbsp: Do not attempt to
	change DAI sysclk if stream is active
Date: Fri, 10 Jun 2011 17:01:52 +0300
Message-ID: <201106101701.52326.peter.ujfalusi@ti.com>
References: <1307711845-1636-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0C310383E
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 16:01:56 +0200 (CEST)
In-Reply-To: <1307711845-1636-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

> Attempt to change McBSP CLKS source while another stream is active is not
> safe after commit d135865 ("OMAP: McBSP: implement functional clock
> switching via clock framework") in 2.6.37.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
