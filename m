From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: question about sound/soc/intel/boards/mfld_machine.c
Date: Mon, 21 Nov 2016 01:49:43 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A95240D83F@SHSMSX101.ccr.corp.intel.com>
References: <alpine.DEB.2.20.1611191827190.1925@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1611191827190.1925@hadrien>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall@lip6.fr]
> Sent: Sunday, November 20, 2016 1:34 AM
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; Jie, Yang <yang.jie@intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: question about sound/soc/intel/boards/mfld_machine.c
> 
> Hello,
> 
> I wonder if the file sound/soc/intel/boards/mfld_machine.c is useful?
> Until:
> 
> commit e56c72d5f201044b14191c5b83a25e17f2d68ccf
> Author: Jie Yang <yang.jie@intel.com>
> Date:   Thu Apr 2 15:37:02 2015 +0800
> 
>     ASoC: Intel: create boards folder and move sst boards files in
> 
> it was in the directory sound/soc/intel and mentioned in
> sound/soc/intel/Makefile.  The above patch moved it to
> sound/soc/intel/boards/, but didn't adjust its Makefile entry.  The patch:
> 
> commit b97169da06992ef04081e66ed22bbdb23dbf6610
> Author: Jie Yang <yang.jie@intel.com>
> Date:   Thu Apr 2 15:37:04 2015 +0800
> 
>     ASoC: Intel: create atom folder and move atom platform files in
> 
> removed it from sound/soc/intel/Makefile, but didn't move it anywhere.
> As far as I can tell, there is currently no make information for the file in the
> kernel.
> 
> Should the file be dropped?

Thanks for reporting, Julia. I believe this is missed during the folder
restruction. 

Hi Vinod, what do you think? If needed, I can add it to intel/Kconfig.

Thanks,
~Keyon

> 
> julia
