From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 04/12] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Tue, 04 Sep 2018 14:15:50 +0100
Message-ID: <c8e92ab38c6f8bbe719344a92db8ed21ad30251e.camel@linux.intel.com>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-5-liam.r.girdwood@linux.intel.com>
 <20180903155300.GQ10302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DEBD72678DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 15:15:54 +0200 (CEST)
In-Reply-To: <20180903155300.GQ10302@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-09-03 at 16:53 +0100, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 04:19:02PM +0100, Liam Girdwood wrote:
> 
> > +/* SSP Configuration Request - SOF_IPC_DAI_SSP_CONFIG */
> > +struct sof_ipc_dai_ssp_params {
> > +	/* MCLK */
> > +	uint32_t mclk_direction;
> > +	uint32_t mclk_keep_active;
> > +	uint32_t bclk_keep_active;
> > +	uint32_t fs_keep_active;
> 
> Is this assuming a 1:1 relationship between the serial port and the
> MCLK?  

Yes just for SSP atm.

> That's not going to be true for all systems.  This definition
> does feel a bit specific to the SSP (or I guess just general serial
> ports used for audio as opposed to fixed function I2S/PCM controllers).
> I don't know if it's worth splitting up though.
> 

Yeah, that's the intention is that we have a different structure for each DAI IP
type. We currently have :-

struct sof_ipc_dai_config {
	struct sof_ipc_hdr hdr;
	enum sof_ipc_dai_type type;

	...

	union {
		struct dai_type_X;
		struct dai_type_Y;
	};
};

So we can add future DAI IPs as part of this union alongside a new type ID.

> > +	uint16_t frame_pulse_width;
> > +	uint32_t quirks; // FIXME: is 32 bits enough ?
> 
> Better go for 640K to be sure :) ...

Yep, you never know :)

> 
> > +/* HDA Configuration Request - SOF_IPC_DAI_HDA_CONFIG */
> > +struct sof_ipc_dai_hda_params {
> > +	struct sof_ipc_hdr hdr;
> > +	/* TODO */
> > +} __attribute__((packed));
> 
> ...more seriously I do notice a bunch of these FIXME and TODO comments
> in here, given that it's an ABI it seems like those all need sorting
> before things are merged.  In this case perhaps just delete the HDA
> stuff until someone works out what to do?

Will do. 

Liam
