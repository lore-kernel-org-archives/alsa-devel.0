From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mpc8610: tell the CS4270 codec that
	it's the master
Date: Tue, 22 Nov 2011 23:05:58 +0000
Message-ID: <20111122230558.GC3005@opensource.wolfsonmicro.com>
References: <1321994339-21906-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03E5424141
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 00:06:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321994339-21906-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 02:38:59PM -0600, Timur Tabi wrote:
> Commit ac601555 ("ASoC: Return early with -EINVAL if invalid dai format is
> detected") requires the machine driver to tell the CS4270 codec driver
> whether the CS4270 should be configured for master or slave operation.

Applied, thanks.
