From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: Fix recursive dependency due
	to select	ATMEL_SSC in SND_ATMEL_SOC_SSC
Date: Tue, 10 Jan 2012 18:18:43 +0000
Message-ID: <20120110181843.GC7164@opensource.wolfsonmicro.com>
References: <1326176352.4443.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 524372460E
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 19:18:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326176352.4443.1.camel@phoenix>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2012 at 02:19:12PM +0800, Axel Lin wrote:
> commit 739be96 "ASoC: Fix build dependency for SND_ATMEL_SOC_SSC"
> introduces below build warnings:

Applied, thanks.
