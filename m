From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 0/7] topology: Add support for vendor tuples
Date: Fri, 25 Mar 2016 13:39:19 +0800
Message-ID: <56F4CF07.6080001@linux.intel.com>
References: <cover.1458788076.git.mengdong.lin@linux.intel.com>
 <20160324112051.GW2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EF096260682
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 06:37:34 +0100 (CET)
In-Reply-To: <20160324112051.GW2566@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


On 03/24/2016 07:20 PM, Mark Brown wrote:
> On Thu, Mar 24, 2016 at 11:05:29AM +0800, mengdong.lin@linux.intel.com wrote:
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> This series addes support for vendor tuples to topology, to avoid
>> importing binary data blob from other files.
>>
>> Backward compatibility of ABI is not impacted. A kernel patch is also
>> submitted "ASoC: topology: ABI - Define types for vendor tuples".
>
> It's now been three kernel releases since the original code was merged
> and we've still not seen any effort to make the ABI actually available.
> Where are we with that?  I've mentioned it a few times previously but
> don't really recall any response.
>

We've been working on this. I'm sorry we're still not fast enough.

This ABI update is introduced by previous failure to upstream the 
topology configuration file for Skylake, which imports vendor-specific 
binary data from another file. It was refused because of the license of 
the binary data is not obvious. So we turn to use vendor tuples, because 
the vendor tuples can show the layout and meaning of binary data, which 
can help to check if the data is safe to open source.
This ABI change has no impact on backward compatibility.

Also, the audio device driver for new platforms are under development 
now, which uses topology for DAI and DAI links. We're checking if 
current ABI can meet all requirements for the new platforms. This may 
still need a few weeks.

Thanks
Mengdong
