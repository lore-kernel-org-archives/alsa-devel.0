From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 05/10] ASoC: Add support for dummy DAI
 links and PCM runtimes
Date: Mon, 17 Aug 2015 10:01:16 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D114C@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <0364569ce2898a20d08243ba59a92973b2dc4735.1439217448.git.mengdong.lin@intel.com>
 <20150814202210.GQ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EEB6260451
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 12:01:29 +0200 (CEST)
In-Reply-To: <20150814202210.GQ10748@sirena.org.uk>
Content-Language: en-US
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, August 15, 2015 4:22 AM

> On Mon, Aug 10, 2015 at 10:47:47PM +0800, mengdong.lin@intel.com wrote:
> 
> > Add dummy flag to a DAI link and PCM runtime. A dummy link will create
> > a dummy PCM runtime.
> 
> > A machine driver can define dummy dai links to specify the expected
> > platform and codec. And its dummy runtime is used to probe the
> > platform and codec components, which can bring real DAI/DAI links based
> on topology.
> > After components probing, all dummy PCM runtimes will be removed.
> 
> This isn't very clear to me either in terms of the description or the interface.
> As far as I can tell these links that are being created here are placeholders
> representing links that will actually be instantiated later but if that's the case
> they're not really dummies as I'd understand them, they are real links which
> physically exist and will be created later by topology data.  If we are going to
> do things this way we need a better way of talking about these not yet
> instantiated links.

(Sorry. I'm still trying to enable my 2nd mail account & client. So this reply can still have format problems.)

These *dummy* links are not place holders of real physical links. 
So they cannot come from ACPI but from topology.

Here is an example used in my test on Broadwell:

/* broadwell digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broadwell_rt286_dais[] = {
	/* Front End dummy DAI links */
 	{
		.name = "Dummy System PCM",
		.stream_name = "Dummy System Playback/Capture",
		.cpu_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
	}
	...
All real FE DAI links will no longer be in this link array.

We use this dummy DAI link to avoid snd_soc_instantiate_card() fail on binding DAI links.
 
And since this dummy link specify the platform "haswell-pcm-audio",
soc_bind_dai_link() will promise the platform component is there.
And then platform probing will load topology and the topology core will create the real FE DAIs.

And the machine driver will get notified when a new FE DAI is added to the ASoC core. It can create FE links in the callback context according to the new FE DAI info.

This seems to give us small code change.

Thanks
Mengdong

> I'm really confused as to why physical links that exist in the board are coming
> in via topology information loaded from userspace - it's not like the DSP
> firmware is going to be able to physically connect the DSP to things where no
> links existed before.  I'd expect that these links are connections between
> physical devices which just exist in the system and that while the topology
> information might leave some of them dangling they wouldn't be created or
> removed.
> 
> Presumably we're also going to need to handle the case where the firmware
> is unloaded and we destroy the links if we do this...

Yes. The DAI/DAI links created by topology should be destroyed when unloading the topology component.

Now there is no product request to unload/change the firmware as well as its topology in the middle. 
We may consider this later.

Thanks
Mengdong
