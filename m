From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v4 3/8] ASoC: Intel: Boards: Machine driver
 for SKL+ w/ HDAudio codecs
Date: Wed, 25 Jul 2018 21:52:08 +0530
Message-ID: <20180725162208.GW3661@vkoul-mobl>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-4-pierre-louis.bossart@linux.intel.com>
 <20180725111145.GM3661@vkoul-mobl>
 <c9577eef-3b32-e1b9-17e2-0bedce8109c8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 544FF26774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:22:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c9577eef-3b32-e1b9-17e2-0bedce8109c8@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-18, 09:10, Pierre-Louis Bossart wrote:
> On 7/25/18 6:11 AM, Vinod wrote:

> > > +		.dpcm_playback = 1,
> > > +		.no_pcm = 1,
> > > +	},
> > > +	{
> > > +		.name = "iDisp2",
> > > +		.id = 2,
> > > +		.cpu_dai_name = "iDisp2 Pin",
> > > +		.codec_name = "ehdaudio0D2",
> > > +		.codec_dai_name = "intel-hdmi-hifi2",
> > > +		.platform_name = "0000:00:1f.3",
> > > +		.dpcm_playback = 1,
> > > +		.no_pcm = 1,
> > > +	},
> > > +	{
> > > +		.name = "iDisp3",
> > > +		.id = 3,
> > 
> > shouldn't this be queried. not all will have 3 links
> 
> Not that I know of. I've always seen SKL+ with 3 audio streams to iDisp.

IIRC later ones (after KBL) have 5 CVTs and 4 pins (or vice-versa)

> > > +static struct platform_driver skl_hda_audio = {
> > > +	.probe = skl_hda_audio_probe,
> > > +	.driver = {
> > > +		.name = "skl_hda_dsp_generic",
> > 
> > who creates this pdev, is it the board details (mach name?)
> 
> Not sure I understand your question, this part is similar to all other Intel
> machine drivers and the way by with the probe happens is also similar. There
> is nothing new here, the skylake platform driver finds an entry in a table,
> gets the driver name and creates the relevant device.

Okay sounds good. I was curious if the generic machine device is created
generically or use the tables..

-- 
~Vinod
