From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH 3/6] soundwire: Add support to lock across
 bus instances
Date: Wed, 6 Jun 2018 11:02:26 +0530
Message-ID: <20180606053224.GK3116@snc-desk>
References: <1528196497-29554-1-git-send-email-shreyas.nc@intel.com>
 <1528196497-29554-4-git-send-email-shreyas.nc@intel.com>
 <410b5432-cfc4-4a67-467a-aa091a85cdf3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id BE510267712
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 07:34:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <410b5432-cfc4-4a67-467a-aa091a85cdf3@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

> >Typically to lock, one would acquire a global lock and then lock
> >bus instances. In this case, the caller framework(ASoC DPCM)
> >guarentees that stream operations on a card are always serialised.
> guarantees

Aargh! Ok, will fix it :)

> >So, there is no race condition and hence no need for global lock.
> >
> >Bus lock(s) are acquired to reconfigure the bus while the stream
> >is set-up.
> >So, we add sdw_acquire_bus_lock()/sdw_release_bus_lock() for the same.
> We should add a precision that this lock is only needed for the
> reconfiguration parts. It is my understanding that we can still do a
> synchronized bank switch between two or more streams handled by multiple
> masters, right?

Yes for the first question. I will add a note on the usage in the APIs.

By "synchronized bank switch between two or more streams", are you
referring to sync start of multiple stream handled by multiple masters?
If that is the case it requires a bit more focus and we have not
suppported/tested yet.

> >
> >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> >---
> >  drivers/soundwire/bus.h       |  2 ++
> >  drivers/soundwire/stream.c    | 26 ++++++++++++++++++++++++++
> >  include/linux/soundwire/sdw.h |  2 ++
> >  3 files changed, 30 insertions(+)
> >
> >diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> >index 3b15c4e..b6cfbdf 100644
> >--- a/drivers/soundwire/bus.h
> >+++ b/drivers/soundwire/bus.h
> >@@ -99,6 +99,7 @@ struct sdw_slave_runtime {
> >   * this stream, can be zero.
> >   * @slave_rt_list: Slave runtime list
> >   * @port_list: List of Master Ports configured for this stream, can be zero.
> >+ * @stream_node: sdw_stream_runtime master_list node
> Should we clarify that there is an expectation that the master_list can only
> handle one node per master?
>

Sure, if it make things clearer :)

Thanks for the review!

--Shreyas

-- 
