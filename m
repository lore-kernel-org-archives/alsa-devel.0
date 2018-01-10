From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: Remove mfld dead code
Date: Wed, 10 Jan 2018 14:41:52 +0200
Message-ID: <1515588112.7000.835.camel@linux.intel.com>
References: <1515580175-27016-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 91838266DEC
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 13:44:57 +0100 (CET)
In-Reply-To: <1515580175-27016-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: Liam <liam.r.girdwood@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-10 at 15:59 +0530, Vinod Koul wrote:
> Medfield machine was not compiling for long on mainline. Since no one
> complained, lets remove the dead code and associated codec.

While this change seems okay per se, please keep in mind that Intel
Merrifield would be still in use (yes, we have no confirmation right now
about the status of the driver in vanilla kernel, I hope in the future
with SOF it could be much easier to get into working solution on Intel
Edison platform).

> 
> Vinod Koul (2):
>   ASoC: Intel: remove mfld_machine
>   ASoC: sn95031: remove this code
> 
>  sound/soc/codecs/Kconfig              |   4 -
>  sound/soc/codecs/Makefile             |   1 -
>  sound/soc/codecs/sn95031.c            | 936 -----------------------
> -----------
>  sound/soc/codecs/sn95031.h            | 133 -----
>  sound/soc/intel/boards/Kconfig        |  14 -
>  sound/soc/intel/boards/mfld_machine.c | 430 ----------------
>  6 files changed, 1518 deletions(-)
>  delete mode 100644 sound/soc/codecs/sn95031.c
>  delete mode 100644 sound/soc/codecs/sn95031.h
>  delete mode 100644 sound/soc/intel/boards/mfld_machine.c
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
