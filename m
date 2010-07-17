From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: davinci: let platform data define
 edma queue numbers
Date: Sat, 17 Jul 2010 19:50:19 +0100
Message-ID: <20100717185018.GC27456@rakim.wolfsonmicro.main>
References: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D636103818
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:50:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 05:44:19PM +0530, Sekhar Nori wrote:

> This patch has been tested on DM644x and OMAP-L138 EVMs.

> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

> This patch applies to latest of Linus's tree.

...so it doesn't apply against my for-2.6.36 branch (and obviously
there's crossover with Kevin's tree as well which makes things possibly
a bit interesting too).  Could you please regenerate against for-2.6.36?
You should generally always send patches against the latest version of
code rather than Linus' tree, using other trees increases the chances
that your patch will not apply.
