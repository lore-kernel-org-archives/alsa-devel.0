From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 01/13] ASoC: topology: Able to create BE
	DAIs
Date: Thu, 25 Aug 2016 14:40:34 +0800
Message-ID: <57BE92E2.7030807@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823173354.GZ22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1BC26669D
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 08:36:31 +0200 (CEST)
In-Reply-To: <20160823173354.GZ22076@sirena.org.uk>
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



On 08/24/2016 01:33 AM, Mark Brown wrote:
> On Fri, Aug 19, 2016 at 06:12:35PM +0800, mengdong.lin@linux.intel.com wrote:
>
>> Topology will check with ASoC if a BE DAI already exists by checking
>> its name. If the BE DAI doesn't exist, topology will create a new one
>> and the dai_load ops will be called for device specific init.
>
> This doesn't explain in what situation we'd want to dynamically create a
> back end, or why we're representing DPCM so directly in the topology -
> we really need more words about what the use case is and why this makes
> sense.  The expectation would be that back ends refer to physical
> objects that exist in the system so it's not clear why we'd be loading
> them from topologies (and that even where this makes sense there
> wouldn't be any misuse by other users).  This is a bit of a theme here,
> the series is adding a bunch of stuff but not explaining why.
>

Thanks for the review! Sorry for not giving enough background info.

In previous design, we had thought that BE DAI and BE DAI links should 
be created based on ACPI info in BIOS. But unfortunately, the BIOS 
doesn't have enough physical information, so BE DAI & DAI links are hard 
coded in platform and machine driver. But when new platforms are coming 
out with different physical connections, this BIOS gap blocks us from 
sharing a generic driver across platforms. Now the gap in BIOS ACPI info 
still exists, the implementations also vary for different generations of 
platforms, BIOS for public shipped machines cannot change ... So finally 
we fall back to topology to overcome the BIOS gap and make driver 
sharing possible. We have tried creating BE DAI & DAI links to new 
platforms and plan to back port this to upstream drivers for existing 
platforms like SKL.

I'll add this to the commit messages of next version.

Thanks
Mengdong
