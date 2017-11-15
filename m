From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: mfld: allow mfld machine to
 be build
Date: Wed, 15 Nov 2017 10:20:51 -0600
Message-ID: <aff81d5e-4894-67d5-b044-342dea4871fe@linux.intel.com>
References: <1510743172-18829-1-git-send-email-vinod.koul@intel.com>
 <2fc42908-631d-364f-c531-c05f077eceb4@linux.intel.com>
 <20171115152534.GJ3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F9022676E5
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 14:58:11 +0100 (CET)
In-Reply-To: <20171115152534.GJ3187@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 11/15/17 9:25 AM, Vinod Koul wrote:
> On Wed, Nov 15, 2017 at 08:41:18AM -0600, Pierre-Louis Bossart wrote:
>> On 11/15/17 4:52 AM, Vinod Koul wrote:
>>> Commit b97169da0699: ("ASoC: Intel: create atom folder and move atom
>>> platform files in") missed adding Kconfig and Makefile support for
>>> MFLD machine driver, so add it while alos fixing the relative patch to
>>> codec header
>>
>> Does anyone test this code? I don't think anyone on the Intel side has a
>> working platform any longer...
> 
> That is good question, we had boards for these but not sure if this is
> needed. This was not compiling and noone noticed, so I dont mind removing
> these bits.
> 
> Any objections..

I saw those configs were not used and I thought it was deprecated on 
purpose...
