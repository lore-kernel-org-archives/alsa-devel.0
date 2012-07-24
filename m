From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 17:02:35 -0500
Message-ID: <500F1B7B.1070602@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com> <500F1B3E.1070804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id D9567265D8B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:02:40 +0200 (CEST)
In-Reply-To: <500F1B3E.1070804@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote:
> Perhaps your board permanently ties the reset line to de-asserted, or
> the bootloader/... deasserts the codecs reset pin before the kernel boots?

Probably.  We have a pretty sophisticate FPGA on our reference boards that
handles a lot of stuff like this.

-- 
Timur Tabi
Linux kernel developer at Freescale
