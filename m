From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: pxa-ssp: Correct check for
	stream presence
Date: Thu, 23 Jun 2011 20:10:38 +0100
Message-ID: <20110623191037.GB24328@opensource.wolfsonmicro.com>
References: <1308768505-19878-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2F812442D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 21:10:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308768505-19878-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 08:48:25PM +0200, Daniel Mack wrote:
> Don't rely on the codec's channels_min information to decide wheter or
> not allocate a substream's DMA buffer. Rather check if the substream
> itself was allocated previously.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Applied, thanks.
