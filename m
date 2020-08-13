Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:24:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EA720866
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mAU4A6FF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="Yuyqdzqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EA720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8FDD84D;
	Thu, 13 Aug 2020 13:23:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8FDD84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597317844;
	bh=89bAGdQq58IWsLtFPLh9wpw9ICJ6Mc83yC/h2CpVF7Y=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mAU4A6FFCnmEhdFfINmdc0f5fvQomz5NXIeAMcDI/Lka8xW1Z1gEbHnTFgW8TUatD
	 UXaigYwmgWR+1/35ZO69st7wmhITzjQpxpyU1QttiJ8jUN9hGwbDLfEWbP1iem6bvZ
	 liTQIb1oNjdhRWGMnDLZq4SzQ4fe2QafHXyOYEvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 648AAF800F4;
	Thu, 13 Aug 2020 13:23:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80D7FF8015B; Thu, 13 Aug 2020 13:23:12 +0200 (CEST)
Received: from mail2.skidata.com (mail2.skidata.com [91.230.2.91])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9458F800F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 13:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9458F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=skidata.com header.i=@skidata.com
 header.b="Yuyqdzqv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
 t=1597317786; x=1628853786;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=89bAGdQq58IWsLtFPLh9wpw9ICJ6Mc83yC/h2CpVF7Y=;
 b=YuyqdzqvaNcCHycYXpZvpzoTFVqAYSW8SjEufnX+XJi2+R5rsm/o1lj+
 UxnvtP4l3bCD9CMti1wcd88jZrGg0xg/NaPMEfsPPsvxfh8EiwoQusoCE
 ziOCOcJHQdc8+UbIJ+PrX/OaDs4EMWXw+KBIeev2ZmgUrIZ86Tp3ZQLyh
 +axhXia9V/qKKaDkvWl7WoDdmSAI4hc4hYoyDKdpy2ZVQ41fG+ph1/ECz
 WCAfRM3Z2MnIAJyqCHksZWUg8EkeC4Vx/PtoDshIfhUIOqF9OsrpmwjoV
 v9GgfUReb5c1lNW6FTH9UJwChswuxCRboDHssudQ+EKjqAXOrK1wxp0Km Q==;
IronPort-SDR: g2o/GJDhU0h+zjPmQsuKI9ODAT/nVkeCiipCpG2uwpWm3Ae9iIIdcYGq0fMra8Ta3DFaRKw9EN
 QHBiww9oRQd1JARQBabv+Mtm/liFgUXSvJNk1lVA4Sn+BgZlk68O6Yp7I/qdZbSH89QuUn4G8p
 bHRgOEaC8nffSuA5+pzf4rHSs7uX7mvkRpbaWzW3tNAD61xzP6sUICpmgLgiQ3BHpmpR4MGc0n
 Z3a5yxwqqljYiuMXgJWpi4RtTZw/LJi7D9uHi++qB7ptZ6mu0pQJA9I0ZlmGWFaIjYC/4aIRDr
 TJ4=
X-IronPort-AV: E=Sophos;i="5.76,308,1592863200"; 
   d="scan'208";a="2640424"
Date: Thu, 13 Aug 2020 13:22:58 +0200
From: Richard Leitner <richard.leitner@skidata.com>
To: <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: pcm|dmaengine|imx-sdma race condition on i.MX6
Message-ID: <20200813112258.GA327172@pcleri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Cc: timur@kernel.org, nicoleotsuka@gmail.com, vkoul@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, dan.j.williams@intel.com,
 shawnguo@kernel.org, Benjamin Bara <benjamin.bara@skidata.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,
we've found a race condition with the PCM on the i.MX6 which results in
an -EIO for the SNDRV_PCM_IOCTL_READI_FRAMES ioctl after an -EPIPE (XRUN).

A possible reproduction may look like the following reduced call graph
during a PCM capture:

us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES)
      - wait_for_avail()
        - schedule_timeout()
   -> snd_pcm_update_hw_ptr0()
      - snd_pcm_update_state: EPIPE (XRUN)
      - sdma_disable_channel_async() # get's scheduled away due to sleep
us <- ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns -EPIPE
us -> ioctl(SNDRV_PCM_IOCTL_PREPARE) # as reaction to the EPIPE (XRUN)
us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) # next try to capture frames
      - sdma_prep_dma_cyclic()
        - sdma_load_context() # not loaded as context_loaded is 1
      - wait_for_avail()
        - schedule_timeout()
# now the sdma_channel_terminate_work() comes back and sets
# context_loaded = false and frees in vchan_dma_desc_free_list().
us <- ioctl returns -EIO (capture write error (DMA or IRQ trouble?))


What we have found out, based on our understanding:
The dmaengine docu states that a dmaengine_terminate_async() must be
followed by a dmaengine_synchronize().
However, in the pcm_dmaengine.c, only dmaengine_terminate_async() is
called (for performance reasons and because it might be called from an
interrupt handler).

In our tests, we saw that the user-space immediately calls
ioctl(SNDRV_PCM_IOCTL_PREPARE) as a handler for the happened xrun
(previous ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns with -EPIPE). In
our case (imx-sdma.c), the terminate really happens asynchronously with
a worker thread which is not awaited/synchronized by the
ioctl(SNDRV_PCM_IOCTL_PREPARE) call.

Since the syscall immediately enters an atomic context
(snd_pcm_stream_lock_irq()), we are not able to flush the work of the
termination worker from within the DMA context. This leads to an
unterminated DMA getting re-initialized and then terminated.

On the i.MX6 platform the problem is (if I got it correctly) that the
sdma_channel_terminate_work() called after the -EPIPE gets scheduled
away (for the 1-2ms sleep [1]). During that time the userspace already
sends in the ioctl(SNDRV_PCM_IOCTL_PREPARE) and
ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
As none of them are anyhow synchronized to the terminate_worker the
vchan_dma_desc_free_list() [2] and "sdmac->context_loaded = false;" [3]
are executed during the wait_for_avail() [4] of the
ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).

To make sure we identified the problem correctly we've tested to add a
"dmaengine_synchronize()" before the snd_pcm_prepare() in [5]. This
fixed the race condition in all our tests. (Before we were able to
reproduce it in 100% of the test runs).

Based on our understanding, there are two different points to ensure
the termination:
Either ensure that the termination is finished within the previous
SNDRV_PCM_IOCTL_READI_FRAMES call (inside the DMA context) or finishing
it in the SNDRV_PCM_IOCTL_PREPARE call (and all other applicable ioclts)
before entering the atomic context (from the PCM context).

We initially thought about implementing the first approach, basically
splitting up the dma_device terminate_all operation into a sync
(busy-wait) and a async one. This would align the operations with the
DMAengine interface and would enable a sync termination variant from
atomic contexts.
However, we saw that the dma_free_attrs() function has a WARN_ON on irqs
disabled, which would be the case for the sync variant.

Side note: We found this issue on the current v5.4.y LTS branch,
but it also affects v5.8.y.

Any feedback or pointers how we may fix the problem are warmly welcome!
If anything is unclear please just ask :-)

regards;
Richard Leitner
Benjamin Bara

[1]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1066
[2]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1071
[3]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1072
[4]https://elixir.bootlin.com/linux/v5.8/source/sound/core/pcm_lib.c#L1825
[5]https://elixir.bootlin.com/linux/v5.8/source/sound/core/pcm_native.c#L3226
