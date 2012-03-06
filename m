From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: Query about regmap SPI
Date: Tue, 6 Mar 2012 23:04:12 +0530
Message-ID: <1331055252.2453.8.camel@matrix>
References: <1331045140.32512.7.camel@matrix>
	<1331046532.32512.35.camel@matrix>
	<20120306163012.GW19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 191CA2433F
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 18:22:23 +0100 (CET)
In-Reply-To: <20120306163012.GW19635@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-03-06 at 16:30 +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 08:38:52PM +0530, Ashish Chavan wrote:
> 
> > I also think that there should be a way to handle this kind of stuff by
> > the framework. May I know if you have any plan to add this to regmap? or
> > should I come up with a patch to extend regmap to support this and
> > propose you?
> 
> I have no need for it so I'm unlikely to work on it myself, if you were
> to send a patch that'd be great.

OK, I will go through regmap sources in detail to find out appropriate
place to put this. BTW do you have any recommendation in terms of a good
way to achieve this. e.g. will it be useful and generic enough if we
introduce two more fields like read/write_flag_mask to indicate shifting
and use those fields before applying read/write_flag_masks?
