From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH 2/7] ASoC: Intel: Kconfig:
 Simplify-clarify ACPI/PCI dependencies
Date: Sat, 18 Nov 2017 16:55:37 +0000
Message-ID: <1511024136.25007.312.camel@intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
 <1511024018.25007.310.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE9926736B
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 17:55:42 +0100 (CET)
In-Reply-To: <1511024018.25007.310.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <4404F3EC24B7C04B970997F09C7A1741@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2017-11-18 at 18:53 +0200, Andy Shevchenko wrote:
> On Fri, 2017-11-17 at 18:01 -0600, Pierre-Louis Bossart wrote:
> > PCI/ACPI selections should not happen in Kconfig for machine
> > drivers,
> > move to SOC selections.
> > 
> > Add distinction between PCI and ACPI HiFi2 platforms.
> 
> 
> >  The PCI-based
> > platforms may be removed at some point since Medfield is not really
> > supported by anyone
> 
> This is rather true,
> 
> >  and there is no publicly available firmware for
> > Merrifield.
> 
> while this is not true. Intel Edison board is based on Merrifield SoC

s/SoC/platform/

> and I'm sure people are able to make a sound out of it.
> 

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
