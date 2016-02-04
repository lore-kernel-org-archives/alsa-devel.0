From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau17x1: Cache writes when core
	clock is disabled
Date: Thu, 4 Feb 2016 18:24:08 +0100
Message-ID: <56B38938.40000@metafoo.de>
References: <1454594719-17270-1-git-send-email-andire@axis.com>
 <56B388DC.40601@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-189.synserver.de (smtp-out-009.synserver.de
 [212.40.185.9]) by alsa0.perex.cz (Postfix) with ESMTP id D9B762619D0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 18:24:10 +0100 (CET)
In-Reply-To: <56B388DC.40601@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Andreas_Irest=c3=a5l?= <andreas.irestal@axis.com>
Cc: liam.r.girdwood@linux.intel.com, =?UTF-8?Q?Andreas_Irest=c3=a5l?= <andire@axis.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/04/2016 06:22 PM, Lars-Peter Clausen wrote:
[...]
>> +	/* Enable cache only mode as we could miss writes before bias level
>> +	 * reaches standby and the core clock is enabled */
>> +	regcache_cache_only(regmap, true);
>> +
> 
> There are a few register writes before this where the hardware configuration
> is setup. When I look at my test setup those writes seem to go through, even
> though they shouldn't according to what you say (and to what is written in
> the datasheet).
> 
> On the other hand I've never seen the issue you are having either and I've
> tested both master and slave configuration of the device. Maybe something
> changed in the silicon in newer revisions of the device. Can you take a look
> whether the hardware configuration is correctly applied for you?

Ah, no, ignore that. Those writes happen later on.
