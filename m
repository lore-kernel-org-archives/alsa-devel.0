From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 15:30:04 -0500
Message-ID: <500F05CC.2000105@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 60B592652C8
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:30:24 +0200 (CEST)
In-Reply-To: <500F050D.6080505@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> How do you instanciate it then? Somehow the DT core must know which
> device to probe for a node, right?

drivers/of/of_i2c.c

It scans the device tree looking for I2C devices and registers them.

-- 
Timur Tabi
Linux kernel developer at Freescale
