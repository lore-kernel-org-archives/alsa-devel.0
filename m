From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: Re: Alsa-devel Digest, Vol 18, Issue 45
Date: Sat, 16 Aug 2008 06:15:46 -0700 (PDT)
Message-ID: <814385.24567.qm@web65611.mail.ac4.yahoo.com>
Reply-To: "S. Aguinaga" <sa_jr@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65611.mail.ac4.yahoo.com (web65611.mail.ac4.yahoo.com
	[76.13.9.79]) by alsa0.perex.cz (Postfix) with SMTP id 75CE9244EE
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 15:15:48 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Stan,
Thank you for spending time to look at this issue.  I owe you a drink, when you are in the chicago area let me know and I'll treat you to one.

Ok, so I will check with the developers an see what can be done to correct this.  Thank you.

//Salvador 


1. Re: latest Mac Pro (quad core) audio issues (stan)


Message: 1
Date: Fri, 15 Aug 2008 15:14:12 -0700
From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: [alsa-devel] latest Mac Pro (quad core) audio issues
To: "S. Aguinaga" <sa_jr@ieee.org>
Cc: alsa-devel@alsa-project.org
Message-ID: <48A5FFB4.10700@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

S. Aguinaga wrote:
> 
> Hello Stan,
> 
> This is awesome I did find the problem it's listed in the /var/log/messages under ALSA.
> 
> 1.   When I bring up the "Pulse Volume Control" gui, the first tab "Playback"  comes up empty, and grayed-out is "No Streams Available"
> 2.   aplay does not produce sound, period!
> 3.   Amrok's welcome sample does not produce sound out of the std tower speaker or the headphone jack.
> 
> I didn't notice anything strange on the output of the alsa-info.sh file, but when I checked the var/log/messages, this is what I found:
> 
>  sudo cat /var/log/messages | grep ALSA
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback Volume, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Switch, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Switch, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Switch, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Switch, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Switch, skipped
> Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Switch, skipped
> 
> Let me know if I should send something else.
> 
> // Salvador 
> // Northwestern University
> 
I think your problem is a misidentification of your sound chip.  The 
model being used for your 889A appears to be incompatible, thus all 
the errors above.  It appears that the macpro ALC885 is being selected 
before it gets to the choice for the ALC889A.  Perhaps a developer can 
look into this.

!!HDA-Intel Codec information
!!---------------------------

Codec: Realtek ALC889A


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC885 Analog [ALC885 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

One shows ALC889A and the other shows ALC885.  In the driver code 
there is a comment to the effect that the 889A is best handled as an 
ALC888, yet the macpro is listed under the ALC885.

I am not a developer so can't go beyond this, but it seems that there 
is a problem.  There should be a macpro under the ALC888 as well as 
the 885.

Here are the model options for the two candidates

    ALC882/885
      3stack-dig    3-jack with SPDIF I/O
      6stack-dig    6-jack digital with SPDIF I/O
      arima        Arima W820Di1
      targa        Targa T8, MSI-1049 T8
      asus-a7j    ASUS A7J
      asus-a7m    ASUS A7M
      macpro    MacPro support
      mbp3        Macbook Pro rev3
      imac24    iMac 24'' with jack detection
      w2jc        ASUS W2JC
      auto        auto-config reading BIOS (default)

    ALC883/888
      3stack-dig    3-jack with SPDIF I/O
      6stack-dig    6-jack digital with SPDIF I/O
      3stack-6ch    3-jack 6-channel
      3stack-6ch-dig 3-jack 6-channel with SPDIF I/O
      6stack-dig-demo  6-jack digital for Intel demo board
      acer        Acer laptops (Travelmate 3012WTMi, Aspire 5600, etc)
      acer-aspire    Acer Aspire 9810
      medion    Medion Laptops
      medion-md2    Medion MD2
      targa-dig    Targa/MSI
      targa-2ch-dig    Targs/MSI with 2-channel
      laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE, M550JE)
      lenovo-101e    Lenovo 101E
      lenovo-nb0763    Lenovo NB0763
      lenovo-ms7195-dig Lenovo MS7195
      haier-w66    Haier W66
      3stack-hp    HP machines with 3stack (Lucknow, Samba boards)
      6stack-dell    Dell machines with 6stack (Inspiron 530)
      mitac        Mitac 8252D
      clevo-m720    Clevo M720 laptop series
      fujitsu-pi2515 Fujitsu AMILO Pi2515
      auto        auto-config reading BIOS (default)

