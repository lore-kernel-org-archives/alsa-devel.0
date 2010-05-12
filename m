From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/6] asoc: Add SOC_DOUBLE_R_SX_TLV control
Date: Wed, 12 May 2010 09:59:30 +0100
Message-ID: <20100512085930.GD4330@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162601.913930263@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21ADD2498B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 10:59:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100511162601.913930263@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 06:23:45PM +0200, apatard@mandriva.com wrote:
> This patch is adding a new control which has the following capabilities:
> - tlv
> - variable data size (for instance, 7 ou 8 bit)
> - double mixer

The major new change here is that the control allows for ranges which
wrap around in the middle rather than continuously increasing or
decreasing.  The change itself looks OK but if you repost please make
the changelog clearer.

Oh, and ASoC, not asoc.
