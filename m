From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Select DMA driver for Samsung DAIs
Date: Tue, 21 Sep 2010 14:22:23 +0100
Message-ID: <20100921132223.GC29838@rakim.wolfsonmicro.main>
References: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTikQeNoKCHnizQ74H5q4bacfmYBCVvJVbznNrZOx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AE22103891
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:22:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikQeNoKCHnizQ74H5q4bacfmYBCVvJVbznNrZOx@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 21, 2010 at 09:38:04AM +0900, Jassi Brar wrote:

> SND_S3C_SOC_PCM builds s3c-pcm.c, which is the PCM controller's CPU driver.

> s3c-dma.c is the DMA driver for Samsung SoCs, which is already built
> as the first
> thing for Samsung ASoC.

Gah, yeah.  Wonder what my actual problem was then...
