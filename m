From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 17:03:35 -0500
Message-ID: <500F1BB7.7020504@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F1B05.3050107@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id E59F5265DA4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:03:40 +0200 (CEST)
In-Reply-To: <500F1B05.3050107@wwwdotorg.org>
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
> The I2C code matches the compatible values from the device tree against
> two tables in the kernel. First, the of_match_table that this patch
> adds, and then if there's no match it falls back to the I2C device ID
> table, and matches that against the DT compatible value with the vendor
> prefix stripped off.
> 
> So while the second method does work as a fall-back, in the past I've
> received guidance (I think from Grant Likely) that we should still add
> the of_match_table to drivers in order to be explicit.

So you're saying that all I2C device drivers should have an
of_match_table()?  If so, then we should probably fix all codec drivers in
one patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
