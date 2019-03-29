From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/4] soundwire: cdns: fix check for number
	of messages
Date: Fri, 29 Mar 2019 10:06:32 +0000
Message-ID: <0e99ce6b-af40-df7b-9548-0055261c6440@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
 <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
 <28b05dc7-f269-0091-53ab-4390f613fc09@linaro.org>
 <20190329055446.GJ5348@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 159BDF8071D
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 11:06:34 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id z24so2084471wmi.5
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 03:06:34 -0700 (PDT)
In-Reply-To: <20190329055446.GJ5348@vkoul-mobl>
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
Cc: sanyog.r.kale@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 29/03/2019 05:54, Vinod Koul wrote:
>>> is that the defer structure is actually modified below this code (not
>>> shown in the diff) to set defer>length = msg->len, so testing before the
>>> value is set looks more suspicious than the current code.
>> removing the length field in defer should get rid of such instances.
> Right!
I will go ahead and post the cleanup patch to get rid of 
confusing/redundant length field in defer.

Thanks,
srini