>From the code, here is the comment indicating it should be treated as 
an ALC888:

if (board_config < 0 || board_config >= ALC882_MODEL_LAST) {
        /* Pick up systems that don't supply PCI SSID */
        switch (codec->subsystem_id) {
        case 0x106b0c00: /* Mac Pro */
            board_config = ALC885_MACPRO;
            break;
        case 0x106b1000: /* iMac 24 */
            board_config = ALC885_IMAC24;
            break;
        case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
        case 0x106b2c00: /* Macbook Pro rev3 */
        case 0x106b3600: /* Macbook 3.1 */
            board_config = ALC885_MBP3;
            break;
        default:
            /* ALC889A is handled better as ALC888-compatible */
            if (codec->revision_id == 0x100103) {
                alc_free(codec);
                return patch_alc883(codec);
            }
            printk(KERN_INFO "hda_codec: Unknown model for ALC882, "
                            "trying auto-probe from BIOS...\n");
            board_config = ALC882_AUTO;
        }
    }


------------------------------

Message: 2
Date: Fri, 15 Aug 2008 16:15:45 -0700
From: "John L. Utz III" <john.utz@dmx.com>
Subject: [alsa-devel] alsa git: which version of ac97_codec.c am i
    supposed    to hxr?
To: "ALSA Developers" <alsa-devel@alsa-project.org>
Message-ID: <op.ufyawjke647oa9@jutz-gnto64>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes

Hello All;

I feel confused by the presence of 2 different copies of ac97_codec.c:

   jutz-gnto ~ # find . -name ac97_codec.c
     ./alsa-driver/pci/ac97/ac97_codec.c
     ./alsa-kmirror/pci/ac97/ac97_codec.c

worse yet,they are not in sync:

jutz-gnto ~ # diff -w ./alsa-driver/pci/ac97/ac97_codec.c  
./alsa-kmirror/pci/ac97/ac97_codec.c
1d0
< #include "adriver.h"
38c37
< #include "../../alsa-kernel/pci/ac97/ac97_id.h"
---
> #include "ac97_id.h"
40c39
< #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
---
> #include "ac97_patch.c"
1917d1915
< #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
1929d1926
< #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 14)
1931d1927
< #endif
1953,1956d1948
< #else /* <= 2.6.0 */
< #define snd_ac97_dev_register NULL
< #define snd_ac97_dev_disconnect       NULL
< #endif


Which of these am i supposed to use? am i supposed to change both of them  
for some backward compatibility purpose?

tnx!

johnu



------------------------------

Message: 3
Date: Sat, 16 Aug 2008 06:27:02 +0000 (UTC)
From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: [alsa-devel] Configure and use dmix with a new ASoC driver
To: alsa-devel@alsa-project.org
Message-ID: <loom.20080816T061550-625@post.gmane.org>
Content-Type: text/plain; charset=us-ascii

Hi, 

I don't know if there is something special I should do to be able to use dmix
with my new ASoC driver I made (TLV320AIC23b codec running on a AT91RM9200
board).

The problem is when I try to use dmix with aplay, it doesn't work and I got
this error message:

# aplay -v -D plug:dmix /media/usb0/tada.wav
aplay: main:545: audio open error: Operation not permitted
#

Listing of my /dev/snd:

# ls -al /dev/snd
drwxr-xr-x    2 root     root            0 Jan  1 00:01 .
drwxr-xr-x    7 root     root            0 Jan  1 00:01 ..
crw-rw----    1 root     audio    116,   0 Jan  1 00:01 controlC0
crw-rw----    1 root     audio    116,  16 Jan  1 00:01 pcmC0D0p


Notice I have a default /usr/share/alsa/alsa.conf file too. I'm running ALSA
1.0.15. Of course, it works well when I play a sound without the -D plug:dmix
parameter...

# aplay /media/usb0/tada.wav
at91-ssc:ssc_startup: SSC_SR=0x000004c3
armus_tlv320aic23b: pck1 started
asoc: aic23b <-> at91-ssc1 info:
asoc: rate mask 0x6fe
asoc: min ch 1 max ch 2
asoc: min rate 8000 max rate 96000
Playing WAVE '/media/usb0/tada.wav' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo
#

I tried to find some useful documentation about dmix but mainly it says that
when we have a recent version of ALSA, we don't need to configure it because
it's already done? 



------------------------------

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


End of Alsa-devel Digest, Vol 18, Issue 45
******************************************
