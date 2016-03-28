From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 0/7] topology: Add support for vendor tuples
Date: Mon, 28 Mar 2016 16:56:08 +0800
Message-ID: <56F8F1A8.4010604@linux.intel.com>
References: <cover.1458788076.git.mengdong.lin@linux.intel.com>
 <20160324112051.GW2566@sirena.org.uk> <56F4CF07.6080001@linux.intel.com>
 <56F8E210.5000108@linux.intel.com> <s5hshzb6nlp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B00F8260511
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 10:54:00 +0200 (CEST)
In-Reply-To: <s5hshzb6nlp.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, Mark Brown <broonie@kernel.org>, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org



On 03/28/2016 03:57 PM, Takashi Iwai wrote:
> On Mon, 28 Mar 2016 09:49:36 +0200,
> Mengdong Lin wrote:
>>
>> Hi Takashi and Mark,
>>
>> Despite the ABI update, could you help to review if this is a doable
>> solution to define vendor-specific data by tuples?
>
> I'll check it tomorrow, as now it's still in Easter holidays.

Thank you very much!

>
>> Previously there was a patch for Skylake topology conf file, but this
>> file try to import vendor specific config data as a binary blob from
>> other files. The patch was refused for on license of the binary blob and
>> we were suggested to expose the layout of the data. This patch series is
>> to meet this request, providing a way for vendors to define their
>> structured private data.
>>
>> Here is the link of the refused patch:
>> [alsa-devel] [PATCH] conf: topology: Add topolgy for skylake i2s
>> configuration
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104099.html
>
> The changes are good if they are mandatory.  But too late for 4.6, in
> anyway.  And, the missing piece is the "grand plan".  When this
> API/ABI is supposed to be stabilized and released?
>

We're checking topology feature requests for platforms later than 
Skylake. We expect to finish the feature collection this or next week. 
Then we can give a more accurate schedule.

Now the unstable ABI is mainly for ASoC DAI and DAI links. Platforms 
later than Skylake need them. We're checking the gap between existing 
ABI and new requests.

Thanks
Mengdong
