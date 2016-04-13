From: "Simon Wood" <simon@mungewell.org>
Subject: Re: Tascam US-122L - Corrupt USB descriptor
Date: Wed, 13 Apr 2016 08:08:17 -0600
Message-ID: <32e8a05d90e5cfd79622802c340948ab.squirrel__24506.2240669087$1460556532$gmane$org@mungewell.org>
References: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
 <570E0AE0.3020507@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20160413080817_80514"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <570E0AE0.3020507@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Simon Wood <simon@mungewell.org>, linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

------=_20160413080817_80514
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, April 13, 2016 3:01 am, Clemens Ladisch wrote:
> Simon Wood wrote:
>
>> I have been struggling for the past few days to get a Tascam US-122L
>> (USB
>> sound-card/midi interface) working, despite reading numerous forum
>> postings I have only been able to get the midi portion working.
>
> Does it show up with "aplay -l"?

The card shows up under '/proc/asound/cards', but only as Midi. See
attached for full listing.


>> I note that the USB descriptor seems to be corrupt. It declares 2
>> interfaces, but then describes 3 separate with the same interface numb=
er
>>  for the last 2.
>
> The descriptors describe two alternate settings for the same interface.
> This is a feature, which is required for audio devices.
>
>
>> iManufacturer           1 (error)				<------ Here be Errors! iProduct
>> 2 (error)
>> iSerial                 3 (error)
>
> It's possible that lsusb does not have the permissions needed to send
> the messages to ask for the strings.  Try running it as root.

Was running as root (on Xubuntu, 2 different machines, different installs=
).

I note that sometimes this is OK, ie when I do '# echo 0 >
/sys/bus/usb/devices/1-2/bConfigurationValue', but then I have no
interfaces at all (no midi, no listing).

Can anyone confirm they have a US-122L working on a new kernel. Is the US=
B
descriptor the same as what I'm seeing, perhaps hardware changed at some
point.
Cheers,
Simon
------=_20160413080817_80514
Content-Type: text/plain; name="aplay_l.txt"
Content-Disposition: attachment; filename="aplay_l.txt"
Content-Transfer-Encoding: quoted-printable

# cat /proc/asound/cards  > aplay_l.txt
 0 [Audigy2        ]: Audigy2 - SB Audigy 2 ZS [SB0350]
                      SB Audigy 2 ZS [SB0350] (rev.4, serial:0x20021102) =
at 0xccc0, irq 27
 1 [US122L         ]: USB US-122L - TASCAM US-122L
                      TASCAM US-122L (644:800e if 0 at 001/005)

# aplaymidi -l >> aplay_l.txt
 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0
 16:0    SB Audigy 2 ZS [SB0350]          Audigy MPU-401 (UART)
 16:32   SB Audigy 2 ZS [SB0350]          Audigy MPU-401 #2
 17:0    Emu10k1 WaveTable                Emu10k1 Port 0
 17:1    Emu10k1 WaveTable                Emu10k1 Port 1
 17:2    Emu10k1 WaveTable                Emu10k1 Port 2
 17:3    Emu10k1 WaveTable                Emu10k1 Port 3
 20:0    TASCAM US-122L                   TASCAM US-122L MIDI 1

# aplay -l >> aplay_l.txt
**** List of PLAYBACK Hardware Devices ****
card 0: Audigy2 [SB Audigy 2 ZS [SB0350]], device 0: emu10k1 [ADC Capture=
/Standard PCM Playback]
  Subdevices: 32/32
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15
  Subdevice #16: subdevice #16
  Subdevice #17: subdevice #17
  Subdevice #18: subdevice #18
  Subdevice #19: subdevice #19
  Subdevice #20: subdevice #20
  Subdevice #21: subdevice #21
  Subdevice #22: subdevice #22
  Subdevice #23: subdevice #23
  Subdevice #24: subdevice #24
  Subdevice #25: subdevice #25
  Subdevice #26: subdevice #26
  Subdevice #27: subdevice #27
  Subdevice #28: subdevice #28
  Subdevice #29: subdevice #29
  Subdevice #30: subdevice #30
  Subdevice #31: subdevice #31
card 0: Audigy2 [SB Audigy 2 ZS [SB0350]], device 2: emu10k1 efx [Multich=
annel Capture/PT Playback]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: Audigy2 [SB Audigy 2 ZS [SB0350]], device 3: emu10k1 [Multichanne=
l Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audigy2 [SB Audigy 2 ZS [SB0350]], device 4: p16v [p16v]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
------=_20160413080817_80514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_20160413080817_80514--
