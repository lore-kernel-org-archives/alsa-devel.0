From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: Change the PCM runtime array
	to a list
Date: Thu, 19 Nov 2015 04:30:56 -0500
Message-ID: <564D96D0.3030305@linux.intel.com>
References: <cover.1446692512.git.mengdong.lin@linux.intel.com>
 <20151118183021.GK31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A9A2614E2
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 10:15:07 +0100 (CET)
In-Reply-To: <20151118183021.GK31303@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On 11/18/2015 01:30 PM, Mark Brown wrote:
> On Wed, Nov 18, 2015 at 02:31:26AM -0500, mengdong.lin@linux.intel.com wrote:
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> The 2 patches are a preparation to allow the topology core to create
>> PCM devices dynamically. Probing a component may load its topology and
>> come up with new DAI links and thus new runtimes. So implementing the
>> PCM runtimes in a list makes it easier to add new runtimes.
>
> I've got two apparently identical copies of this series that have
> threaded together into one thread.  I'm going to look at what looks like
> the newer copy but I might get it wrong, please check.
>

Hi Mark,

Thanks for your review!

These two series are exactly same. Since the 1st one has no feedback for 
~2 weeks, I thought it may be buried by the mail flood and so sent again 
yesterday.

I'll send the following patches.

Regards
Mengdong
