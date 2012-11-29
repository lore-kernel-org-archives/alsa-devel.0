From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 2/2] ASoC: simple-card: add DT support
Date: Wed, 28 Nov 2012 22:20:14 -0700
Message-ID: <50B6F08E.8040700@wwwdotorg.org>
References: <87txs9hvy7.wl%kuninori.morimoto.gx@renesas.com>
 <87r4ndhvwj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id A7E04264F2A
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 06:20:17 +0100 (CET)
In-Reply-To: <87r4ndhvwj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/28/2012 09:32 PM, Kuninori Morimoto wrote:

This could benefit from a patch description.

A file in Documentation/devicetree/bindings is required to specify the
format of the device tree.

Property name prefixes such as "cinfo," aren't very descriptive; what
does that mean?

A property name prefix such as "asoc," sounds Linux- (ASoC-) specific;
DT is supposed to represent HW, and hence shouldn't be influenced by OS
naming, etc.

Looking at the code, I think the machine driver is binding to the other
components by string name. With DT, it should be using phandles to point
at them instead.

The sysclk value that's parsed from DT doesn't appear to be used. How
does clocking work with this driver; what about when the sample-rate
changes, etc.?
