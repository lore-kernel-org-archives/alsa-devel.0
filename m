From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 19 Mar 2009 11:48:09 +0000
Message-ID: <20090319114809.GC1598@sirena.org.uk>
References: <1237451692.14402.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34A9B1038D0
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 12:48:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237451692.14402.10.camel@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 09:34:52AM +0100, Philipp Zabel wrote:

> +static u32 ssp_get_scr(struct ssp_dev *dev)

...

> +		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {

but here ssp is a ssp_device, not a ssp_dev (the compiler warns about
this).
