From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 07/13] soundwire: Add stream
 configuration APIs
Date: Mon, 23 Apr 2018 09:15:10 +0530
Message-ID: <20180423034510.GA22365@buildpc-HP-Z230>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-8-git-send-email-vinod.koul@intel.com>
 <bca948a4-a668-73d0-5e6d-63287a21a636@linux.intel.com>
 <20180421161315.GO6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EDB02267284
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 05:45:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180421161315.GO6014@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 21, 2018 at 09:43:15PM +0530, Vinod Koul wrote:
> On Sat, Apr 21, 2018 at 06:56:26AM -0700, Pierre-Louis Bossart wrote:
> > 
> > >+static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
> > >+{
> > >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> > >+	struct sdw_bus *bus = m_rt->bus;
> > >+	int ret = 0;
> > >+
> > >+	/* De-prepare port(s) */
> > >+	ret = sdw_prep_deprep_ports(m_rt, false);
> > >+	if (ret < 0) {
> > >+		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
> > >+		return ret;
> > >+	}
> > >+
> > >+	bus->params.bandwidth -= m_rt->stream->params.rate *
> > >+		m_rt->ch_count * m_rt->stream->params.bps;
> > 
> > And same here, the ch_count can be zero.
> 
> Same as above..
> 
> > 
> > >+
> > >+	if (!bus->params.bandwidth) {
> > >+		bus->params.row = 0;
> > >+		bus->params.col = 0;
> > >+		goto exit;
> > 
> > What is the intent with this test+goto? Shouldn't you program the parameters
> > if you want to change the frame shape?
> 
> hmmm that seems correct point to me, but then we are going idle and should
> ideally power down. Let me check again if that is the reason.
>

We do not want to program parameters or change frame shape in case of bandwidth
required is 0 on bus (ie. no stream running). The row and col values are reset
to 0 and will be re-computed again in prepare_stream of next stream based
on stream requirement.

> > 
> > >+	}
> > >+
> > >+	/* Program params */
> > >+	ret = sdw_program_params(bus);
> > >+	if (ret < 0) {
> > >+		dev_err(bus->dev, "Program params failed: %d", ret);
> > >+		return ret;
> > >+	}
> > >+
> > >+	return do_bank_switch(stream);
> > >+
> > >+exit:
> > >+	stream->state = SDW_STREAM_DEPREPARED;
> > >+
> > >+	return ret;
> > >+}
> 
> -- 
> ~Vinod

-- 
