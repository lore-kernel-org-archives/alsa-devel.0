From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] soundwire: bus: check if pm runtime is
 enabled before calling
Date: Fri, 29 Mar 2019 10:02:47 +0000
Message-ID: <80c6fb6d-a3b8-3272-e880-94d971623a06@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-4-srinivas.kandagatla@linaro.org>
 <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
 <5f4ef5ca-b90f-4e25-f006-78983fd2bcfc@linaro.org>
 <20190329055828.GK5348@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 264A7F80C16
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 11:02:49 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id y13so1841419wrd.3
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 03:02:49 -0700 (PDT)
In-Reply-To: <20190329055828.GK5348@vkoul-mobl>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: sanyog.r.kale@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 29/03/2019 05:58, Vinod Koul wrote:
>> There are lots of users in kernel with such sequences, ex:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm-smmu.c?h=v5.1-rc2#n279
> Sorry not a fan of this:)  I think PM core should do this :D
> 
Yes, I would prefer that too, There might be a reason why its not done 
in the pm core, I will catchup with Ulf next week and see if we can add 
checks to return -ENOSUPPORT  or something more sensible error code to 
users.


Thanks,
srini
> I guess you are trying to solve the case where PM can be disabled for a
> device and pm_runtime_get_sync() returns error right?
> 
> That would be quite a common sequence in most frameworks..
> 
> Thanks
> 
> 
