From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/6] ASoC: Intel: Skylake: Add loadable
 module support for Kabylake
Date: Wed, 26 Apr 2017 11:10:18 +0530
Message-ID: <20170426054018.GF6263@localhost>
References: <1493102904-12624-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC4726686A
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 07:38:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1493102904-12624-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 25, 2017 at 12:18:18PM +0530, Subhransu S. Prusty wrote:
> KBL module load is a bit different than rest as Library manifest
> containing module information is required to be loaded first before
> loading module.
> 
> So common changes are moved to helpers and arguments are modified as a
> pre-work for adding module loading support.
> 
> Also, separate dsp_fw_ops is registered and load library for kabylake is
> added to use code loader dma for library and module load.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
