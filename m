From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component - Fix tlv320aic3x
 GPIO initialization
Date: Fri, 6 Aug 2010 13:14:59 +0100
Message-ID: <20100806121459.GI398@rakim.wolfsonmicro.main>
References: <1281078278-10675-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FEF824448
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 14:15:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281078278-10675-1-git-send-email-jhnikula@gmail.com>
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

On Fri, Aug 06, 2010 at 10:04:38AM +0300, Jarkko Nikula wrote:
> aic3x_init does a soft reset first and thus TLV320AIC3x GPIO setup must be
> done after doing the basic init. Before multi-component the init was done
> at i2c probe time and GPIO setup at soc probe time.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
