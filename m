From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/9] ASoC: codecs: Fix register cache
	incoherencies
Date: Fri, 24 Dec 2010 14:57:06 +0000
Message-ID: <20101224145706.GA16614@opensource.wolfsonmicro.com>
References: <1293198484-1902-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB2901039C1
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 15:56:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293198484-1902-1-git-send-email-lars@metafoo.de>
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

On Fri, Dec 24, 2010 at 02:47:55PM +0100, Lars-Peter Clausen wrote:
> The multi-component patch(commit f0fba2ad1) introduced a generic register cache
> framework. Most of the drivers where converted to use this new framework. But

No it didn't - soc-cache.c has been present since the middle of 2009.
