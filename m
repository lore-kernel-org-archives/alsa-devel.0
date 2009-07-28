From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH] ASoC: CX20442: push down machine
 independent line discipline bits
Date: Tue, 28 Jul 2009 22:26:08 +0100
Message-ID: <20090728212608.GC4505@sirena.org.uk>
References: <200907282155.29761.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E541A2479E
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 23:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907282155.29761.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2009 at 09:55:28PM +0200, Janusz Krzysztofik wrote:
> This patch adds machine independent line discipline code, prevoiusly exsiting
> inside my Amstrad Delta ASoC machine dirver, to the Conexant CX20442 codec
> driver. The code can be used as a standalone line discipline, or as a set of
> codec specific functions called from machine's line discipline callbacks.
> Anyway, the line discipline itself must be registered by a machine driver.

> Suggested by ASoC manintainer Mark Brown <broonie@opensource.wolfsonmicro.com>

Yes, this looks like a good improvement though I'd like to see the
matching machine driver at the same time before applying.
