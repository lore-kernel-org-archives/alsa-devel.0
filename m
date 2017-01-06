From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] ASoC: Add support for rt5640 sound
 card found on HP Pavilion x2 10-p000 tablet.
Date: Fri, 6 Jan 2017 12:37:34 +0530
Message-ID: <20170106070734.GP3573@localhost>
References: <cover.1483660468.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 20603266639
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 08:07:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1483660468.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2017 at 03:09:45AM +0300, Alexandrov Stansilav wrote:
> Inside DSDT table there is record for this soundcard:
> 
>             Device (RTKC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "10EC3276")  // _HID: Hardware ID
>                 Name (_CID, "10EC3276")  // _CID: Compatible ID
>                 Name (_DDN, "ALC3276")  // _DDN: DOS Device Name
>                 Name (_SUB, "103C827C")  // _SUB: Subsystem ID
>                 Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
> 
> original bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=187621

Looks good to me, both:

Acked-by: Vinod Koul <vinod.koul@intel.com>

> 
> v3: Fixed patch descriptions
> v2: Splited patch to codec and sst parts
> 
> 
> Alexandrov Stansilav (2):
>   ASoc: rt5640: Add "10EC3276" ACPI ID
>   ASoC: Intel: Atom: Add HP Pavilion x2 10 10-p000 machine entry
> 
>  sound/soc/codecs/rt5640.c           | 1 +
>  sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> -- 
> 2.10.2
> 

-- 
~Vinod
