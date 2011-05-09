From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: factor out intel_scu_ipc related
 read/write
Date: Mon, 09 May 2011 08:44:23 +0530
Message-ID: <1304910863.32447.3.camel@vkoul-udesk3>
References: <20110507134318.4225.54478.stgit@localhost>
	<20110507134830.GB13216@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EB4810380A
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 05:46:53 +0200 (CEST)
In-Reply-To: <20110507134830.GB13216@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lu, Guanqun" <guanqun.lu@intel.com>, alan@linux.intel.com
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-05-07 at 19:18 +0530, Lu, Guanqun wrote:
> Hi Mark,
> 
> How do you think of this approach?
> 
> Hi Vinod,
> 
> I don't have the mfld hardware, so it's a not tested patch. I want your
> ack or dis-ack on this. :)
> 
> > +	case SND_SOC_INTEL_SCU:
> > +		if (io_types[i].addr_bits != 16 || io_types[i].data_bits != 8)
> > +			return -EINVAL;
> > +
> > +		codec->hw_read = snd_soc_16_8_intel_scu_read;
> > +		codec->hw_write = snd_soc_16_8_intel_scu_write;
> > +		codec->control_data = codec;
> 
> Another way to do this to simply override codec->read and codec->write
> with the intel_scu_read/write stuff.  But then I realize we may later
> take advantage of soc cache, therefore it's not appropriate to simply
> override these two operations.
Let me test it out...

Meanwhile, i am not sure if this is a good idea.
We can try enabling cache but will it help? Have you tried that on mrst?

The reason for my paranoia is the SCU API, in past it had issues when we
do block writes it, something which syncing the cache can cause.
+ Alan for his comments...


-- 
~Vinod
