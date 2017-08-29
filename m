From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/14] BYT/CHT codec/machine drivers update
Date: Tue, 29 Aug 2017 13:51:33 -0500
Message-ID: <fbc39e66-9979-e6a0-cef9-841c173ba9d4@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
 <d5b1f491-523a-734c-76fd-86991039353c@linux.intel.com>
 <20170829183421.utphkxqjxicedqaj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B9AE266E37
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 20:51:35 +0200 (CEST)
In-Reply-To: <20170829183421.utphkxqjxicedqaj@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/29/17 1:34 PM, Mark Brown wrote:
> On Mon, Aug 28, 2017 at 06:38:25AM -0500, Pierre-Louis Bossart wrote:
>> Mark, please don't merge this for now. There were a couple of minor comments
>> sent privately to me and I need to address them. I will send an update later
>> this week. Thanks.
> 
> OK, I did also send you a very major comment about the missing signoffs
> on a lot of the patches...

I must have had an email issue, I didn't see your replies and which 
patches you merged, sorry about the noise.
Yes, the missing signed-offs were flagged by Vinod, i didn't know they 
were required since they were already posted a while back and I didn't 
touch those patches. Point taken, i already fixed this. There was 
another issue with a missing error handling which is agreed on with 
Thierry Escande. I am also planning to get more testing done for the 
maxim codec, I am told that the machine driver worked as is but the code 
can't possibly function with a mismatch of both protocol and slot width 
so there is something fishy to look into.
