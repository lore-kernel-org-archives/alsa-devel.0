From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH,
 resend] ASoC: omap-mcbsp: Do not attempt to change DAI sysclk if
 stream is active
Date: Fri, 23 Sep 2011 11:52:21 +0100
Message-ID: <20110923105219.GA3970@opensource.wolfsonmicro.com>
References: <1316765954-17076-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88C4C2414C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 12:52:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316765954-17076-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 23, 2011 at 11:19:13AM +0300, Jarkko Nikula wrote:
> Attempt to change McBSP CLKS source while another stream is active is not
> safe after commit d135865 ("OMAP: McBSP: implement functional clock
> switching via clock framework") in 2.6.37.

Applied, thanks.
