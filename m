From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: [RFC PATCH] ASoC: Modify check condition of
 multiple bindings of components
Date: Fri, 16 Oct 2015 10:31:53 +0800
Message-ID: <1444962713.31246.6.camel@mtksdaap41>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
 <561D0AA9.5080702@metafoo.de> <1444745902.26493.2.camel@mtksdaap41>
 <561D1843.1020007@metafoo.de> <1444785549.26493.12.camel@mtksdaap41>
 <561E1991.1050705@metafoo.de> <20151015121035.GE14956@sirena.org.uk>
 <561FA979.6030407@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB9E260532
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 04:32:17 +0200 (CEST)
In-Reply-To: <561FA979.6030407@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-10-15 at 15:26 +0200, Lars-Peter Clausen wrote:
> On 10/15/2015 02:10 PM, Mark Brown wrote:
> > On Wed, Oct 14, 2015 at 11:00:01AM +0200, Lars-Peter Clausen wrote:
> > 
> >> It was never intended that it is possible to bind a component to multiple
> >> cards. That it was possible was a bug that was overlooked and some people
> >> tried to do it which caused apparently random crashes later on, caused by
> >> the data structure corruption. This is why we added the check to catch this
> >> kind of mistake early and to avoid the crashes.
> > 
> > This is true, but I do think it's something that we should have some
> > story on supporting for some of this hardware that has a bunch of
> > channels in one IP block that can't really interact with each other.
> > It's going to make it a lot easier for people to think about the
> > hardware and how to describe it.
> 
> I'm not saying we shouldn't support it, just that we can't support it with
> the current code. And adding support for it will require a fair bit of
> restructuring.
> 
> If a hardware block as multiple independent channels the best approach in my
> opinion is to register multiple components (Which we can't do at the moment,
> because there can only be one component per device). From a framework point
Yes... I have tried to register 2 platforms in my ASoC platform driver
but alsa considered they are the same platform since they are from the
same device.
> of view there is no difference between a single device with multiple
> independent channels and multiple independent devices with one channel each.
> Both have the same logical topology.
> 
Yes, but in my case there is only one HW, one set of registers, and one
set of clocks, it should be a single device node in the device tree. 
> - Lars
> 
> 
