From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] ASoC: codecs: wm8753: Fix register
 cache incoherency
Date: Tue, 28 Dec 2010 23:43:43 +0000
Message-ID: <20101228234342.GD3591@opensource.wolfsonmicro.com>
References: <1293568684-9626-1-git-send-email-lars@metafoo.de>
	<1293568684-9626-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0462E10392E
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2010 00:43:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293568684-9626-10-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 09:38:03PM +0100, Lars-Peter Clausen wrote:

> Furthermore the generic cache uses zero-based numbering while the wm8753 cache
> uses one-based numbering.

This is why the driver never got updated to use the generic code, FWIW -
the cleverness made it more effort to convert.
