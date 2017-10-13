From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 0/9] Baytrail-Cherrytrail updates
Date: Fri, 13 Oct 2017 16:49:06 +0100
Message-ID: <1507909746.2525.91.camel@loki>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E05FB266EAF
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 17:49:14 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-10-12 at 18:37 -0500, Pierre-Louis Bossart wrote:
> As discussed on the alsa-devel mailing list, here is a set of patches to fix
> 
> 1. previous feedback on bytcht_rt5651 - no new functionality beyond
> what was already reviewed
> 2. cosmetic issues (variables in reverse xmas tree order, etc)
> 3. unnecessary clock tests
> 4. addition of a helper to remove duplicate code across machine drivers
> 
> The last two patches were not included in the first pass,
> they correct an off-by-one issue which has no functional impact
> and remove the hard-codec compressed dailinks which don't currently
> work with the mainline code+publicly available firmware.
> 
> Pierre-Louis Bossart (9):

All 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
