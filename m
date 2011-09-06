From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin: bf5xx-ad193x: Fix codec
	device name
Date: Mon, 5 Sep 2011 18:11:47 -0700
Message-ID: <20110906011146.GA31600@opensource.wolfsonmicro.com>
References: <1315223397-18627-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56BCE24356
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 03:11:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315223397-18627-1-git-send-email-lars@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 05, 2011 at 01:49:57PM +0200, Lars-Peter Clausen wrote:
> Fix the codec_name field of the dai_link to match the actual device name
> of the codec. Otherwise the card won't be instantiated.

Applied, thanks.
