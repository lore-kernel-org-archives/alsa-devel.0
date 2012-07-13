From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Fri, 13 Jul 2012 19:48:22 +0200
Message-ID: <50005F66.3050401@perex.cz>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id EFA852488B
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2012 19:47:13 +0200 (CEST)
In-Reply-To: <s5hr4tjwvxz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Date 13.6.2012 08:46, Takashi Iwai wrote:
> At Wed, 13 Jun 2012 10:23:51 +0800,
> Wang Xingchao wrote:
>>
>> this patch add proper id for Haswell HDA Controller.
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> 
> Oh, now ID number decreases to 0xxx? :)
> 
> While we are on this: could you verify whether position_fix=4 (combo)
> options works for Haswell?  In this mode, LPIB is used for playback
> positioning while POS buffer is used for capture. 
> 
> Seth (Cc'ed) figured out that this mode works better than the default
> (usually POS buf both for playback and capture) on the recent Intel
> controller chips, so I guess it'd be applied to Haswell, too.

The combo works OK for the Haswell. I think that the patch should be
applied with the HDMI ID patch "[PATCH] ALSA: hda - add Haswell HDMI pci
id".

Acked-by: Jaroslav Kysela <perex@perex.cz>

But it seems that the HDA bridge (8086:0c0c) with the HDMI codecs is
detected as first in the PCI probe in this system, which is not ideal.
So the card0 is HDMI only and card1 is analog:


!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xc2820000 irq 11
 1 [PCH_1          ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xc2824000 irq 11


!!PCI Soundcards installed in the system
!!--------------------------------------

00:03.0 Audio device: Intel Corporation Device 0c0c (rev 01)
00:1b.0 Audio device: Intel Corporation Device 8c20 (rev 01)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:03.0 0403: 8086:0c0c (rev 01)
	Subsystem: 8086:2010
--
00:1b.0 0403: 8086:8c20 (rev 01)
	Subsystem: 8086:7270


Perhaps, we may add also some code to penalize the HDMI only HDA bridges
and allocate these cards on indexes 1+ by default (implement
AZX_DCAPS_INDEX1) . Comments? I'll prepare a patch upon an agreement.

						Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/pci/hda/hda_intel.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 2b6392b..f530c40 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -151,6 +151,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
>>  			 "{Intel, CPT},"
>>  			 "{Intel, PPT},"
>>  			 "{Intel, LPT},"
>> +			 "{Intel, HPT},"
>>  			 "{Intel, PBG},"
>>  			 "{Intel, SCH},"
>>  			 "{ATI, SB450},"
>> @@ -3253,6 +3254,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>>  	{ PCI_DEVICE(0x8086, 0x8c20),
>>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
>>  	  AZX_DCAPS_BUFSIZE},
>> +	/* Haswell */
>> +	{ PCI_DEVICE(0x8086, 0x0c0c),
>> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
>> +	  AZX_DCAPS_BUFSIZE},
>>  	/* SCH */
>>  	{ PCI_DEVICE(0x8086, 0x811b),
>>  	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
>> -- 
>> 1.7.9.5
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
