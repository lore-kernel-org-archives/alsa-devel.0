From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no
 avaiable path found for widget kcontrol
Date: Wed, 1 Aug 2012 15:49:53 +0800
Message-ID: <20120801074952.GC30492@shlinux2.ap.freescale.net>
References: <1343387941-25266-1-git-send-email-b29396@freescale.com>
 <20120729202219.GA4384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id AAC8D265D02
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 10:03:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120729202219.GA4384@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 30, 2012 at 04:22:19AM +0800, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 07:19:01PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This could help people know what's wrong going on if the required
> > path is not registered.
> 
> This isn't a good idea, it's fairly common for widgets to have a "None"
> option which isn't expected to have an input.
> 

What i changed is mux widgets, i'm wondering is it possible or correct
the mux widget has no input path?
If i understand correct, we may need set correct input path
for mux widget, or why we still need a mux?

Or can you help give an example that no input needed for mux widget?

Regards
Dong Aisheng
