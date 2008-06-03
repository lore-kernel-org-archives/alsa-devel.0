From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Fix Kconfig and Makefile for
	Freescale	MPC8610 sound drivers
Date: Tue, 3 Jun 2008 09:41:05 +0100
Message-ID: <20080603084104.GA11006@rakim.wolfsonmicro.main>
References: <1212429813-10033-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94EF81037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jun 2008 10:41:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212429813-10033-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 02, 2008 at 01:03:33PM -0500, Timur Tabi wrote:
> Fix the Kconfig for the Freescale MPC8610 sound drivers so that only the
> board is selectable, but the SOC is still a Kconfig option.
> 
> Fix the Makefile so that all of the modules are named snd-soc-xxx.ko.

Applied, thanks.
