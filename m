From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v2 4/6] soundwire: Handle multiple master
 instances in a stream
Date: Wed, 13 Jun 2018 16:15:34 +0530
Message-ID: <20180613104534.GM3116@snc-desk>
References: <1528800824-696-1-git-send-email-shreyas.nc@intel.com>
 <1528800824-696-5-git-send-email-shreyas.nc@intel.com>
 <d6df99eb-e48b-7354-849d-cde43e33b504@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 751D72673C7
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 12:47:10 +0200 (CEST)
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

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

As mentioned in the commit log, this is just a boilerplate conversion to
loop over multiple m_rt and it is in the next patch that the
multilink_bank_switch() is added.
So, I can mention in the commit log of this patch that this is just a
preparatory patch for the next patch. And, also I will add the necessary
details in the next patch.

--Shreyas

-- 
