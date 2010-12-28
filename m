From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/9 v2] ASoC: codecs: Fix register cache
	incoherencies
Date: Tue, 28 Dec 2010 23:42:38 +0000
Message-ID: <20101228234237.GC3591@opensource.wolfsonmicro.com>
References: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28DB8103923
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2010 00:42:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293568684-9626-1-git-send-email-lars@metafoo.de>
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

On Tue, Dec 28, 2010 at 09:37:54PM +0100, Lars-Peter Clausen wrote:
> The multi-component patch(commit f0fba2ad1) moved the allocation of the
> register cache from the driver to the ASoC core. Most drivers where adjusted to
> this, but there are also some drivers now which use a mixture of their own

Applied 2-9 for 2.6.37; patch 1 isn't really needed as a bug fix as we
just waste a bit of memory rather than crashing if something goes wrong.
I've applied that one for 2.6.38.
