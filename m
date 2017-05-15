From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/7] ASoC: Intel: kabylake: Adds
 rt5663+max98927 machine driver
Date: Mon, 15 May 2017 16:24:47 +0530
Message-ID: <20170515105446.GB15061@localhost>
References: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 64584266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 12:52:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 15, 2017 at 01:42:10PM +0530, Naveen M wrote:
> Add support for multiple codecs in acpi matching of sst library using
> machine quirk for robust mach driver selection.
> Add kabylake machine driver & corresponding driver entry in machine table
> for following codecs:
>  1. rt5663 for headset configured to ssp1.
>  2. max98927 for speakers configured to ssp0.
> Changes in V2: Convert all machine data to C99 style.
> Changes in V3: Split machine data for respective drivers 

Looks good to me:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
