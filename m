From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 1/5] topology: ABI - Add the types for BE
	DAI
Date: Sat, 8 Oct 2016 16:00:50 +0800
Message-ID: <57F8A7B2.2010203@linux.intel.com>
References: <cover.1475505267.git.mengdong.lin@linux.intel.com>
 <943bbdf62e4d0d3f297fa59b9804236c82778185.1475505267.git.mengdong.lin@linux.intel.com>
 <20161006143731.53vyuwhyyca3vdbm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 88926265654
 for <alsa-devel@alsa-project.org>; Sat,  8 Oct 2016 10:00:03 +0200 (CEST)
In-Reply-To: <20161006143731.53vyuwhyyca3vdbm@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 10/06/2016 10:37 PM, Mark Brown wrote:
> On Mon, Oct 03, 2016 at 11:03:50PM +0800, mengdong.lin@linux.intel.com wrote:
>
>> Pump the version number to 5.
>
> So, we just had a user on IRC complaining that the last round of
> incompatible changes in v4.7 broke their laptop audio - they had a
> laptop that shipped with Linux and suddenly the topology file didn't
> work.  I think that's an indication that at this point we have an ABI we
> need to maintain compatibility with rather than just break things.  That
> doesn't explicitly affect this patch but does mean that the parsing code
> ought to cope which is likely to have some impact here.
>
>> Topology kernel driver will check size of ABI objects to detect version
>> mismatch between user space and kernel.
>
> The ABI wasn't explicitly reved which suggests that it's this that
> triggered the issue for the user.

Yes. Now if the kernel finds a mismatch of ABI object size, it will just 
return error and so old version of topology files cannot work. We'll try 
to support ABI version 4 and new versions in kernel. It seems topology 
have real users from version 4.

>
>> +/* BE DAI flags */
>> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES         (1 << 0)
>> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
>> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
>
> These don't seem specific to back ends, people can use topologies for
> DSPs on off-SoC devices which might also want to use these.

Yes. Can we take them as generic flags for DAI and DAI links?

>
>> +	__le32 be_dai_elems;	/* number of BE DAI elements */
>> +	__le32 reserved[20];	/* reserved for new ABI element types */
>
> Thinking about the above I'm wondering if it doesn't make more sense to
> call these physical links rather than back ends - that term is going to
> be clearer to people who don't use DPCM.
>

May we call it a "phy_dai_elems", to indicate physical DAIs?

Now the ABI struct "snd_soc_tplg_be_dai" is already in kernel but no 
real users in user space. Can we rename it? Or add a new ABI struct?

Thanks
Mengdong
