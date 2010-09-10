From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: tlv320aic3x: Optimize PLL
 programming in aic3x_set_bias_level
Date: Fri, 10 Sep 2010 12:36:50 +0100
Message-ID: <20100910113650.GE7259@rakim.wolfsonmicro.main>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA231103939
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:36:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 02:23:29PM +0300, Jarkko Nikula wrote:
> There is only need to enable/disable once the PLL when the bias is going
> between on, prepare, standby and off states.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
