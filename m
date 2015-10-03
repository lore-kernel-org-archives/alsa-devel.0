From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
	for	TASCAM FireWire series
Date: Sat, 3 Oct 2015 11:14:22 +0200
Message-ID: <560F9C6E.70800@ladisch.de>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com>
 <s5hd1wxdyr7.wl-tiwai@suse.de>
 <560ED14A.2060404@ladisch.de> <560F3EB0.7020508@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B16FF2606CF
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 11:15:02 +0200 (CEST)
In-Reply-To: <560F3EB0.7020508@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
>>>> 23		data = be32_to_cpu(fw_dev->config_rom[28]);
>
> About using 'be32_to_cpu()', the 'config_rom' member actually has 'const
> u32 *', while in the member caracters in the textual leaf are aligned in
> big-endian.

Strictly speaking, strings do not have an endianness.

Most data in the actual configuration ROM is organized as big-endian 32-
bit values, so the FireWire core converts _all_ words from big endian to
CPU endian.  The words that are not actually 32-bit values but strings
have to be converted back; the correct function for this is cpu_to_be32().


Regards,
Clemens
