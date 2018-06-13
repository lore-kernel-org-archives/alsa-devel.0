From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v2 4/6] soundwire: Handle multiple master
 instances in a stream
Date: Wed, 13 Jun 2018 11:24:41 +0530
Message-ID: <20180613055441.GA1127@buildpc-HP-Z230>
References: <1528800824-696-1-git-send-email-shreyas.nc@intel.com>
 <1528800824-696-5-git-send-email-shreyas.nc@intel.com>
 <d6df99eb-e48b-7354-849d-cde43e33b504@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EAABD2673F2
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 07:54:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d6df99eb-e48b-7354-849d-cde43e33b504@linux.intel.com>
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 12, 2018 at 02:12:46PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 06/12/2018 05:53 AM, Shreyas NC wrote:
> >From: Vinod Koul <vkoul@kernel.org>
> >
> >For each SoundWire stream operation, we need to parse master
> >list and operate upon all master runtime.
> >
> >This patch does the boilerplate conversion of stream handling
> >from single master runtime to handle a list of master runtime.
> >
> >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> >---
> >  drivers/soundwire/stream.c    | 308 +++++++++++++++++++++++++-----------------
> >  include/linux/soundwire/sdw.h |   2 -
> >  2 files changed, 185 insertions(+), 125 deletions(-)
> >
> >diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> >index eb942c6..36506a7 100644
> >--- a/drivers/soundwire/stream.c
> >+++ b/drivers/soundwire/stream.c
> >@@ -681,35 +681,44 @@ static int sdw_bank_switch(struct sdw_bus *bus)
> >  static int do_bank_switch(struct sdw_stream_runtime *stream)
> >  {
> >-	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+	struct sdw_master_runtime *m_rt = NULL;
> >  	const struct sdw_master_ops *ops;
> >-	struct sdw_bus *bus = m_rt->bus;
> >+	struct sdw_bus *bus = NULL;
> >  	int ret = 0;
> >-	ops = bus->ops;
> >-	/* Pre-bank switch */
> >-	if (ops->pre_bank_switch) {
> >-		ret = ops->pre_bank_switch(bus);
> >+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> >+		bus = m_rt->bus;
> >+		ops = bus->ops;
> >+
> >+		/* Pre-bank switch */
> >+		if (ops->pre_bank_switch) {
> >+			ret = ops->pre_bank_switch(bus);
> >+			if (ret < 0) {
> >+				dev_err(bus->dev,
> >+					"Pre bank switch op failed: %d", ret);
> >+				return ret;
> >+			}
> >+		}
> >+
> >+		/* Bank switch */
> >+		ret = sdw_bank_switch(bus);
> >  		if (ret < 0) {
> >-			dev_err(bus->dev, "Pre bank switch op failed: %d", ret);
> >+			dev_err(bus->dev, "Bank switch failed: %d", ret);
> >  			return ret;
> >  		}
> You probably want to add a comment that in multi-link operation the actual
> bank_switch happens later and is done in a synchronized manner. This is lost
> if you just move code around and move the bank_switch into a loop.
> 
> I am actually no longer clear just looking at this code on when the
> bank_switch happens (i know we've discussed this before but I am trying to
> find out just based on this v2 instead of projecting how I think it should
> work):
> In Patch 6/6 it's pretty obvious that the bank switch happens when the
> SyncGO bit is set, but there is no comment or explanation on how we reach
> the intel_post_bank_switch() routine once for all masters handling a stream
> when everything is based on loops. Clearly the intel_pre_bank_switch is
> called multiple times (once per master), I guess I am missing what the
> trigger is for the intel_post_bank_switch() routine to be invoked?
>

Hi Pierre,

To answer your last question, do_bank_switch is where we perform all the
bank switch operations.

In first loop for Master(s) involved in stream, ops->pre_bank_switch and
bank_switch is performed. In 2nd loop for Master(s) involved in stream,
ops->post_bank_switch and wait for bank switch is performed.

Assuming a stream with Master 1 and Master 2, the go_sync bit will be
set in Master 1 intel_post_bank_switch call which will trigger bank
switch for both the Master's. The Master 2 intel_post_bank_switch call
will just return as it will won't see CMDSYNC bit set for any Master(s).

> >  	}
> >-	/* Bank switch */
> >-	ret = sdw_bank_switch(bus);
> >-	if (ret < 0) {
> >-		dev_err(bus->dev, "Bank switch failed: %d", ret);
> >-		return ret;
> >-	}
> >-
> >  	/* Post-bank switch */
> >-	if (ops->post_bank_switch) {
> >-		ret = ops->post_bank_switch(bus);
> >-		if (ret < 0) {
> >-			dev_err(bus->dev,
> >+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> >+		bus = m_rt->bus;
> >+		ops = bus->ops;
> >+		if (ops->post_bank_switch) {
> >+			ret = ops->post_bank_switch(bus);
> >+			if (ret < 0) {
> >+				dev_err(bus->dev,
> >  					"Post bank switch op failed: %d", ret);
> >+			}
> >  		}
> >  	}
> >  };
> 

-- 
