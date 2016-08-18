From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Thu, 18 Aug 2016 11:22:38 -0500
Message-ID: <5e408cf5-cb8c-0588-021a-8b8fa5aa6321@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
 <20160817105032.GJ9347@sirena.org.uk>
 <5a448c3a-3f72-f753-e92f-43442c48f3e7@linux.intel.com>
 <20160818092929.GM9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AB2D265AF6
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 18:22:42 +0200 (CEST)
In-Reply-To: <20160818092929.GM9347@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

On 8/18/16 4:29 AM, Mark Brown wrote:
> On Wed, Aug 17, 2016 at 01:26:02PM -0500, Pierre-Louis Bossart wrote:
>> On 8/17/16 5:50 AM, Mark Brown wrote:
>
>>> You need to at least send clock API patches to the clock maintainers,
>>> since there's no build time dependency the normal thing would be that
>>> things will go through the clock tree.
>
>> so would you rebase your tree on the clock tree then? the longer this takes
>> the more reports we'll get of broken audio in for-next due to this missing
>> MCLK support.
>
> No, if there's any need to do a merge we'll do a merge.  Does this
> actively break existing boards?

No for all the Baytrail-CR boards who never worked before.
But I believe it does for the T100/DellVenue, but we could have a 
mechanism to fall back to BCLK when MCLK is not available. Let me look 
at it later today.
