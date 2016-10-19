From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 0/2] topology: Support widgets' stream name
 and file inclusion for text conf file
Date: Wed, 19 Oct 2016 12:06:28 +0800
Message-ID: <5806F144.7060108@linux.intel.com>
References: <cover.1476683054.git.mengdong.lin@linux.intel.com>
 <s5hbmyj6syh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FEAC2659AA
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 06:05:25 +0200 (CEST)
In-Reply-To: <s5hbmyj6syh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 10/17/2016 08:49 PM, Takashi Iwai wrote:
> On Mon, 17 Oct 2016 07:55:21 +0200,
> mengdong.lin@linux.intel.com wrote:
>>
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> This series doesn't require or cause any ABI updates. It doesn't need the
>> kernel patches that trying to udpate ABI from v4 or v5.
>>
>> It just fix a missing feature and enhance text conf file to support
>> including files to control the increasing size of text conf files.
>
> The inclusion of a file can be done in alsaconf syntax via <xxx>,
> too.  We may extend it if needed instead?


Thanks for your review and advice!

It seems etter to extend and reuse alsaconf syntax, instead of adding 
topology specific code. This can also benefit UCM if users want to split 
common codec or SOC settings to other files.

alsaconf already support using absolute path to include a file. But it 
seems we cannot give a relative path (e.g. just a file name) and a 
configuration directory by <confdir:xxx>. I'll try to extend alsaconf.

The other patch is a bug fixing, if it's okay, could it be merged first?

Thanks
Mengdong

>
> The patches themselves look OK, so I'm not strongly against merging
> them, but just to make sure our standpoint.
>
>
> thanks,
>
> Takashi
>
>>
>> Mengdong Lin (2):
>>    topology: Fix missing stream name of widgets in text conf file
>>    topology: Add support for included files
>>
>>   include/topology.h        |  38 +++++
>>   src/topology/dapm.c       |  10 ++
>>   src/topology/parser.c     | 374 +++++++++++++++++++++++++++++++++++++++++++++-
>>   src/topology/tplg_local.h |  17 +++
>>   4 files changed, 434 insertions(+), 5 deletions(-)
>>
>> --
>> 2.5.0
>>
>
