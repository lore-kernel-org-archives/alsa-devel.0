From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Bug with ALC889A on MacPro,
 mistakenly treated as ALC885, details inside
Date: Sat, 16 Aug 2008 08:48:56 -0700
Message-ID: <48A6F6E8.3090309@cox.net>
References: <814385.24567.qm@web65611.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 70E4824358
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 17:48:58 +0200 (CEST)
In-Reply-To: <814385.24567.qm@web65611.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@ieee.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

S. Aguinaga wrote:
> Stan,
> Thank you for spending time to look at this issue.  I owe you a drink, when you are in the chicago area let me know and I'll treat you to one.

Aaaaahhh!  That was refreshing!  ;-)

> 
> Ok, so I will check with the developers an see what can be done to correct this.  Thank you.

You're welcome.  We are on the developer's list, so I will change the 
subject to reflect that there was a bug.  I was going to wait a day or 
two to see if anyone paid any attention, and then do it, but it won't 
hurt now.

> 
> //Salvador 
> 
> 
> 1. Re: latest Mac Pro (quad core) audio issues (stan)
> 
> 
> Message: 1
> Date: Fri, 15 Aug 2008 15:14:12 -0700
> From: stan <ghjeold_i_mwee@cox.net>
> Subject: Re: [alsa-devel] latest Mac Pro (quad core) audio issues
> To: "S. Aguinaga" <sa_jr@ieee.org>
> Cc: alsa-devel@alsa-project.org
> Message-ID: <48A5FFB4.10700@cox.net>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> S. Aguinaga wrote:
>> Hello Stan,
>>
>> This is awesome I did find the problem it's listed in the /var/log/messages under ALSA.
>>
>> 1.   When I bring up the "Pulse Volume Control" gui, the first tab "Playback"  comes up empty, and grayed-out is "No Streams Available"
>> 2.   aplay does not produce sound, period!
>> 3.   Amrok's welcome sample does not produce sound out of the std tower speaker or the headphone jack.
>>
>> I didn't notice anything strange on the output of the alsa-info.sh file, but when I checked the var/log/messages, this is what I found:
>>
>>  sudo cat /var/log/messages | grep ALSA
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback Volume, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Switch, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Switch, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Switch, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Switch, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Switch, skipped
>> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Switch, skipped
>>
>> Let me know if I should send something else.
>>
>> // Salvador 
>> // Northwestern University
>>
> I think your problem is a misidentification of your sound chip.  The 
> model being used for your 889A appears to be incompatible, thus all 
> the errors above.  It appears that the macpro ALC885 is being selected 
> before it gets to the choice for the ALC889A.  Perhaps a developer can 
> look into this.
> 
> !!HDA-Intel Codec information
> !!---------------------------
> 
> Codec: Realtek ALC889A
> 
> 
> !!Aplay/Arecord output
> !!------------
> 
> APLAY
> 
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC885 Analog [ALC885 Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> 
> One shows ALC889A and the other shows ALC885.  In the driver code 
> there is a comment to the effect that the 889A is best handled as an 
> ALC888, yet the macpro is listed under the ALC885.
> 
> I am not a developer so can't go beyond this, but it seems that there 
> is a problem.  There should be a macpro under the ALC888 as well as 
> the 885.
> 
> Here are the model options for the two candidates
> 
>     ALC882/885
>       3stack-dig    3-jack with SPDIF I/O
>       6stack-dig    6-jack digital with SPDIF I/O
>       arima        Arima W820Di1
>       targa        Targa T8, MSI-1049 T8
>       asus-a7j    ASUS A7J
>       asus-a7m    ASUS A7M
>       macpro    MacPro support
>       mbp3        Macbook Pro rev3
>       imac24    iMac 24'' with jack detection
>       w2jc        ASUS W2JC
>       auto        auto-config reading BIOS (default)
> 
>     ALC883/888
>       3stack-dig    3-jack with SPDIF I/O
>       6stack-dig    6-jack digital with SPDIF I/O
>       3stack-6ch    3-jack 6-channel
>       3stack-6ch-dig 3-jack 6-channel with SPDIF I/O
>       6stack-dig-demo  6-jack digital for Intel demo board
>       acer        Acer laptops (Travelmate 3012WTMi, Aspire 5600, etc)
>       acer-aspire    Acer Aspire 9810
>       medion    Medion Laptops
>       medion-md2    Medion MD2
>       targa-dig    Targa/MSI
>       targa-2ch-dig    Targs/MSI with 2-channel
>       laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE, M550JE)
>       lenovo-101e    Lenovo 101E
>       lenovo-nb0763    Lenovo NB0763
>       lenovo-ms7195-dig Lenovo MS7195
>       haier-w66    Haier W66
>       3stack-hp    HP machines with 3stack (Lucknow, Samba boards)
>       6stack-dell    Dell machines with 6stack (Inspiron 530)
>       mitac        Mitac 8252D
>       clevo-m720    Clevo M720 laptop series
>       fujitsu-pi2515 Fujitsu AMILO Pi2515
>       auto        auto-config reading BIOS (default)
> 
>>From the code, here is the comment indicating it should be treated as 
> an ALC888:
> 
> if (board_config < 0 || board_config >= ALC882_MODEL_LAST) {
>         /* Pick up systems that don't supply PCI SSID */
>         switch (codec->subsystem_id) {
>         case 0x106b0c00: /* Mac Pro */
>             board_config = ALC885_MACPRO;
>             break;
>         case 0x106b1000: /* iMac 24 */
>             board_config = ALC885_IMAC24;
>             break;
>         case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
>         case 0x106b2c00: /* Macbook Pro rev3 */
>         case 0x106b3600: /* Macbook 3.1 */
>             board_config = ALC885_MBP3;
>             break;
>         default:
>             /* ALC889A is handled better as ALC888-compatible */
>             if (codec->revision_id == 0x100103) {
>                 alc_free(codec);
>                 return patch_alc883(codec);
>             }
>             printk(KERN_INFO "hda_codec: Unknown model for ALC882, "
>                             "trying auto-probe from BIOS...\n");
>             board_config = ALC882_AUTO;
>         }
>     }
> 
