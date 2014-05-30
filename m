From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Fri, 30 May 2014 08:59:51 +0800
Message-ID: <CAN8cciazvFLOeGzisxf=oxvDSBBZGMY+RLL_sNc4++KGzieqwQ@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
 <535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
 <535FDEA8.7010206@gmail.com>
 <CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>
 <5364CE4D.7040506@gmail.com>
 <CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>
 <536E26A4.1060002@gmail.com>
 <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
 <53705396.3070406@gmail.com>
 <CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviuHg@mail.gmail.com>
 <537F9AAC.2030204@gmail.com>
 <CAN8cciaAazGX4HZet+UgbWGN4iOk9hknCjYTtdwD+k+ptqakOw@mail.gmail.com>
 <53804AD2.1030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id AF555261ADF
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 02:59:53 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id z60so3407135qgd.32
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 17:59:52 -0700 (PDT)
In-Reply-To: <53804AD2.1030101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, njoy4ever@gmail.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>  >>
>>  >> The appl_ptr  can be placed in any position in the ring buffer for
the
>>  >> application to write data but the sound card fetch data from this
ring
>>  >> buffer sequentially, however snd_pcm_write() assume the maximum
distance
>>  >> between appl_ptr and hwptr is only one buffer
>>  >>
>>  >>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_intel.c?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e
>>  >>
>>  >> Do you mean hwptr does not decrease by one period when you use
arbitrary
>>  >> period sizes for hda-Intel  ?
>>  >
>>  >
>>  > I cannot comment on this commit. But
>> "snd_hda_intel.align_buffer_size=1" indeed existed on my kernel command
>> line (for no good reason now - so removed), and I don't use a strange
>> period size.
Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
align_buffer_size : -1
bdl_pos_adj :
32,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

Why only one entry for align_buffer_size if it is specific to hda
controller when the computer have two hda controllers ?

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1324426

https://launchpadlibrarian.net/176540072/Symptom_PulseAudioLog.txt

May 29 06:57:49 Lihkin pulseaudio[1874]: [alsa-sink-92HD81B1X5 Analog]
alsa-sink.c: ALSA woke us up to write new data to the device, but there was
actually nothing to write!

Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report
this issue to the ALSA developers.
We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail()
returned 0 or another value < min_avail.

snd_pcm_avail() returned a value that is exceptionally large: 181132 bytes
(1026 ms).
Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report
this issue to the ALSA developers.

Seem pulseaudio can use strange period size

May 29 11:36:52 Lihkin pulseaudio[1306]: [alsa-sink-HDMI 0] alsa-util.c:
Its setup is:
  stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 3520
   period_size  : 352
   period_time  : 7981
   tstamp_mode  : ENABLE
   period_step  : 1
   avail_min    : 352
   period_event : 1
   start_threshold  : -1
   stop_threshold   : 7926335344172072960
   silence_threshold: 0
   silence_size : 0
   boundary     : 7926335344172072960
   appl_ptr     : 2916662
   hw_ptr       : 2958425

start_threshold  : -1

This mean the playback will automatically start if pulseaudio write any
audio data instead of start after write  pre buffer

Try aplay with  any arbitrary period size/period time and xrun_debug ,
check whether hw_ptr is updated on every period update in the system log

aplay  -v --period-size=352 --buffer-size=3520   -Dhw:0,0 stereo.wav

http://www.alsa-project.org/main/index.php/XRUN_Debug

/proc/asound/card#/pcm0p/xrun_debug

Replace '#' with your card number (usually 0). This proc file can enable
various debugging tools. The CONFIG_SND_PCM_XRUN_DEBUG,
CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG options must be enabled in your
kernel (if xrun_debug proc file is present - this feature is enabled).

# Enable basic debugging, do jiffies check and dump position on each period
and hardware pointer update calls
# Usefull when the lowlevel (specific) hardware driver is somehow broken
echo 29 > /proc/asound/card0/pcm0p/xrun_debug
