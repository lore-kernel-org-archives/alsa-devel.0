From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no
 avaiable path found for widget kcontrol
Date: Thu, 2 Aug 2012 15:08:10 +0800
Message-ID: <20120802070809.GD30492@shlinux2.ap.freescale.net>
References: <1343387941-25266-1-git-send-email-b29396@freescale.com>
 <20120729202219.GA4384@opensource.wolfsonmicro.com>
 <20120801074952.GC30492@shlinux2.ap.freescale.net>
 <20120801121516.GO11892@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id C4469260304
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 09:23:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120801121516.GO11892@opensource.wolfsonmicro.com>
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

On Wed, Aug 01, 2012 at 08:15:16PM +0800, Mark Brown wrote:
> On Wed, Aug 01, 2012 at 03:49:53PM +0800, Dong Aisheng wrote:
> > On Mon, Jul 30, 2012 at 04:22:19AM +0800, Mark Brown wrote:
> 
> > > This isn't a good idea, it's fairly common for widgets to have a "None"
> > > option which isn't expected to have an input.
> 
> > What i changed is mux widgets, i'm wondering is it possible or correct
> > the mux widget has no input path?
> > If i understand correct, we may need set correct input path
> > for mux widget, or why we still need a mux?
> 
> > Or can you help give an example that no input needed for mux widget?
> 
> The above is the most common example - one of the inputs to a mux being
> a "no input" option which shouldn't be connected to anything.  A mux
> with no inputs at all would be silly, but having one (or sometimes a
> couple for various reasons) that isn't connected isn't unusual.
> 

Understand.
Thanks for the info.

Regards
Dong Aisheng
