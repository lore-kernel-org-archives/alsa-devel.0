From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH 06/17] soundwire: cadence_master: use
 firmware defaults for frame shape
Date: Wed, 14 Aug 2019 10:01:39 +0530
Message-ID: <20190814043139.GV12733@vkoul-mobl.Dlink>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
 <03b6091b-af41-ac54-43c7-196a3583a731@intel.com>
 <024b4fb4-bdfa-a6dc-48bb-c070f2ed36b2@linux.intel.com>
 <2445b5dc-246c-9c3b-b26e-784032feccf9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2445b5dc-246c-9c3b-b26e-784032feccf9@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Blauciak@vger.kernel.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, Slawomir <slawomir.blauciak@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 06-08-19, 18:06, Cezary Rojewski wrote:
> On 2019-08-06 17:36, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 8/6/19 10:27 AM, Cezary Rojewski wrote:
> > > On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
> > > > diff --git a/drivers/soundwire/cadence_master.c
> > > > b/drivers/soundwire/cadence_master.c
> > > > index 5d9729b4d634..89c55e4bb72c 100644
> > > > --- a/drivers/soundwire/cadence_master.c
> > > > +++ b/drivers/soundwire/cadence_master.c
> > > > @@ -48,6 +48,8 @@
> > > >   #define CDNS_MCP_SSPSTAT            0xC
> > > >   #define CDNS_MCP_FRAME_SHAPE            0x10
> > > >   #define CDNS_MCP_FRAME_SHAPE_INIT        0x14
> > > > +#define CDNS_MCP_FRAME_SHAPE_COL_MASK        GENMASK(2, 0)
> > > > +#define CDNS_MCP_FRAME_SHAPE_ROW_OFFSET        3
> > > >   #define CDNS_MCP_CONFIG_UPDATE            0x18
> > > >   #define CDNS_MCP_CONFIG_UPDATE_BIT        BIT(0)
> > > > @@ -175,7 +177,6 @@
> > > >   /* Driver defaults */
> > > >   #define CDNS_DEFAULT_CLK_DIVIDER        0
> > > > -#define CDNS_DEFAULT_FRAME_SHAPE        0x30
> > > >   #define CDNS_DEFAULT_SSP_INTERVAL        0x18
> > > >   #define CDNS_TX_TIMEOUT                2000
> > > > @@ -901,6 +902,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
> > > >   }
> > > >   EXPORT_SYMBOL(sdw_cdns_pdi_init);
> > > > +static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
> > > > +{
> > > > +    u32 val;
> > > > +    int c;
> > > > +    int r;
> > > > +
> > > > +    r = sdw_find_row_index(n_rows);
> > > > +    c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
> > > > +
> > > > +    val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
> > > > +
> > > > +    return val;
> > > > +}
> > > > +
> > > 
> > > Guess this have been said already, but this function could be
> > > simplified - unless you really want to keep explicit variable
> > > declaration. Both "c" and "r" declarations could be merged into
> > > single line while "val" is not needed at all.
> > > 
> > > One more thing - is AND bitwise op really needed for cols
> > > explicitly? We know all col values upfront - these are static and
> > > declared in global table nearby. Static declaration takes care of
> > > "initial range-check". Is another one necessary?
> > > 
> > > Moreover, this is a _get_ and certainly not a _set_ type of
> > > function. I'd even consider renaming it to: "cdns_get_frame_shape"
> > > as this is neither a _set_ nor an explicit initial frame shape
> > > setter.
> > > 
> > > It might be even helpful to split two usages:
> > > 
> > > #define sdw_frame_shape(col_idx, row_idx) \
> > >      ((row_idx << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | col_idx)
> > > 
> > > u32 cdns_get_frame_shape(u16 rows, u16 cols)
> > > {
> > >      u16 c, r;
> > > 
> > >      r = sdw_find_row_index(rows);
> > >      c = sdw_find_col_index(cols);
> > > 
> > >      return sdw_frame_shape(c, r);
> > > }
> > > 
> > > The above may even be simplified into one-liner.
> > 
> > This is a function used once on startup, there is no real need to
> > simplify further. The separate variables help add debug traces as needed
> > and keep the code readable while showing how the values are encoded into
> > a register.
> 
> Eh, I've thought it's gonna be exposed to userspace (via uapi) so it can be
> fetched by tests or tools.

Uapi? I dont see anything in this or other series posted, did I miss
something? Also I am not sure I like the idea of exposing these to
userland!

> 
> In such case - if there is a single usage only - guess function is fine as
> is.

-- 
~Vinod
