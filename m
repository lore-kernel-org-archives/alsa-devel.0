From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v3 5/6] soundwire: Add support for multi
 link bank switch
Date: Mon, 18 Jun 2018 20:11:58 +0530
Message-ID: <20180618144158.GG25852@vkoul-mobl>
References: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
 <1528975923-15141-6-git-send-email-shreyas.nc@intel.com>
 <fe087024-ce4e-ca11-cf68-6dca583b7cbb@linux.intel.com>
 <20180618095015.GO3116@snc-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EEE8266D4C
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 16:42:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180618095015.GO3116@snc-desk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On 18-06-18, 15:20, Shreyas NC wrote:
> On Thu, Jun 14, 2018 at 01:34:13PM -0500, Pierre-Louis Bossart wrote:
> > 
> > >diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > >index 0e8a2eb5..771c963 100644
> > >--- a/drivers/soundwire/stream.c
> > >+++ b/drivers/soundwire/stream.c
> > >@@ -638,6 +638,8 @@ static int sdw_bank_switch(struct sdw_bus *bus)
> > >  	if (!wr_msg)
> > >  		return -ENOMEM;
> > >+	bus->defer_msg.msg = wr_msg;
> > >+
> > >  	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
> > >  	if (!wbuf) {
> > >  		ret = -ENOMEM;
> > >@@ -658,17 +660,23 @@ static int sdw_bank_switch(struct sdw_bus *bus)
> > >  					SDW_MSG_FLAG_WRITE, wbuf);
> > >  	wr_msg->ssp_sync = true;
> > >-	ret = sdw_transfer(bus, wr_msg);
> > >+	if (bus->multi_link)
> > >+		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
> > >+	else
> > >+		ret = sdw_transfer(bus, wr_msg);
> > >+
> > 
> > Re-reading this v3, I wonder if there is a small logic flaw here or an
> > intended behavior.
> > 
> > the bus->multi_link field is a hardware capability, it provides information
> > on whether the hardware can support synchronized bank switches across
> > multiple Master interfaces. This is independent of the streams being
> > handled, it's a bus property - not a stream one.

Pierre,

You are right that multi-link is a hw capability BUT it is also a 
property of a stream. I can envision machines where bus may have the
capability but the system configuration may have links being not clubbed
in one board and made a multi-link stream in another board :)

> > However the default/typical case is a stream handled by a single master, so
> > when the hardware is capable of handling multiple masters this does not mean
> > you should use the deferred transfer, the regular case would work just fine
> > for a regular stream. If your SSP rate is faster than the common sync signal
> > it might even be beneficial not to use the deferred transfer.
> > 
> > in other words, should the code be written with something like
> > if (bus->multi_link && master_rt_count > 1)
> > with master_rt_count being determined based on the stream properties.

Yes that makes sense to me

> > Or was the intent that you always rely on the deferred mechanism, even if
> > the stream is not handled by multiple masters? In that case, do we even need
> > the regular bank switch?
> 
> After discussing with folks here, I understand that intent was to have an
> unified flow for both Multi and Single instance cases. Yes, we can always
> use the sdw_transfer_defer() and remove the references to bus->multi_link
> possibly. So, I will fix this up and post v4.

Shreyas,

That sounds like a good plan to me

-- 
~Vinod
