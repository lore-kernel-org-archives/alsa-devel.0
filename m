From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] ASoC: sh: use correct __iomem
	annotations
Date: Sun, 02 Oct 2011 23:20:07 +0200
Message-ID: <3365303.m9SmYBJMXM@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-5-git-send-email-arnd@arndb.de>
	<20111002205008.GB4506@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 22D9D2438E
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 23:20:56 +0200 (CEST)
In-Reply-To: <20111002205008.GB4506@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sunday 02 October 2011 21:50:09 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:02PM +0200, Arnd Bergmann wrote:
> > This removes a few unnecessary type casts and avoids
> > sparse warnings.
> 
> Applied, thanks.

Thank you very much for the realtime feedback and patch applying.

	Arnd
