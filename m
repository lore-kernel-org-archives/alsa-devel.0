From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: multi-component - Add to support
 AC97 codec driver on SMDK
Date: Thu, 15 Jul 2010 10:34:04 +0100
Message-ID: <20100715093403.GF23529@rakim.wolfsonmicro.main>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-3-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0222C1038FB
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 11:34:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279184328-31746-3-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 05:58:48PM +0900, Seungwhan Youn wrote:
> This patch adds AC97 codec driver for SMDK board.

We already have a driver for this in mainline (which you are modifying).
It looks like what you're actually doing is registering a device for the
AC'97 CODEC so things probe.
