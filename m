From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Tue, 30 Apr 2019 14:27:05 +0530
Message-ID: <20190430085705.GT3845@vkoul-mobl.Dlink>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 19-04-19, 12:14, Pierre-Louis Bossart wrote:
> 
> > > >   enum sdw_command_response
> > > >   cdns_xfer_msg_defer(struct sdw_bus *bus,
> > > > -        struct sdw_msg *msg, struct sdw_defer *defer)
> > > > +            struct sdw_msg *msg, struct sdw_defer *defer)
> > > 
> > > this one too..
> > > 
> > > >   static int cdns_port_params(struct sdw_bus *bus,
> > > > -        struct sdw_port_params *p_params, unsigned int bank)
> > > > +                struct sdw_port_params *p_params, unsigned int bank)
> > > 
> > > here as well.. (and giving up on rest)
> > 
> > Please check for yourself that this is a diff illusion w/ tab space.
> 
> Vinod, can you please double-check, the alignment issues you reported don't
> exist, see e.g. below what the code looks like after merge.
> 
> 
> int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
>                        struct sdw_defer *defer)
> 
> int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>                  u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)

Sure, please split up as requested and I shall test apply and check
alignment before reporting...

-- 
~Vinod
