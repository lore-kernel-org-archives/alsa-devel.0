From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: fix crash when
	removing	not instantiated card
Date: Mon, 11 May 2009 19:04:07 +0100
Message-ID: <20090511180407.GA26817@rakim.wolfsonmicro.main>
References: <1242036295-29085-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E851724141
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 20:04:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242036295-29085-1-git-send-email-mike@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 01:04:55PM +0300, Mike Rapoport wrote:
> If the card was not instantiated in snd_soc_instantiate_card, calling
> soc-remove will crash because some of codec, cpu_dai and card .remove
> methods are called twice.
> Fix this by returning from soc_remove immediately.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Applied, thanks.
