From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix resource leak if
 soc_register_ac97_dai_link failed
Date: Tue, 7 Dec 2010 15:26:50 +0000
Message-ID: <20101207152650.GE9689@rakim.wolfsonmicro.main>
References: <1291726590.2760.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B610824371
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 16:26:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291726590.2760.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 08:56:30PM +0800, Axel Lin wrote:
> Properly free the resources in the case of soc_register_ac97_dai_link failure.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
