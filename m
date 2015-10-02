From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
	for	TASCAM FireWire series
Date: Fri, 2 Oct 2015 20:47:38 +0200
Message-ID: <560ED14A.2060404@ladisch.de>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com>
 <s5hd1wxdyr7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D9D6A2612BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 20:48:17 +0200 (CEST)
In-Reply-To: <s5hd1wxdyr7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> kbuild test robot wrote:
>>>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>>
>>   > 23		data = be32_to_cpu(fw_dev->config_rom[28]);
>
> The code itself looks correct.  data is CPU endian.
> The problem looks rather like that fw_dev->config_rom[] is u32.
>
> Stefan, can it be changed to __be32 instead?

config_rom[] is CPU endian, too.

Strings should be read with fw_csr_string().


Regards,
Clemens
