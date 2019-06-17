From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
 detect CPUs
Date: Mon, 17 Jun 2019 17:31:53 +0200
Message-ID: <29ad7270-9aa4-a002-0f0e-21b7a61fe8a4@linux.intel.com>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
 <20190617144727.GR5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD650F896C7
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:31:54 +0200 (CEST)
In-Reply-To: <20190617144727.GR5316@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 6/17/19 4:47 PM, Mark Brown wrote:
> On Tue, May 28, 2019 at 03:02:55PM -0500, Pierre-Louis Bossart wrote:
> 
>> 2. is there a better way to do this for all Intel chips or do we keep
>> this in sound/? Andy?
> 
> ARM has platform detection stuff in the architecture code, something
> similar seems sensible for x86?

Well yes, we already have x86_match_cpu() but that won't work with 
COMPILE_TEST (asm/ headers don't exist) and this leads to duplication of 
code. All we really need here is a yeah/nay answer from a help that 
hides those details away.
