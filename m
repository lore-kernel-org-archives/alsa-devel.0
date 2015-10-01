From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Thu, 1 Oct 2015 21:54:54 +0800
Message-ID: <201510012147.nfdOjouA%fengguang.wu@intel.com>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 62FC5266689
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 15:56:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

[auto build test results on next-20151001 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:25:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:30:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32
   sound/firewire/tascam/tascam.c:32:16: sparse: cast to restricted __be32

vim +23 sound/firewire/tascam/tascam.c

     7	 */
     8	
     9	#include "tascam.h"
    10	
    11	MODULE_DESCRIPTION("TASCAM FireWire series Driver");
    12	MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
    13	MODULE_LICENSE("GPL v2");
    14	
    15	static int check_name(struct snd_tscm *tscm)
    16	{
    17		struct fw_device *fw_dev = fw_parent_device(tscm->unit);
    18		char vendor[8];
    19		char model[8];
    20		__u32 data;
    21	
    22		/* Retrieve model name. */
  > 23		data = be32_to_cpu(fw_dev->config_rom[28]);
    24		memcpy(model, &data, 4);
    25		data = be32_to_cpu(fw_dev->config_rom[29]);
    26		memcpy(model + 4, &data, 4);
    27		model[7] = '\0';
    28	
    29		/* Retrieve vendor name. */
    30		data = be32_to_cpu(fw_dev->config_rom[23]);
    31		memcpy(vendor, &data, 4);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
