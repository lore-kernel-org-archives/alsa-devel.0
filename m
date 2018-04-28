From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: cht-bsw-rt5672: allow for
 topology-defined codec-dai setup
Date: Sat, 28 Apr 2018 13:15:17 +0530
Message-ID: <20180428074516.GJ6014@localhost>
References: <20180427213600.22634-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id A2BB42675C8
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 09:40:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180427213600.22634-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 27, 2018 at 04:36:00PM -0500, Pierre-Louis Bossart wrote:
> Hard-coded setups conflict with topology defined ones. Move this code to
> codec_fixup so that SOF can override codec dai settings, e.g. to only use
> 2 channels.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
