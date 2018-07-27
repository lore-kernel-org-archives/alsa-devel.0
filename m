From: Shreyas Nc <shreyas.nc@intel.com>
Subject: Re: [PATCH v7 09/10] soundwire: Add support for multi
 link bank switch
Date: Fri, 27 Jul 2018 08:52:47 +0530
Message-ID: <20180727032242.GA3269@snc-desk>
References: <1532605362-19282-1-git-send-email-shreyas.nc@intel.com>
 <1532605362-19282-10-git-send-email-shreyas.nc@intel.com>
 <ffec253d-427d-44dd-522e-f0ffd08dfae6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C724E26778A
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 05:24:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ffec253d-427d-44dd-522e-f0ffd08dfae6@linux.intel.com>
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

> >+		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
> >+	else
> >+		ret = sdw_transfer(bus, wr_msg);
> >+
> >  	if (ret < 0) {
> >  		dev_err(bus->dev, "Slave frame_ctrl reg write failed");
> >  		goto error;
> >  	}
> >-	kfree(wr_msg);
> >-	kfree(wbuf);
> >-	bus->defer_msg.msg = NULL;
> >-	bus->params.curr_bank = !bus->params.curr_bank;
> >-	bus->params.next_bank = !bus->params.next_bank;
> >+	if (!bus->multi_link) {
> >+		kfree(wr_msg);
> >+		kfree(wbuf);
> >+		bus->defer_msg.msg = NULL;
> >+		bus->params.curr_bank = !bus->params.curr_bank;
> >+		bus->params.next_bank = !bus->params.next_bank;
> >+	}
> 
> Should this test be extended to the case where the bus can support
> multi-link but m_rt_count ==1
> should it be
> if (!multi_link)
> ?
>
Sure, makes sense to add the right check.
v8 on its way ..

--Shreyas

-- 
