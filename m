From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Thu, 04 Jan 2018 19:13:03 +0200
Message-ID: <1515085983.7000.688.camel@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-4-pierre-louis.bossart@linux.intel.com>
 <1515077848.7000.676.camel@linux.intel.com>
 <1294a824-602c-66e0-35bb-a7b47f3e856a@linux.intel.com>
 <1515081629.7000.679.camel@linux.intel.com>
 <8608f1eb-d22a-75c3-f6a2-68929404e393@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E2EA267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:16:07 +0100 (CET)
In-Reply-To: <8608f1eb-d22a-75c3-f6a2-68929404e393@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-01-04 at 11:06 -0600, Pierre-Louis Bossart wrote:
> On 1/4/18 10:00 AM, Andy Shevchenko wrote:
> > On Thu, 2018-01-04 at 09:24 -0600, Pierre-Louis Bossart wrote:

> > > we use this: snd_soc_acpi_find_name_from_hid(mach->id)
> > > 
> > > When I started all this the recommendation was to do all this on
> > > the
> > > audio side of things, I have no objections to a move of the
> > > functionality in acpi.
> > 
> > I almost done a patch. I will Cc you for the series.
> 
> ok. The only concern I have is that this needs to be a somewhat 
> contained change that doesn't depend on all sorts of other ACPI/GPIO 
> changes. We will have to maintain a v4.14-based branch for a very
> very 
> long time and the simpler we make it for people who back-port or 
> cherry-pick the better.

Yes, that is how series has been prepared. You basically need two first
patches out of three from it. It had been sent already.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
