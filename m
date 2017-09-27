From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC PATCH 4/8] ASoC: Intel: move all ACPI match
 tables to common module
Date: Wed, 27 Sep 2017 23:01:32 +0530
Message-ID: <20170927173132.GP30097@localhost>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
 <20170908205702.1985-5-pierre-louis.bossart@linux.intel.com>
 <20170926042300.GL30097@localhost>
 <6c836c0f-5403-f7d2-5433-8197f8501e9e@linux.intel.com>
 <20170927094545.GK30097@localhost>
 <8b620335-189a-8287-c385-035fa176b92d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F22266DE1
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 19:27:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8b620335-189a-8287-c385-035fa176b92d@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 27, 2017 at 12:06:35PM -0500, Pierre-Louis Bossart wrote:
> On 9/27/17 4:45 AM, Vinod Koul wrote:
> >On Tue, Sep 26, 2017 at 02:13:23PM -0500, Pierre-Louis Bossart wrote:
> >>On 9/25/17 11:23 PM, Vinod Koul wrote:
> >>>On Fri, Sep 08, 2017 at 03:56:58PM -0500, Pierre-Louis Bossart wrote:

> >>>>+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[];
> >>>>+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[];
> >>>>+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[];
> >>>>+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_machines[];
> >>>>+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cherrytrail_machines[];
> >>>
> >>>so the header is just for externs, not a pretty thing, can we avoid these
> >>>somehow. Do they need to be in common file, why not keep then in respective
> >>>byt/hsw file.
> >>
> >>Because they will be shared between drivers, that's the whole point.
> >>I can't put a common table in either of sound/soc/sof or
> >>sound/soc/intel/atom. I didn't find a better solution than a module with
> >>just tables + matching functions in it.
> >
> >yes but shared between byt family or hsw family, maybe a common byt-tables.c
> >hsw-tables.c and we can move skl ones out to skl-tables.c
> 
> oh, if you are talking about splitting the tables in different files yes
> this is no issue. I thought you objected to the declaration of the tables
> themselves.

Yes. I would like to avoid an endless file for externs. Let the respective
platform build those into that driver

-- 
~Vinod
