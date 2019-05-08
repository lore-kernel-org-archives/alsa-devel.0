From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: SOF: core: fix undefined nocodec
 reference
Date: Wed, 8 May 2019 11:21:36 -0500
Message-ID: <44be7c35-1b4d-5183-ce4a-1def4126c55f@linux.intel.com>
References: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
 <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
 <20190508062717.GK14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 442DDF8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 18:21:39 +0200 (CEST)
In-Reply-To: <20190508062717.GK14916@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org



On 5/8/19 1:27 AM, Mark Brown wrote:
> On Tue, May 07, 2019 at 11:32:36AM -0500, Pierre-Louis Bossart wrote:
>> The existing code mistakenly uses IS_ENABLED in C code instead of as
>> in conditional compilation, leading to the following error:
> 
>> ld: sound/soc/sof/core.o: in function `sof_machine_check':
>> sound/soc/sof/core.c:279: undefined reference to `sof_nocodec_setup'
> 
> There's nothing wrong with using IS_ENABLED() in C code - it can be
> cleaner than using an ifdef to help the compiler eliminate unneeded
> code.

Agree, and we do make use of it. In this case it wasn't smart though.
