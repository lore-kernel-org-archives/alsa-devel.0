From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: trace: move to opt-in
 with Kconfig and module parameter
Date: Fri, 14 Jun 2019 12:11:16 +0200
Message-ID: <da825e8e-e960-2a08-3ddb-608b4991d150@linux.intel.com>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
 <20190612164726.26768-2-pierre-louis.bossart@linux.intel.com>
 <20190613184431.GU5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D889BF80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:11:25 +0200 (CEST)
In-Reply-To: <20190613184431.GU5316@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/19 8:44 PM, Mark Brown wrote:
> On Wed, Jun 12, 2019 at 11:47:24AM -0500, Pierre-Louis Bossart wrote:
> 
>> +	    (sof_core_debug & SOF_CORE_ENABLE_TRACE)) {
>> +		sdev->dtrace_is_supported = true;
> 
> Given that dtrace is a widely known product with a Linux implementation
> can we not call this dtrace?  use_dma_trace or something?  A long name
> doesn't seem too bad here but a collision with the more common usage of
> the name isn't great.

Sure, we can rename these fields. I'll send a v3.
