From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd: Adds rate and channel
 constraints for capture in Stoney rt5645
Date: Tue, 19 Dec 2017 15:25:16 +0530
Message-ID: <96b00588-76d4-7174-eddf-b00a9dc3c253@amd.com>
References: <1513572020-7689-1-git-send-email-akshu.agrawal@amd.com>
 <20171219093138.GC8563@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0040.outbound.protection.outlook.com [104.47.34.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2579D266D71
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:55:37 +0100 (CET)
In-Reply-To: <20171219093138.GC8563@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 12/19/2017 3:01 PM, Mark Brown wrote:
> On Mon, Dec 18, 2017 at 10:10:20AM +0530, Akshu Agrawal wrote:
> 
>> Constraints are added as we support 48Khz and dual channels.
> 
> Why is this platform more resticted than other platforms - what's the
> limitation here?

The above restrictions are for capture. In Stoney host we are supporting 
8 channels and 96Khz for playback and 2 channels and 48Khz for capture.

> 
>> Change-Id: Ib705f1101f5e2ab5c04f9526b10795a45a32debc
> 
> Don't include noise like this in upstream submissions, it makes no sense
> outside your internal environment.

ok sure, will remove it.

> 
>> +#define DUAL_CHANNEL		2
> 
> Do we really need a macro for this?
> 

Not required, will remove it too.
