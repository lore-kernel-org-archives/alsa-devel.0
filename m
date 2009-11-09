From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Pandora: Pass SRG input clock
 frequency to the OMAP McBSP DAI
Date: Mon, 9 Nov 2009 13:19:23 +0000
Message-ID: <20091109131851.GB25530@rakim.wolfsonmicro.main>
References: <1257749072-3796-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A32D10386A
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 14:19:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257749072-3796-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 08:44:32AM +0200, Jarkko Nikula wrote:
> Upcoming change to omap-mcbsp.c require that machine drivers using OMAP
> as a DAI master to pass sample rate generator input clock frequency to
> the omap-mcbsp.c DAI driver.
> 
> Pandora is using 256*Fs output from the TWL4030 codec as an input clock to
> the McBSP sample rate generator.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>

Applied, thanks.
