From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/19] ASoC: SOF: improvements for ABI
 checks and Intel code
Date: Mon, 6 May 2019 09:59:24 -0500
Message-ID: <cf4cf0ca-b11d-48ff-8e23-fd2e308ec3af@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
 <20190503054047.GB14916@sirena.org.uk>
 <6ac56436-5ce1-d977-45ef-f305f77bfe01@linux.intel.com>
 <20190506035133.GI14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4BB6F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:59:27 +0200 (CEST)
In-Reply-To: <20190506035133.GI14916@sirena.org.uk>
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

On 5/5/19 10:51 PM, Mark Brown wrote:
> On Fri, May 03, 2019 at 09:47:39AM -0500, Pierre-Louis Bossart wrote:
>> On 5/3/19 12:40 AM, Mark Brown wrote:
> 
>>> reviewer fatigue setting in with this stuff, one thing that'd really
>>> help here is if there were some help from Intel people with review for
>>> the DPCM code.
> 
>> I can certainly understand reviewer fatigue, i've had to put a time limit on
>> daily reviews to keep my sanity, but I don't get your last point. These
>> patches were submitted and reviewed by Intel people on GitHub, what you see
>> here is the result of multiple iterations precisely to make sure the patches
>> are acceptable for upstream. we've set the goal of having two Intel aprovers
>> for each patch. Can you elaborate on how we can make your life simpler?
> 
> The last point there is that Intel only write patches, nobody from Intel
> is reviewing other people's patches especially in areas of the code like
> DPCM which are complex, fragile and where Intel is by far the most
> active user.

It's a valid point, and for now we indeed only check for non-regressions 
and provide point solutions without looking at the bigger picture. We 
have a couple of people ramping up (Ranjani, Libin, Guennadi, Jaska) and 
hopefully at some point we'll be able to review and improve.
