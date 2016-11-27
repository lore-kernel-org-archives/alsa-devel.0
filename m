From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Sun, 27 Nov 2016 11:52:11 -0600
Message-ID: <106771ee-bc16-377a-c1c0-8499c554c165@linux.intel.com>
References: <1479301675.18450.18.camel@rf-debian.wolfsonmicro.main>
 <20161116134835.GW1575@localhost.localdomain>
 <1479308001.18450.25.camel@rf-debian.wolfsonmicro.main>
 <20161118035333.GG2698@localhost>
 <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
 <20161118102903.GS2698@localhost>
 <fe7dcb27-fda9-47bc-7766-2896e1954218@linux.intel.com>
 <20161118161737.GB1575@localhost.localdomain>
 <20161123034103.GZ2698@localhost>
 <1479896518.4317.7.camel@rf-debian.wolfsonmicro.main>
 <20161123103820.GI2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BA93B2657A6
 for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2016 18:52:14 +0100 (CET)
In-Reply-To: <20161123103820.GI2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> I am not Ok to add support for any other format apart from bespoke (file
> dump) and PCM wav header and save to file.
>
> I am okay to add support to dump data to stdio for any format, so that we
> dont bother to support those file formats.

it's not clear to me why you would make an exception for bespoke, just 
dump everything to stdio and use a file indirection if you want the raw 
data in all cases?

>
> Is this clear enough, does that work for you folks?
>
>>
>> The alternative is that Cirrus maintains its own branched version of
>> tinycompress with useful tools but that doesn't seem like a sensible
>> road to go down either.
>
> Agreed
>
