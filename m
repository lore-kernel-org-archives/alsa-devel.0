From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/13] soundwire: Add support for SoundWire
 stream management
Date: Fri, 30 Mar 2018 12:14:43 +0530
Message-ID: <20180330064443.GQ15443@localhost>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
 <1522229918-4748-3-git-send-email-vinod.koul@intel.com>
 <aa0b5013-b15a-5662-b51e-9e64f03e062a@linux.intel.com>
 <20180330064248.GP15443@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 174282671F9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 08:40:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180330064248.GP15443@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 30, 2018 at 12:12:48PM +0530, Vinod Koul wrote:
> On Thu, Mar 29, 2018 at 08:57:59PM -0500, Pierre-Louis Bossart wrote:
> > On 3/28/18 4:38 AM, Vinod Koul wrote:
> 
> > >+/**
> > >+ * sdw_slave_runtime: Runtime Stream parameters for Slave
> > >+ *
> > >+ * @slave: Slave handle
> > >+ * @direction: Data direction w.r.t Slave
> > >+ * @ch_count: Channel count of the Slave w.r.t stream
> > 
> > same here, I flagged all this already as needing to be fixed. Something's
> > not right here, looks to me like you send the wrong version of the
> > patches...
> 
> Somehow missed this bit will fix

On this one, I think i need more help.

SO is your question on direction right, we are thinking of making it:

enum sdw_data_direction {
	SDW_DATA_TX,
	SDW_DATA_RX,
}

and then use it is SDW. Is that okay for you or not..

For ch_count, we will update the comment.

> 
> > >+struct sdw_master_runtime {
> > >+	struct sdw_bus *bus;
> > >+	struct sdw_stream_runtime *stream;
> > >+	unsigned int ch_count;
> > >+	struct list_head slave_rt_list;
> > >+	struct list_head bus_node;
> > >+};
> > 
> > no direction?
> 
> Yes no direction here. Why would sdw_master_runtime need direction.
> 
> If you look closely we do have direction but in data ports.
> 
> One can argue we can move direction up here and remove from data ports,
> that seems logical, is that something you would like to see?
> 
> > >+enum sdw_data_direction {
> > >+	SDW_DATA_DIR_IN = 0,
> > >+	SDW_DATA_DIR_OUT = 1,
> > >+};
> > 
> > WTH? Didn't we agree that we would use SoundWire concepts instead of
> > redefining new concepts.
> 
> So we will make this TX/RX as discussed.
> 
> -- 
> ~Vinod

-- 
~Vinod
