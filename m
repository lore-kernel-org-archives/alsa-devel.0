From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Tue, 1 Nov 2011 19:11:06 +0000
Message-ID: <20111101191106.GM10029@opensource.wolfsonmicro.com>
References: <1320173157-8595-1-git-send-email-alan.tull@freescale.com>
	<9E5C29D1DC97674D8FB0F7D26508F7861F05DB@039-SN1MPN1-005.039d.mgd.msft.net>
	<20111101184955.GJ10029@opensource.wolfsonmicro.com>
	<9E5C29D1DC97674D8FB0F7D26508F7861F0620@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBB97103852
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 20:11:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9E5C29D1DC97674D8FB0F7D26508F7861F0620@039-SN1MPN1-005.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tull Alan-R80115 <R80115@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 01, 2011 at 06:57:47PM +0000, Tull Alan-R80115 wrote:

On public Linux lists you should never top post (so people have context
and know what you're talking about) and you should fix your mail client
to word wrap within paragraphs.

> I originally started down the path you are describing, but quickly ran
> into problems.  I started by adding a soc_pcm_copy and soc_pcm_mmap
> and found that I needed to pull code from ALSA core in to handle the
> case where copy or mmap was NULL for a given platform driver.  

In that case your changelog needs to explain this and I'd still use a
function for those ops that don't have stubs in the core.  Things like
ioctl() could usefully be routed to all the drivers, for example.
