From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Sat, 3 Oct 2015 11:34:24 +0900
Message-ID: <560F3EB0.7020508@sakamocchi.jp>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com> <s5hd1wxdyr7.wl-tiwai@suse.de>
 <560ED14A.2060404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A6DA26155A
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 04:34:30 +0200 (CEST)
In-Reply-To: <560ED14A.2060404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 13 2015 03:47, Clemens Ladisch wrote:
> Takashi Iwai wrote:
>> kbuild test robot wrote:
>>>>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
>>>
>>>   > 23		data = be32_to_cpu(fw_dev->config_rom[28]);
>>
>> The code itself looks correct.  data is CPU endian.
>> The problem looks rather like that fw_dev->config_rom[] is u32.
>>
>> Stefan, can it be changed to __be32 instead?
> 
> config_rom[] is CPU endian, too.
> 
> Strings should be read with fw_csr_string().

The function is designed for IEEE 1212 compliant config ROM. On the
other hand, config ROMs of these models are not fully compliant. See:

http://sourceforge.net/p/linux1394/mailman/message/33899800/

Currently, this driver supports just two models. These two models have
similar structure in their config ROM, fortunately. Thus, it's
reasonable for the driver to get information in hard-coded position of
config ROM.


About using 'be32_to_cpu()', the 'config_rom' member actually has 'const
u32 *', while in the member caracters in the textual leaf are aligned in
big-endian. I selected the simplest way to pick it up.

If it's preferrable to suppress the sparse warnings, I don't mind to
replace these codes with the other ways.


Regards

Takashi Sakamoto
