From: "Bandarupalli, Sailaja" <sailaja.bandarupalli@intel.com>
Subject: Re: [PATCH 1/5] [RFC]intel_hdmi_audio:include header
Date: Thu, 25 Nov 2010 10:36:49 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039E7E@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<s5h62vnnkly.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 085E21037EA
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 06:07:30 +0100 (CET)
In-Reply-To: <s5h62vnnkly.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Babu,
	Ramesh" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org



> > +#include <linux/types.h>
> > +#include <sound/initval.h>
> 
> Usually this header isn't needed in the global header file.
> 

We will remove un necessary global header files.

> > +#include "../../../drivers/staging/mrst/drv/mdfld_hdmi_audio_if.h"
> > +#include "../../../drivers/staging/mrst/drv/psb_intel_hdmi.h"
> 
> This is bad...  If these files are really used over several
> subsystems, they should be put somewhere in a better public place.
>

Currently display driver code is in the staging area. Can we move
header files to include folder?

> 
> > +/**
> > + * union aud_cfg - Audio configuration offset - 69000
> > + *
> > + * @cfg_regx: individual register bits
> > + * @cfg_regval: full register value
> > + *
> > + * */
> > +union aud_cfg {
> > +	struct {
> > +		u32 aud_en:1;
> > +		u32 layout:1;
> > +		u32 fmt:2;
> > +		u32 num_ch:2;
> > +		u32 rsvd0:1;
> > +		u32 set:1;
> > +		u32 flat:1;
> > +		u32 val_bit:1;
> > +		u32 user_bit:1;
> > +		u32 underrun:1;
> > +		u32 rsvd1:20;
> > +	} cfg_regx;
> > +	u32 cfg_regval;
> > +};
> 
> In general, better to avoid bit fields if it's used for the data
> transfer.  The bit-fields are never portable.
> 
These bit fields are used for programming the HDMI controller subsystem.

Thanks,
Sailaja and Ramesh.
