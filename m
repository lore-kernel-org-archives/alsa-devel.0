From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 6/9] soundwire: Handle multiple master
 instances in a stream
Date: Tue, 10 Jul 2018 22:32:29 +0530
Message-ID: <20180710170229.GB22349@buildpc-HP-Z230>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
 <1530791196-15483-7-git-send-email-shreyas.nc@intel.com>
 <19b89cc8-b97e-dd43-3d96-8c5bdcb5287d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9962676FE
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 19:01:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <19b89cc8-b97e-dd43-3d96-8c5bdcb5287d@linux.intel.com>
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

On Mon, Jul 09, 2018 at 06:42:34PM -0500, Pierre-Louis Bossart wrote:
> Sorry, another issue that I found while reviewing the entire section.
> >  }
> >@@ -888,6 +918,7 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
> >  /**
> >   * sdw_release_master_stream() - Free Master runtime handle
> >   *
> >+ * @m_rt: Master runtime node
> >   * @stream: Stream runtime handle.
> >   *
> >   * This function is to be called with bus_lock held
> >@@ -895,16 +926,18 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
> >   * handle. If this is called first then sdw_release_slave_stream() will have
> >   * no effect as Slave(s) runtime handle would already be freed up.
> >   */
> >-static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
> >+static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
> >+			struct sdw_stream_runtime *stream)
> >  {
> >-	struct sdw_master_runtime *m_rt = stream->m_rt;
> >  	struct sdw_slave_runtime *s_rt, *_s_rt;
> >  	list_for_each_entry_safe(s_rt, _s_rt,
> >  			&m_rt->slave_rt_list, m_rt_node)
> >  		sdw_stream_remove_slave(s_rt->slave, stream);
> >+	list_del(&m_rt->stream_node);
> >  	list_del(&m_rt->bus_node);
> >+	kfree(m_rt);
> >  }
> >  /**
> >@@ -918,13 +951,22 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
> >  int sdw_stream_remove_master(struct sdw_bus *bus,
> >  		struct sdw_stream_runtime *stream)
> >  {
> >+	struct sdw_master_runtime *m_rt, *_m_rt;
> >+
> >  	mutex_lock(&bus->bus_lock);
> >-	sdw_release_master_stream(stream);
> >-	sdw_master_port_release(bus, stream->m_rt);
> >-	stream->state = SDW_STREAM_RELEASED;
> >-	kfree(stream->m_rt);
> >-	stream->m_rt = NULL;
> >+	list_for_each_entry_safe(m_rt, _m_rt,
> >+			&stream->master_list, stream_node) {
> >+
> >+		if (m_rt->bus != bus)
> >+			continue;
> >+
> >+		sdw_master_port_release(bus, m_rt);
> >+		sdw_release_master_stream(m_rt, stream);
> >+	}
> >+
> >+	if (list_empty(&stream->master_list))
> >+		stream->state = SDW_STREAM_RELEASED;
> >  	mutex_unlock(&bus->bus_lock);
> >
> So the sequence is
> 
> mutex_lock
> sdw_master_port_release()
> sdw_release_master_stream()
> ?????? sdw_stream_remove_slave()
> ?????? ?????? mutex_lock
> 
> Is this intentional to take the same mutex twice (not sure if it even
> works).

sdw_stream_remove_slave is called from sdw_release_master_stream to make
sure all Slave(s) resources are freed up before freeing Master.
sdw_stream_remove_slave is also called by Slave driver to free up Slave
resources. In either case, we wanted to make sure the bus_lock is held
hence the bus lock is held in sdw_stream_remove_slave API as well.

It doesnt look correct to take same mutex twice. Will check on this.

> what you probably wanted is to replace sdw_stream_remove_slave() by the
> equivalent sequence
> 
> sdw_slave_port_release()
> sdw_release_slave_stream()
> 
> which are both supposed to be called with a bus_lock held.

you mean to say perform sdw_slave_port_release and
sdw_release_slave_stream in sdw_release_master_stream instead of calling
sdw_stream_remove_slave??

-- 
