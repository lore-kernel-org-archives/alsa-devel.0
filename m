From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: McASP driver enhacements
Date: Sat, 8 Aug 2009 09:11:58 +0100
Message-ID: <20090808081158.GC4519@sirena.org.uk>
References: <1249654062-23634-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BC7B0246E9
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 10:12:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249654062-23634-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2009 at 10:07:42AM -0400, Chaithrika U S wrote:

> This patch adds support for FIFO configuration.The platform member has a 
> version field which differentiates the McASP on different SoCs. The patch 
> also adds another DAI format to the driver.

You really should split out the DAI format addition into another patch -
there's no code overlap between that and the rest of your changes.
Aside from the issue Troy raised everything seems fine except for one
small issue:

> +
> +	/* McASP FIFO related */
> +	u8	txnumevt;
> +	u8	rxnumevt;

These names don't seem particularly obvious.  If they were chosen to
match the datasheet name then it probably won't be a problem but
otherwise something more like tx_fifo_depth might be easier for people
to figure out.
