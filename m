From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] Intel-rt5670 updates
Date: Fri, 8 Sep 2017 09:38:11 +0530
Message-ID: <20170908040811.GA3053@localhost>
References: <20170908011256.7706-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 87D6A266943
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 06:04:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170908011256.7706-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, bardliao@realtek.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, 2017 at 08:12:53PM -0500, Pierre-Louis Bossart wrote:
> Instead of submitting all my patches at ones, I broke them by
> platforms/codecs. This series is only for Intel-rt5670 platforms. It
> fixes a mistake on the Dell Venue 5585 - corrected with the help from
> Realtek and Dell who kindly provided schematics and data sheet
> information needed to fix non-working DMIC capture. Since there are
> still some reports of non-functional audio on some platforms, I added
> quirks that can be changed from the kernel command line (and later
> added as DMI-based quirks). The last two patches are minor corrections
> to fix ACPI HID naming issues and use a more meaningful card name.
> 
> Pierre-Louis Bossart (3):
>   ASoC: rt5670: refactor DMI quirks and fix Dell Venue settings
>   ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume
>   ASoC: Intel: cht_bsw_rt5672: fix card name

The last two:
Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
