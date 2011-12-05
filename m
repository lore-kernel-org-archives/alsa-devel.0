From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: uda1380: Convert to
	gpio_request_one()
Date: Mon, 5 Dec 2011 13:25:29 +0000
Message-ID: <20111205132529.GK11150@opensource.wolfsonmicro.com>
References: <1323043105.5179.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97AF6103A5D
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:25:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323043105.5179.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 07:58:25AM +0800, Axel Lin wrote:
> Using gpio_request_one can make the error handling simpler.

> Also remove a redundant "Failed to issue reset" error message.
> We already show the error message in uda1380_reset() error path.

Applied, thanks.
