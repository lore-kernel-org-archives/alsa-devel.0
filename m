From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa-ssp: fix name of register bit
Date: Thu, 5 Mar 2009 11:40:19 +0000
Message-ID: <20090305114019.GA7479@rakim.wolfsonmicro.main>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B16AF103885
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 12:40:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236197820-21022-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 09:16:57PM +0100, Daniel Mack wrote:
> A bit in PXA's SSCR0 register was erroneously named ADC but its name is
> in fact ADC (audio clock select).

Applied, but I think I spot a typo in the changelog (which I've fixed).
:)
