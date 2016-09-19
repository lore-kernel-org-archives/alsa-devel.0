From: "Shah, Hardik T" <hardik.t.shah@intel.com>
Subject: Re: [PATCH v2 01/11] ASoC: topology: Able to create BE
	DAIs
Date: Mon, 19 Sep 2016 17:09:19 +0000
Message-ID: <17DC8B7179E3514D90E3A456B23B91EA1A0B0F50@BGSMSX104.gar.corp.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
 <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
 <20160916145651.GD27974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ED143264ED4
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 19:09:29 +0200 (CEST)
In-Reply-To: <20160916145651.GD27974@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org



Regards,
Hardik Shah 

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> 
> On Fri, Sep 09, 2016 at 07:43:11PM +0800, mengdong.lin@linux.intel.com
> wrote:
> 
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> > Topology will check with ASoC if a BE DAI already exists by checking
> > its name. If the BE DAI doesn't exist, topology will create a new one
> > and the dai_load ops will be called for device specific init.
> 
> I still remain fundamentally unconvinced that this is a good or scalable idea
> and that it makes sense to have it be part of the standard topology ABI.  We
> are not going to download a DSP firmware that creates a new physical link in
> the system so having the topology be the thing creating those physical links
> seems wrong.
>

Hi Mark,
You are right, physical links will always remain same.

 
> > create the HDA DAIs. Ideally, the driver should query BIOS to get the
> > physical pin output types and connections to peripherals for a
> > specific platform, but unfortunately BIOS sometimes does not have
> > accurate info, so there is still hard code of BE DAI & DAI links in
> > driver. To share a
> 
> Having the connections to the DSP specified in the toplogy is of course
> sensible but fundamentally this is always going to be choosing from a list of
> physical DAIs that we already know about and potential connections for
> those that are also already known.  If the driver wants to do something in
> response to a DAI being hooked up into the topology (which seems to be the
> actual goal here) that would be sensible but attempting to create physical
> hardware in a topology does not seem like a good idea as a generic feature.


We were trying to optimize here by creating DAIs for only those physical
links which are getting used on the platform. Intel hardware supports
multiple physical links like I2S, HDA, HDMI and DMICs and with that BE DAIs
can increase up to 15-20,  and very few of them may be really used in most
of the platforms. But if you think we should create BE DAIs for all physical
links, we will go ahead with that approach.
