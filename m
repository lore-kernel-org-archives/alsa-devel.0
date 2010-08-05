From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 08:14:43 -0500
Message-ID: <AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3661038C9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 15:15:15 +0200 (CEST)
Received: by gxk26 with SMTP id 26so2716104gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 06:15:13 -0700 (PDT)
In-Reply-To: <20100805111010.GA13146@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 5, 2010 at 6:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> My first thought with this is that it's not something I'd expect to be
> in the device tree at all - it looks like it's all properties of the
> silicon which I'd expect the drivers to be able to figure out for
> themselves without needing to be told by the device tree.

There is no way for the software to know what the FIFO depth is, so
this is the sort of thing that should be in the device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
