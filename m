From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 16:00:37 -0600
Message-ID: <500F1B05.3050107@wwwdotorg.org>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FDC3265D87
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:00:39 +0200 (CEST)
In-Reply-To: <500F05CC.2000105@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/24/2012 02:30 PM, Timur Tabi wrote:
> Daniel Mack wrote:
>> How do you instanciate it then? Somehow the DT core must know which
>> device to probe for a node, right?
> 
> drivers/of/of_i2c.c
> 
> It scans the device tree looking for I2C devices and registers them.

The I2C code matches the compatible values from the device tree against
two tables in the kernel. First, the of_match_table that this patch
adds, and then if there's no match it falls back to the I2C device ID
table, and matches that against the DT compatible value with the vendor
prefix stripped off.

So while the second method does work as a fall-back, in the past I've
received guidance (I think from Grant Likely) that we should still add
the of_match_table to drivers in order to be explicit.
