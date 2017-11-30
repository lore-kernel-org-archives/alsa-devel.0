From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
Date: Thu, 30 Nov 2017 08:53:15 -0600
Message-ID: <f28b63e9-2e1d-f4ce-3ce1-fba6527d8a2d@linux.intel.com>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
 <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
 <20171130040204.GK32417@localhost>
 <20171130061443.GA31069@nm-B85M-D3Hnaveen.m@intel.com>
 <20171130111511.up2f2te5mc3orkit@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1315526698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 15:53:18 +0100 (CET)
In-Reply-To: <20171130111511.up2f2te5mc3orkit@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On 11/30/17 5:15 AM, Mark Brown wrote:
> On Thu, Nov 30, 2017 at 11:44:43AM +0530, Naveen M wrote:
> 
>> Regarding the Query:
>> As Vinod mentioned, I'm working on Chrome OS user-space stack that uses
>> customized audio server "CRAS".
>> These patches are verified on a board that has only 2 dmics.
>>
>> Giving the control to CRAS, enables to select the desired dmic using
>> channel-map configuration in user-space.
>> Ex:Rear/Front mic selection for World & Front facing camera scenario
> 
> People do run non-ChromeOS installs on their Chromebooks so we can't
> just assume that there's nobody out there with a regular distro on this
> hardware - a user like this reported the problems with the ABI for
> topology files breaking for example.

Valid point indeed.
