From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.7: Use macro           
     usb_maxpacket() for portability
Date: Fri, 10 Dec 2004 17:42:22 -0000 (WET)
Message-ID: <32844.192.168.1.5.1102700542.squirrel@192.168.1.5>
References: <200412021319.20027.annabellesgarden@yahoo.de>
    <200412072301.52065.annabellesgarden@yahoo.de>
    <s5hoeh4a8nh.wl@alsa2.suse.de>
    <200412091306.23970.annabellesgarden@yahoo.de>
    <32799.192.168.1.5.1102694242.squirrel@192.168.1.5>
    <s5hacsm872d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacsm872d.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Rui Nuno Capela wrote:
>>
>> >
>> > May I ask you to check CVS's version?
>> > Keep in mind that jackd is now called like:
>> > $ jackd -dusx2y -dhw:1,2
>> > You might also change qjackctl to always append ",2" to the hw device
>> > in the usx2y case.
>> >
>>
>> Oh oh. Tried with alsa-kernel+driver CVS as of yesterday...
>>
>> First thing:
>>
>> - Missing SNDRV_HWDEP_IFACE_USX2Y_PCM definition (used to be defined
>> under asound.h on the pre-CVS 0.8.6 prototypes)
>
> Already fixed.
>

Thanks. I've fixed myself and went on... and it doesn't seem to be working
at all: I get complaints about non existing /dev/snd/pcmC1D2c and
/dev/snd/pcmC1D2p devices. That is, it fails whether I enter:
  aplay -D hw:1,2 somefile.wav
or:
  jackd -R -dusx2y -dhw:1,2 -r44100 -p128 -n2

OTOH if I issue the good old jackd command line:
  jackd -R -dusx2y -dhw:1 -r44100 -p128 -n2
the complaint is:
jackd: hwdep.c:263: snd_hwdep_poll_descriptors: Assertion 'hwdep' failed.

However, it works barely on this regular one:
  jackd -R -dalsa -dhw:1 -r44100 -p1024 -n2

All this to the bottom-line: this 0.8.7 seems broken, I'll revert to my
own functional 0.8.6, for the time being ;)

Just for the record here goes some status info:

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.7.
Compiled on Dec 10 2004 for kernel 2.6.10-rc2-mm3-RT-V0.7.32-17.0.

# cat /proc/asound/cards
0 [A5451          ]: ALI5451 - ALI 5451
                     ALI 5451 at 0x1000, irq 5
1 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/003)

# cat /proc/asound/devices
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
 32: [1- 0]: ctl
 36: [1- 0]: hardware dependent
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 40: [1- 0]: raw midi

# cat /proc/asound/hwdep
01-00: /proc/bus/usb/001/003

# cat /proc/asound/pcm
00-00: ALI 5451 : ALI 5451 : playback 32 : capture 1
01-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1


Bye now. bbl
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
