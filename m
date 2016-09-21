From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 01/11] ASoC: topology: Able to create BE
 DAIs
Date: Wed, 21 Sep 2016 13:44:11 +0800
Message-ID: <57E21E2B.8020502@linux.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
 <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
 <20160916145651.GD27974@sirena.org.uk>
 <17DC8B7179E3514D90E3A456B23B91EA1A0B0F50@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 165C1266EC5
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 07:37:44 +0200 (CEST)
In-Reply-To: <17DC8B7179E3514D90E3A456B23B91EA1A0B0F50@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Shah, Hardik T" <hardik.t.shah@intel.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for your comments, Hardik! So we'll no longer let topology to 
create BE DAIs.

And how about the BE DAI links?
They are also physical hardware things. Could we also let topology 
configure those that can be changed by SW on the BE link, instead of 
letting topology create the BE links?

Thanks
Mengdong

On 09/20/2016 01:09 AM, Shah, Hardik T wrote:
>
>
> Regards,
> Hardik Shah
>
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>>
>> On Fri, Sep 09, 2016 at 07:43:11PM +0800, mengdong.lin@linux.intel.com
>> wrote:
>>
>>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>>> Topology will check with ASoC if a BE DAI already exists by checking
>>> its name. If the BE DAI doesn't exist, topology will create a new one
>>> and the dai_load ops will be called for device specific init.
>>
>> I still remain fundamentally unconvinced that this is a good or scalable idea
>> and that it makes sense to have it be part of the standard topology ABI.  We
>> are not going to download a DSP firmware that creates a new physical link in
>> the system so having the topology be the thing creating those physical links
>> seems wrong.
>>
>
> Hi Mark,
> You are right, physical links will always remain same.
>
>
>>> create the HDA DAIs. Ideally, the driver should query BIOS to get the
>>> physical pin output types and connections to peripherals for a
>>> specific platform, but unfortunately BIOS sometimes does not have
>>> accurate info, so there is still hard code of BE DAI & DAI links in
>>> driver. To share a
>>
>> Having the connections to the DSP specified in the toplogy is of course
>> sensible but fundamentally this is always going to be choosing from a list of
>> physical DAIs that we already know about and potential connections for
>> those that are also already known.  If the driver wants to do something in
>> response to a DAI being hooked up into the topology (which seems to be the
>> actual goal here) that would be sensible but attempting to create physical
>> hardware in a topology does not seem like a good idea as a generic feature.
>
>
> We were trying to optimize here by creating DAIs for only those physical
> links which are getting used on the platform. Intel hardware supports
> multiple physical links like I2S, HDA, HDMI and DMICs and with that BE DAIs
> can increase up to 15-20,  and very few of them may be really used in most
> of the platforms. But if you think we should create BE DAIs for all physical
> links, we will go ahead with that approach.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
