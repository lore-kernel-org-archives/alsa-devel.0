From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: mx27vis-aic32x4: Remove unneeded
	header
Date: Mon, 4 Jul 2011 12:19:33 -0700
Message-ID: <20110704191932.GA32624@opensource.wolfsonmicro.com>
References: <1309806084-9945-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50DC3103874
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 21:19:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309806084-9945-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 04:01:24PM -0300, Fabio Estevam wrote:
> There is no machine type check on this code, so remove the mach-types header.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This isn't really useful - if you're going to change something here you
should change the code to check for the machine.
