From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 13:19:50 +0000
Message-ID: <20120117131950.GF2944@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C38732438F
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:19:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F157264.5020102@ti.com>
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

On Tue, Jan 17, 2012 at 02:06:44PM +0100, Peter Ujfalusi wrote:

> I can only speak in behalf of OMAP, twl4030, tlv320dac33 here, but the
> 24msbit only applies to 32bit samples. In case of 16 bit the samples are
> not converted in any way, they are processed as 16 bit data.
> So if we say 24msbit for 16bit sample we are not correct. It is correct
> for 32bit sample.
> I would think most of the codecs/cpus are working in a same way.

For the CODECs if you look at what they're doing you'll probably find
that the device is actually operating at a fixed sample size internally
and converting the data somehow at the interface (zero extension being
one option when converting up, but more fancy approaches are also
possible).  This is fairly obvious when you think about how things are
likely to be implemented in hardware, it's going to increase complexity
a lot to be able to genuinely switch the entire chip from one sample
size to another.

On the CPU side specifying significant bits would normally only be
appropriate on PDM interfaces as they have most of a DAC or ADC in them
to move between the sampled and PDM formats.  I'd be surprised to see
anything else setting these flags, most of the hardware is just passing
the data straight through.
