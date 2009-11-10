From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC/mpc5200: remove duplicate identical
	IRQ handler
Date: Tue, 10 Nov 2009 13:03:43 +0000
Message-ID: <20091110130343.GD16200@rakim.wolfsonmicro.main>
References: <20091109163936.29231.482.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5358103892
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 14:03:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091109163936.29231.482.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 09:40:09AM -0700, Grant Likely wrote:
> The TX and RX irq handlers are identical.  Merge them

Applied, thanks.
