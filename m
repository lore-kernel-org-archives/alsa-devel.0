From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Thu, 3 Dec 2009 10:26:33 +0800
Message-ID: <4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E03510381C
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 03:26:37 +0100 (CET)
Received: by pzk29 with SMTP id 29so745247pzk.17
	for <alsa-devel@alsa-project.org>; Wed, 02 Dec 2009 18:26:35 -0800 (PST)
In-Reply-To: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
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

2009/12/2 pl bossart <bossart.nospam@gmail.com>

> Hi,
> I have been having issues for a while now with PulseAudio running on
> an older Thinkpad X41. PulseAudio relies on snd_pcm_avail() to detect
> underflows and increases the timer watermark when they happen. There
> are actually no audible underflows though...
> So I instrumented both PulseAudio (enabling DEBUG_TIMING in the
> alsa-sink.c code) and the kernel (latest alsa-kernel git) by adding
> the following printk  in pcm.h:
>
> static inline snd_pcm_uframes_t snd_pcm_playback_avail(struct
> snd_pcm_runtime *runtime)
> {
>        snd_pcm_sframes_t avail = runtime->status->hw_ptr +
> runtime->buffer_size - runtime->control->appl_ptr;
>        if (avail < 0)
>                avail += runtime->boundary;
>        else if ((snd_pcm_uframes_t) avail >= runtime->boundary)
>                avail -= runtime->boundary;
>        //plb
>        if(avail > runtime->buffer_size) {
>            snd_printk(KERN_ERR "avail %d hw_ptr %d buffer %d appl_ptr %d
> \n",
>                       avail, runtime->status->hw_ptr,
> runtime->buffer_size, runtime->control->appl_ptr);
>        }
>        return avail;
> }
>
> In my tests this error condition where avail is larger than the ring
> buffer happens fairly often. The dmesg log show messages such as
> [  834.524479] ALSA include/sound/pcm.h:600: avail 16403 hw_ptr 24351
> buffer 16384 appl_ptr 24332
> [  835.266937] ALSA include/sound/pcm.h:600: avail 16407 hw_ptr 55841
> buffer 16384 appl_ptr 55818
> and these messages are correlated with the times when PulseAudio
> detects underflows.
> The full log can be found at http://pastebin.com/f210aa108.
>
> I believe the issue is the accuracy of the hw_ptr reported by
> snd_intel8x0_pcm_pointer. If indeed such a condition occurred, it
> should be flagged as underflow, shouldn't it? There's been some
> changes in this part of the code to avoid extremely large values, here
> the issue seems more subtle, the pointer is only slightly off in most
> cases. This does screw-up PulseAudio though, the timer watermark keeps
> increasing and low-latency isn't possible.
>
> I'd be more than happy to run more experiments, however I have no idea
> what the hardware does to report the position of the hw pointer.
> Thanks for your feedback
> - Pierre
>
>

I: main.c: This is PulseAudio 0.9.21-296-gd2ab2


   1. D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
   2. D: alsa-util.c: Managed to open front:0
   3. D: alsa-util.c: Maximum hw buffer size is 371 ms
   4. D: alsa-util.c: Set buffer size first (to 4408 samples), period size
   second (to 1102 samples)

