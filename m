From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 03/13] soundwire: Add support for port
 management
Date: Tue, 17 Apr 2018 09:41:56 +0530
Message-ID: <20180417041156.GT6014@localhost>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-4-git-send-email-vinod.koul@intel.com>
 <d0b1f66b-a530-62cf-91fb-e205b379e405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 825ED266C99
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 06:07:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d0b1f66b-a530-62cf-91fb-e205b379e405@linux.intel.com>
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

On Mon, Apr 16, 2018 at 06:30:58PM -0500, Pierre-Louis Bossart wrote:

> >  int sdw_stream_remove_slave(struct sdw_slave *slave,
> >  		struct sdw_stream_runtime *stream)
> >  {
> >  	mutex_lock(&slave->bus->bus_lock);
> >+	sdw_slave_port_release(slave->bus, slave, stream);
> 
> Humm, does this work if the sdw_stream_remove_master() is called first?
> It'll call sdw_release_slave_stream() so you have lost the s_rt pointer by
> the time you want to call sdw_slave_port_release() so will never free the
> ports?
> 
> You will also have lost the stream->m_rt at that point. I believe the slave
> ports should be freed from sdw_release_slave_stream(). This call to
> sdw_slave_port_release comes too late if the master takes the initiative
> first to clean house.

Thanks for spotting I believe, we should either call
sdw_stream_remove_slave() here to remove port and slave runtime or add
remove port in sdw_release_master_stream as well for the case master removed
first.

Will check and update this.

-- 
~Vinod
