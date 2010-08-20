From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] asoc/multi-component: add support for
 separate codec DAIs to the fsl_dma driver
Date: Fri, 20 Aug 2010 10:39:03 +0100
Message-ID: <1282297143.3084.49.camel@odin>
References: <1282254222-19990-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8017D1038BB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:39:20 +0200 (CEST)
Received: by wwc33 with SMTP id 33so406896wwc.20
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 02:39:20 -0700 (PDT)
In-Reply-To: <1282254222-19990-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-19 at 16:43 -0500, Timur Tabi wrote:
> Some codecs have separate DAIs for playback and capture, so the DMA driver
> should allocate a DMA buffer only for the streams that are valid when the
> driver is opened.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
