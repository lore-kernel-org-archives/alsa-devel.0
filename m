From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 2/13] Intel SST driver
Date: Tue, 7 Jul 2009 11:54:57 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC22A0@bgsmsx501.gar.corp.intel.com>
References: <1246604493-12833-1-git-send-email-vinod.koul@intel.com>
	<s5hk52q2g5k.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC21F2@bgsmsx501.gar.corp.intel.com>
	<s5hprcdaunp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E5187246C4
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:25:29 +0200 (CEST)
In-Reply-To: <s5hprcdaunp.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> >(snip)
>> >> +#ifndef CONFIG_SST_IPC_NOT_INCLUDED
>> >> +#include <asm/ipc_defs.h>
>> >> +#endif
>> >
>> >What is this file?
>> This file has the function definitions to communicate to the sound
>> card. The sound card is a part of PMIC chip. The sound card
>> registers are not accessible by CPU directly. There is a platform
>> driver that enables to communicate to the sound card. Audio driver
>> uses this header file of that diver to communicate to the sound
>> card. This is one of the dependant drivers for audio driver. This is
>> being submitted upstream by Intel as well.
>
>Hm, OK, but then don't forget to remove ifdef after that part is
>merged.  An ifdef around the include file isn't recommended at all.

Sure. Will remove them once the dependent drivers are merged.

>>
>> >
>> >> +#ifdef CONFIG_SST_OSPM_SUPPORT
>> >
>> >Can't be simple CONFIG_PM?
>> No. OSPM is new power management module being developed for the
>> platform. The code defined under this #def is to provide support
>> from audio stack to this new power management module. This is also
>> being up streamed by Intel.
>
>I understand the underlying platform isn't merged so we need another
>ifdef.  But, once after it got merged, no reason to keep another
>special config, right?
>
>Keeping own kconfigs look easy but this will increase maintenance
>labor a lot later.  If it's a power-management, using only CONFIG_PM
>would make the life happier.

Yes. These configs would go when the dependant power management module is merged. 

Thanks,
Harsha
