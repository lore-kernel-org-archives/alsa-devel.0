From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Thu, 3 Jan 2019 10:28:28 -0600
Message-ID: <fd520793-4ec4-2ced-7b00-2cdd3297d74c@linux.intel.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
 <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
 <5797826.UxqLOWUXRU@localhost.localdomain>
 <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 079C7267BC7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 17:28:32 +0100 (CET)
In-Reply-To: <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Chandan Rajendra <chandan@linux.ibm.com>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Sinan Kaya <Okaya@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Ted Ts'o <tytso@google.com>, Chandan Rajendra <chandan@linux.vnet.ibm.com>
List-Id: alsa-devel@alsa-project.org


>>> arch/ia64/Kconfig:126:error: recursive dependency detected!
>>> arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
>>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
>>> kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
>>> kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
>>> kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by
>>> HIBERNATION
>>> kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
>>> init/Kconfig:250:    symbol SWAP depends on BLOCK
>>> block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
>>> fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
>>> fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
>>> drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
>>> drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
>>> <<<< LOOK HERE
>>> drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by
>>> IA64_HP_SIM
>>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
>>>
>>> At any rate, a 3 mn git bisect tells me the circular dependency is
>>> exposed by this change:
>>>
>>> f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
>>> commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
>>> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>>> Date:   Sat Dec 8 12:21:38 2018 +0530
>>>
>>>       fscrypt: remove filesystem specific build config option
>>>
>>>       In order to have a common code base for fscrypt "post read" processing
>>>       for all filesystems which support encryption, this commit removes
>>>       filesystem specific build config option (e.g.
>>> CONFIG_EXT4_FS_ENCRYPTION)
>>>       and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
>>>       value affects all the filesystems making use of fscrypt.
>>>
>>>       Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>>>       Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>>
>> FWIW, The patch at https://patchwork.kernel.org/patch/10725883/ fixes this
>> problem by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.
> OK
>
> Pierre-Louis, can you check if this patch makes the issue go away for
> you, please?

Wondering if Chandan provided the right pointer, I wasn't able to apply 
this patch, but commenting out "select BLOCK if FS_ENCRYPTION" in 
fs/ubifs/Kconfig makes the circular dependency go away. All good for me.
