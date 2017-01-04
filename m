From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 4/4] ASoC: Intel: rename
 SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM
Date: Wed, 4 Jan 2017 10:58:50 -0600
Message-ID: <ea7d96dd-380d-9a73-73de-1d754af17240@linux.intel.com>
References: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
 <20170102152017.13938-5-andriy.shevchenko@linux.intel.com>
 <c5228e73-d5cf-e4cd-b78b-24334e1fb5f3@linux.intel.com>
 <20170103033815.GA3573@localhost>
 <b5c5956c-3bd8-4a28-a456-babc5fd06846@linux.intel.com>
 <1483526660.9552.221.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E8AE267098
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 17:58:52 +0100 (CET)
In-Reply-To: <1483526660.9552.221.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 1/4/17 4:44 AM, Andy Shevchenko wrote:
> On Tue, 2017-01-03 at 08:18 -0600, Pierre-Louis Bossart wrote:
>>>> On 01/02/2017 09:20 AM, Andy Shevchenko wrote:
>>>>> Rename SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM to make it
>>>>> clear that is
>>>>> not only about Medfield platform.
>>>>
>>>> Does this change make sense? Medfield was a completely different
>>>> platform and lumping everything under the same Kconfig option
>>>> doesn't seem right to me... Plus we've stopped using 'mid' for
>>>> years, no one would know what it stands for. The only clear
>>>> architecture feature is the presence of the switch matrix that
>>>> uniquely identifies all platforms based on Baytrail, Cherrytrail,
>>>> Merrifield and Anniedale. Medfield/Clovertrail did not expose a
>>>> switch matrix.
>>>
>>> Mea culpa..
>>>
>>> So we started this with medfield and the driver construction is
>>> pretty much
>>> the same untill skylake. So clubbing under mfld bucket made sense to
>>> me.
>>>
>>> MID is not flavour of the season now.
>
> Would be, though it covers at least few out of them, MFLD just refers to
> one.
>
>>>
>>> If anyone comes with a better name, am for that :)
>
> _ATOM ? Sounds too broad...
>
>>
>> SND_SST_HIFI2_MOBILE_PLATFORM ?
>
> Where HIFI2 part came from? Any documentation (maybe internal) available
> to look at? (Because it's not obvious to me how all listed above has
> something in common)
>
> And I would get rid of _MOBILE part.

SND_SST_ATOM_HIFI2_PLATFORM then

HIFI2 is the DSP version, it's public information for those Field/Trail 
parts, see https://www.alsa-project.org/main/index.php/Firmware
If you combine HIFI2 with ATOM you have a unique non-ambiguous 
description of the core+DSP hardware for Medfield through Cherrytrail.