What is the purpose of these buffer-size and period size during the probing
phase  ?
The PA server seem use different values



   1. I: sink.c: Created sink 0 "alsa_output.pci-0000_00_1e.2.analog-stereo"
   with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
   2. I: sink.c:     alsa.resolution_bits = "16"
   3. I: sink.c:     device.api = "alsa"
   4. I: sink.c:     device.class = "sound"
   5. I: sink.c:     alsa.class = "generic"
   6. I: sink.c:     alsa.subclass = "generic-mix"
   7. I: sink.c:     alsa.name = "Intel ICH6"
   8. I: sink.c:     alsa.id = "Intel ICH"
   9. I: sink.c:     alsa.subdevice = "0"
   10. I: sink.c:     alsa.subdevice_name = "subdevice #0"
   11. I: sink.c:     alsa.device = "0"
   12. I: sink.c:     alsa.card = "0"
   13. I: sink.c:     alsa.card_name = "Intel ICH6"
   14. I: sink.c:     alsa.long_card_name = "Intel ICH6 with AD1981B at irq
   22"
   15. I: sink.c:     alsa.driver_name = "snd_intel8x0"
   16. I: sink.c:     device.bus_path = "pci-0000:00:1e.2"
   17. I: sink.c:     sysfs.path =
   "/devices/pci0000:00/0000:00:1e.2/sound/card0"
   18. I: sink.c:     device.bus = "pci"
   19. I: sink.c:     device.vendor.id = "8086"
   20. I: sink.c:     device.vendor.name = "Intel Corporation"
   21. I: sink.c:     device.product.id = "266e"
   22. I: sink.c:     device.product.name = "82801FB/FBM/FR/FW/FRW (ICH6
   Family) AC'97 Audio Controller"
   23. I: sink.c:     device.form_factor = "internal"
   24. I: sink.c:     hal.udi =
   "/org/freedesktop/Hal/devices/pci_8086_266e_sound_card_0"
   25. I: sink.c:     hal.product = "Intel ICH6 with AD1981B Sound Card"
   26. I: sink.c:     hal.card_id = "Intel ICH6 with AD1981B"
   27. I: sink.c:     device.string = "front:0"
   28. I: sink.c:     device.buffering.buffer_size = "65536"
   29. I: sink.c:     device.buffering.fragment_size = "65536"
   30. I: sink.c:     device.access_mode = "mmap+timer"
   31. I: sink.c:     device.profile.name = "analog-stereo"
   32. I: sink.c:     device.profile.description = "Analog Stereo"
   33. I: sink.c:     device.description = "Internal Audio Analog Stereo"
   34. I: sink.c:     alsa.mixer_name = "Analog Devices AD1981B"
   35. I: sink.c:     alsa.components = "AC97a:41445374"
   36. I: sink.c:     module-udev-detect.discovered = "1"
   37. I: sink.c:     device.icon_name = "audio-card-pci"


intel8x0 does not has hdmi , it seem PA hardcode hdmi for all sound cards
instead of using namehint for playback device

   1. D: alsa-mixer.c: Looking at profile output:hdmi-stereo
   2. D: alsa-mixer.c: Checking for playback on Digital Stereo (HDMI)
   (hdmi-stereo)
   3. D: alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
   4. I: (alsa-lib)conf.c: Unknown parameters 0
   5. I: (alsa-lib)pcm.c: Unknown PCM hdmi:0
   6. I: alsa-util.c: Error opening PCM device hdmi:0: Invalid argument

Is it possible to add timestamp in alsa-sink.c: Wrote 31792 bytes (of
possible 31792 bytes) statement for debugging


   1. D: alsa-sink.c: Loop
   2. D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 351 ms; Process time:
   20 ms
   3. hwptr 7948 buffer 16384 appl 16384, avail=7948
   4. D: alsa-sink.c: avail: 31792 (samples 7948)
   5. D: alsa-sink.c: 191.29 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   6. D: alsa-sink.c: Filling up
   7. hwptr 7948 buffer 16384 appl 16384, avail=7948
   8. hwptr 7948 buffer 16384 appl 16384, avail=7948
   9. D: alsa-sink.c: Wrote 31792 bytes (of possible 31792 bytes)
   10. hwptr 7960 buffer 16384 appl 24332, avail=12
   11. D: alsa-sink.c: avail: 48 (samples 12)
   12. D: alsa-sink.c: 371.25 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   13. D: alsa-sink.c: Not filling up, because too early.
   14. D: alsa-sink.c: Wakeup from ALSA!
   15. D: alsa-sink.c: Loop
   16. D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 351 ms; Process
   time: 20 ms
   17. hwptr 24351 buffer 16384 appl 24332, avail=16403
   18. E: alsa-util.c: avail 16403 delay -19
   19. D: alsa-sink.c: avail: 65536 (samples 16384)
   20. D: alsa-sink.c: 0.00 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   21. D: alsa-sink.c: Filling up
