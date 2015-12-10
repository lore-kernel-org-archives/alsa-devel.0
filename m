From: Be <be.0@gmx.com>
Subject: Re: using all channels of RME Babyface Pro in class
 compliant mode
Date: Thu, 10 Dec 2015 02:21:34 -0600
Message-ID: <5669360E.6040304@gmx.com>
References: <56691C16.3050206@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id BA08C261A57
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 09:21:36 +0100 (CET)
Received: from localhost.localdomain ([73.211.83.96]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0MWTSA-1ZjJlK0Ews-00XcSb for
 <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 09:21:36 +0100
In-Reply-To: <56691C16.3050206@gmx.com>
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
List-Id: alsa-devel@alsa-project.org

I tested it with JACK and channels 3-4 work, but with a catch. JACK 
works with hw:Pro70785713,0 but not hw:Pro70785713. So the issue either 
with Mixxx or PortAudio not listing hw:Pro70785713,0 as an option with 
the ALSA backend.

As a quick hack, can someone suggest an ~/.asoundrc to work around this? 
I have tried various versions of the snippet below with no luck.

pcm.BabyfacePro {
     type hw
     card 1
     device 0
}

On 12/10/2015 12:30 AM, Be wrote:
> Hello, I just got an RME Babyface Pro USB sound card. It can operate
> either as a USB audio class compliant device (with mixing controlled by
> the device's physical controls) or make use of a proprietary driver on
> Windows and Mac OS X. The proprietary driver allows for control of the
> mixing capabilities of the device and using onboard DSP EQ. It would be
> great if someone wrote a Linux driver to make use of these. I'd be happy
> to send debugging info or whatever about the device and test kernel
> patches. I could set up a Windows VM to intercept USB communication.
>
> In the meantime, I am trying to use its class compliant mode to use with
> Mixxx for DJing. However, I cannot figure out how to use channels 3-4
> for my headphones. The device has 4 analog channels out and in plus 8
> digital out and in (via ADAT). Its manual says, regarding class
> compliant mode, "in Mac OS X, either the first two or all channels will
> work, depending on the choice in the Audio MIDI Setup." I believe the
> two channel operation exists so when the Babyface Pro is plugged into an
> iPad, the iPad sends stereo output from iTunes and other programs to the
> Babyface Pro's main output. However, I do not know how to select between
> this 2 channel mode and the 12 channel mode with Linux. PulseAudio only
> shows it as a stereo device. Mixxx, which uses the PortAudio library,
> displays all 12 channels as available but doesn't work when any channels
> other than 1-2 are selected. Here is debugging output of Mixxx:
>
> Debug [Main]: SoundManager::setupDevices()
> Debug [Main]: SoundDevicePortAudio::open() "2, Babyface Pro (70785713):
> USB Audio (hw:1,0)"
> Debug [Main]: framesPerBuffer: 256
> Debug [Main]: Requested sample rate:  44100 Hz, latency: 5.80499 ms
> Debug [Main]: Output channels: 4 | Input channels: 0
> Debug [Main]: Opening stream with id 2
> Expression 'alsa_snd_pcm_hw_params_set_channels( pcm, hwParams,
> self->numHostChannels )' failed in 'src/hostapi/alsa/pa_linux_alsa.c',
> line: 2051
> Expression 'PaAlsaStreamComponent_InitialConfigure( &self->playback,
> outParams, self->primeBuffers, hwParamsPlayback, &realSr )' failed in
> 'src/hostapi/alsa/pa_linux_alsa.c', line: 2717
> Expression 'PaAlsaStream_Configure( stream, inputParameters,
> outputParameters, sampleRate, framesPerBuffer, &inputLatency,
> &outputLatency, &hostBufferSizeMode )' failed in
> 'src/hostapi/alsa/pa_linux_alsa.c', line: 2838
> Warning [Main]: Error opening stream: Invalid number of channels
>
> aplay -l output:
> **** List of PLAYBACK Hardware Devices ****
> card 0: PCH [HDA Intel PCH], device 0: ALC272 Analog [ALC272 Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 1: Pro70785713 [Babyface Pro (70785713)], device 0: USB Audio [USB
> Audio]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
>
> aplay -L output:
> null
>      Discard all samples (playback) or generate zero samples (capture)
> pulse
>      PulseAudio Sound Server
> default
>      Default ALSA Output (currently PulseAudio Sound Server)
> sysdefault:CARD=PCH
>      HDA Intel PCH, ALC272 Analog
>      Default Audio Device
> front:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      Front speakers
> surround21:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      2.1 Surround output to Front and Subwoofer speakers
> surround40:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      4.0 Surround output to Front and Rear speakers
> surround41:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=PCH,DEV=0
>      HDA Intel PCH, ALC272 Analog
>      7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
> hdmi:CARD=PCH,DEV=0
>      HDA Intel PCH, HDMI 0
>      HDMI Audio Output
> sysdefault:CARD=Pro70785713
>      Babyface Pro (70785713), USB Audio
>      Default Audio Device
> front:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      Front speakers
> surround21:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      2.1 Surround output to Front and Subwoofer speakers
> surround40:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      4.0 Surround output to Front and Rear speakers
> surround41:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
> iec958:CARD=Pro70785713,DEV=0
>      Babyface Pro (70785713), USB Audio
>      IEC958 (S/PDIF) Digital Audio Output
>
> /proc/asound/card1/stream0 when playing to channels 1-2 with PulseAudio:
> RME Babyface Pro (70785713) at usb-0000:00:1d.0-1.2, high speed : USB Audio
>
> Playback:
>    Status: Running
>      Interface = 1
>      Altset = 1
>      Packet Size = 47
>      Momentary freq = 44118 Hz (0x5.83c9)
>      Feedback Format = 16.16
>    Interface 1
>      Altset 1
>      Format: S24_3LE
>      Channels: 2
>      Endpoint: 3 OUT (ASYNC)
>      Rates: 44100, 48000, 88200, 96000, 176400, 192000
>      Data packet interval: 125 us
>    Interface 1
>      Altset 2
>      Format: S24_3LE
>      Channels: 12
>      Endpoint: 3 OUT (ASYNC)
>      Rates: 44100, 48000, 88200, 96000, 176400, 192000
>      Data packet interval: 125 us
>
> Capture:
>    Status: Stop
>    Interface 2
>      Altset 1
>      Format: S24_3LE
>      Channels: 12
>      Endpoint: 4 IN (ASYNC)
>      Rates: 44100, 48000, 88200, 96000, 176400, 192000
>      Data packet interval: 125 us
>    Interface 2
>      Altset 2
>      Format: S24_3LE
>      Channels: 2
>      Endpoint: 4 IN (ASYNC)
>      Rates: 44100, 48000, 88200, 96000, 176400, 192000
>      Data packet interval: 125 us
>
> So I guess the question is how to get PortAudio to use the "Altset 2"
> option. Could this be accomplished with some asoundrc sorcery? Does
> something need to change in snd-usb-audio? Is the issue with PortAudio
> and PulseAudio? How can I test channels 3-4 with aplay or another program?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
