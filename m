From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: Re: [PATCH v4 1/4] ASoC: intel: atom: Add debug
 information related to FW version
Date: Thu, 1 Dec 2016 09:56:07 +0100
Message-ID: <5117a187-3a7d-74f6-a043-621963b88cc6@intel.com>
References: <20161124084922.9623-1-sebastien.guiriec@intel.com>
 <20161124084922.9623-2-sebastien.guiriec@intel.com>
 <20161130181712.tmbx6zfokapucg6f@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A7626669C
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 09:59:58 +0100 (CET)
In-Reply-To: <20161130181712.tmbx6zfokapucg6f@sirena.org.uk>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

It seems that you already put v1 single patch inside your topic/intel branch

6a7f5e4 ASoC: Intel: atom: Add debug information related to FW version
ca590c1 ASoC: Intel: Skylake: Use DPIB to update position for Playback 
stream
c8eabf8 ASoC: Intel: Skylake: Fix a shift wrapping bug
d5bc18c ASoC: intel: broadwell: constify snd_soc_ops structures
89c03dd ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for array
a31b466 ASoC: Intel: report JACK_LINEOUT event
1001354 Linux 4.9-rc1

So whereas you just skip patch 0001 and aplly the next 3 to add the 
sysfs or I can send update without the first patch.

What is you prefer option?


On 30/11/2016 19:17, Mark Brown wrote:
> On Thu, Nov 24, 2016 at 09:49:19AM +0100, Sebastien Guiriec wrote:
>> This patch is adding debug information related to SST FW version.
>
> This doesn't apply against current code, please check and resend.
>
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
