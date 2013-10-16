From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 12:13:09 +0000
Message-ID: <g1gy4k6lirks6utvo7nfupyq.1381925597520@email.android.com>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>,
 <20131016115847.GK2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F931261A3D
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 14:13:13 +0200 (CEST)
In-Reply-To: <20131016115847.GK2443@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Okay,  I will try to refine it tomorrow.

Thank you for the comments.

Sent by Android device.

Mark Brown <broonie@kernel.org> wrote:


On Wed, Oct 16, 2013 at 06:53:21PM +0800, Nicolin Chen wrote:

> +     if (!dev->of_node)
> +             return NULL;
> +
> +     pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> +     if (!pool)
> +             return NULL;

Can you refactor these ifdefs so they just protect this OF specific code
and just have the allocation fail otherwise please?  That way the OF
dependency is minimised - we should be able to support this on other
platforms in the future and the rest of the code will be the same.

Also is iram the best name?  It makes me think of the dedicated fast
instruction RAM that some processors have.  sram perhaps (for static
RAM)?
