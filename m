From: =?iso-8859-1?Q?Ren=E9_Kermis?= <kermis@gmx.de>
Subject: Re: Updated: via8233 driver -- testers wanted
Date: Fri, 31 May 2002 14:33:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <00ea01c2089f$59cb1960$6abc5f86@kermit>
References: <004401c20880$5f095b40$6abc5f86@kermit> <s5hit54h9ip.wl@alsa2.suse.de> <200205311336.55102.webmaster@refstart.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry,

forgot to mention, that I cannot check the status of the interrupt, because
there are other devices on the same interrupt (NIC and SCSI-adapter). I
could not find an option in my bios to give the audio chip an own interrupt.

           CPU0
  0:    1551713          XT-PIC  timer
  1:       6143          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:     814617          XT-PIC  AM53C974, eth0, VIA8233
 12:      35795          XT-PIC  hpt37x2
NMI:          0
LOC:    1551630
ERR:        272
MIS:          0

René

----- Original Message -----
From: "Niek van der Maas" <webmaster@refstart.nl>
To: <alsa-devel@lists.sourceforge.net>
Sent: Friday, May 31, 2002 12:36 PM
Subject: Re: [Alsa-devel] Updated: via8233 driver -- testers wanted


On Friday 31 May 2002 13:55, Takashi Iwai wrote:
> it seems like no interrupts are generated during playback.
> could you check whether the status in /proc/interrupts is changed
> during playback?
>
> also, could you check whether capture works?  capture uses a different
> SGD, so it might work individually from playback.
>
>
> (BTW, CD and line-ine can be heard without problems, since they are
>  routed directly throught ac97, so no sound engine is needed.)
>
>
> thanks,
>
> Takashi

Hi Takashi,

I tried it, and here are the results:


Before playing:
tussen root # cat /proc/interrupts
           CPU0
  0:    3875633          XT-PIC  timer
  1:       6924          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      21629          XT-PIC  usb-uhci, usb-uhci, eth0
  9:          0          XT-PIC  acpi
 11:          0          XT-PIC  VIA8233
 12:     305308          XT-PIC  PS/2 Mouse
 14:      60038          XT-PIC  ide0
 15:         45          XT-PIC  ide1
NMI:          0
LOC:    3875608
ERR:       4810
MIS:          0

Start playing file:
tussen root # aplay /usr/kde/3/share/sounds/pop.wav
Playing WAVE '/usr/kde/3/share/sounds/pop.wav' : Signed 16 bit Little
Endian,
Rate 44100 Hz, Mono
ALSA lib pcm_hw.c:413:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
Input/output error

While playing file:
tussen root # cat /proc/interrupts
           CPU0
  0:    3882996          XT-PIC  timer
  1:       6940          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      21629          XT-PIC  usb-uhci, usb-uhci, eth0
  9:          0          XT-PIC  acpi
 11:          0          XT-PIC  VIA8233
 12:     305536          XT-PIC  PS/2 Mouse
 14:      60050          XT-PIC  ide0
 15:         45          XT-PIC  ide1
NMI:          0
LOC:    3882972
ERR:       4810
MIS:          0

After playing file:
tussen root # cat /proc/interrupts
           CPU0
  0:    3892526          XT-PIC  timer
  1:       6950          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      21629          XT-PIC  usb-uhci, usb-uhci, eth0
  9:          0          XT-PIC  acpi
 11:          0          XT-PIC  VIA8233
 12:     305744          XT-PIC  PS/2 Mouse
 14:      60074          XT-PIC  ide0
 15:         45          XT-PIC  ide1
NMI:          0
LOC:    3892501
ERR:       4810

How can I test the capture? Do you mean that I have to plug in a microphone
and record a sound or so?

Thanks,

Niek.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
