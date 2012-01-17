From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 14:56:47 +0000
Message-ID: <20120117145646.GG2944@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1435B24425
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 15:56:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F15833B.2000808@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 03:18:35PM +0100, Peter Ujfalusi wrote:

> It is mostly true. DAC33 can be configured to operate internally 16bit
> or 24msbit/32bit for example.

Well, if it's doing something more complicated that doesn't fit in the
framework then it shouldn't be doing that.

> It does not give any useful information for application that the codec
> will upsample the 16bit data internally to 24 bits. It does not really
> matter for them since all 16bit data will be used by the codec.

Oh, I dunno - I'm sure someone could think of a use for it.

> > On the CPU side specifying significant bits would normally only be
> > appropriate on PDM interfaces as they have most of a DAC or ADC in them
> > to move between the sampled and PDM formats.  I'd be surprised to see
> > anything else setting these flags, most of the hardware is just passing
> > the data straight through.

> True, the CPU side mostly passes the data as it is, it does not care
> about msbits. For McPDM it is different since the internal FIFO in 24bit
> long word lines, so if application would use all 32bit we it will loose

Right, like I say that's because it's got most of a DAC in it.

> 8bit lsb. This can make difference for PA when applying the digital gain
> in SW.

Well, it saves it a bit of effort but that's about it.
