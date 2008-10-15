From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Backported sbxfi driver (UNTESTED!)
Date: Wed, 15 Oct 2008 23:57:05 +0200
Message-ID: <5501535d0810151457t1bc02dfbl767b564456c09594@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F30244E4
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 23:57:24 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2656780rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2008 14:57:05 -0700 (PDT)
Content-Disposition: inline
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

>Hi,
>
>$SUBJECT is now on my sound-unstable git tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound->unstable-2.6.git
>together with other experimental patches.
>

Just wanted to help out with testing stuff.

I compiled your snapshot on my gentoo Linux x86_64

Compilation, installation and loading the drivers went smooth.

And, yes, there is sound...

Here some infos:
blub@freax $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ORIG [SB XFi (ORIG)], device 0: SB-XFi [SB-XFi]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

blub@freax $ lspci -v
01:00.0 Multimedia audio controller: Creative Labs SB X-Fi
        Subsystem: Creative Labs X-Fi Platinum
        Flags: bus master, medium devsel, latency 64, IRQ 21
        I/O ports at 8c00 [size=32]
        Memory at eb800000 (64-bit, non-prefetchable) [size=2M]
        Memory at e4000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Kernel driver in use: SB-XFi


root@freax $ lsmod | grep snd
snd_pcm_oss            40640  0
snd_mixer_oss          17224  1 snd_pcm_oss
snd_seq_oss            33168  0
snd_seq_midi_event      9864  1 snd_seq_oss
snd_seq                54056  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device         10076  2 snd_seq_oss,snd_seq
snd_hda_intel         505276  0
snd_hwdep              10320  1 snd_hda_intel
snd_sbxfi              23132  1
snd_pcm                81328  3 snd_pcm_oss,snd_hda_intel,snd_sbxfi
snd_timer              24160  2 snd_seq,snd_pcm
snd                    65128  12
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hwdep,snd_sbxfi,snd_pcm,snd_timer
soundcore              10208  1 snd
snd_page_alloc         11664  3 snd_hda_intel,snd_sbxfi,snd_pcm

root@freax $ emerge --info
Portage 2.1.4.5 (default-linux/amd64/2007.0/desktop, gcc-4.1.2,
glibc-2.6.1-r0, 2.6.27-unpatched x86_64)

So now the funny part:

I was testing a few samplerates:
Used a 1 kHz sine, 0 dBFS, 16 bit mono wave file, 96 kHz sample rate
and rsampled it with sox:
for i in 88200 50400 50000 48000 47250 44100 44056 32000 22050 11025 8000 ; do
sox 0_16_96000.wav -r ${i} 0_16_${i}.wav ; done

and played them with aplay:

for i in 96000 88200 50400 50000 48000 47250 44100 44056 32000 22050
11025 8000 ; do echo "Now playing 0_16_${i}.wav" ; aplay 0_16_${i}.wav
; echo "DONE" ; done


96000 --> O.K.
88200 --> No Sound
50400 --> No Sound
50000 --> No Sound
48000 --> O.K.
47250 --> No Sound
44100 --> No Sound
44056 --> No Sound
32000 --> No Sound

22050 --> SYSTEM FREEZ
Playing WAVE '0_16_22050.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, Mono

11025 --> SYSTEM FREEZ
Playing WAVE '0_16_11025.wav' : Signed 16 bit Little Endian, Rate
11025 Hz, Mono

8000 --> No Sound

Let me know if I can help out testing some more stuff

kind regards
Bjoern
