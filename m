From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 0/2] topology: Support widgets' stream name
 and file inclusion for text conf file
Date: Thu, 20 Oct 2016 14:01:42 +0800
Message-ID: <58085DC6.9090107@linux.intel.com>
References: <cover.1476683054.git.mengdong.lin@linux.intel.com>
 <s5hbmyj6syh.wl-tiwai@suse.de> <20161019034507.GI2467@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E1260266218
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 08:00:37 +0200 (CEST)
In-Reply-To: <20161019034507.GI2467@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 10/19/2016 11:45 AM, Vinod Koul wrote:
> On Mon, Oct 17, 2016 at 02:49:42PM +0200, Takashi Iwai wrote:
>> On Mon, 17 Oct 2016 07:55:21 +0200,
>> mengdong.lin@linux.intel.com wrote:
>>>
>>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>
>>> This series doesn't require or cause any ABI updates. It doesn't need the
>>> kernel patches that trying to udpate ABI from v4 or v5.
>>>
>>> It just fix a missing feature and enhance text conf file to support
>>> including files to control the increasing size of text conf files.
>>
>> The inclusion of a file can be done in alsaconf syntax via <xxx>,
>> too.  We may extend it if needed instead?
>
> Ah that's interesting... Am fine either way.

That saves a lot of code as well :-)

I sent out the v2 series which extends alsaconf and now topology does 
not need any code change. Please review.

Thanks
Mengdong

>
>> The patches themselves look OK, so I'm not strongly against merging
>> them, but just to make sure our standpoint.
>
> The last SKL conf became a bit bigger, so for readability we though we can
> have different files, one for module instances, one for tuples and then
> finally one including these two which has the graph..
>
