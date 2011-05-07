From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
 Headphone with realtek codec
Date: Sat, 7 May 2011 10:52:09 +0800
Message-ID: <BANLkTim_JYqCiPMaZ+2Ffi+t=1_AuF6KuA@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
	<BANLkTikP+e2Oe_K0yFMJNWmYGdMkdyhN+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EAD87103807
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 04:52:09 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3108306fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 19:52:09 -0700 (PDT)
In-Reply-To: <BANLkTikP+e2Oe_K0yFMJNWmYGdMkdyhN+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/5 Valerio tesei <valerio.tesei@gmail.com>

>
> Hi Raymond,
>
> About my problem, the audio card with the latest patches seems to work (but
> great noise when nothing is playing is present, i also tried to mute
> everything in alsamixer) so i could say "it works with model=auto"


I think it just partially works with model=auto

according to your alsa-info.sh

> I applied the patch, and build the kernel, this is my lastest alsa-info:
> http://www.alsa-project.org/db/?f=61aa4129d0ea771ebc7226ea80c5c3ead24ef05c


There are two sets of capture volume/switch and input sources controls but
only one capture device

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1


Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Rear Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Line'


What kind of noise ?

Do you mean that the noise can be hear in HP and all audio jacks at rear
panel ?

Have you try those parameter in

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio.txt


Assuming that you are using default devices in
/usr/share/alsa/cards/HDA-Intel.conf

You should keep "PCM Playback Volume" at 0dB since it a softvol plugin

Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 180 [71%] [-15.00dB]
  Front Right: Playback 180 [71%] [-15.00dB]


    control.36 {
        comment.access 'read write user'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 255'
        comment.tlv '0000000100000008ffffec1400000014'
        comment.dbmin -5100
        comment.dbmax 0
        iface MIXER
        name 'PCM Playback Volume'
        value.0 180
        value.1 180
    }

> So i made the test, i correctly hear the tests, 7 outputs for the rear
> panel, and 2 for the front, but when i play the first test, i hear on
> the front panel some noise and realy crackly and whispered the tests
> when front left and front right are played, i guess it is not normal,
> may this help?

Can you compile the driver  --with-debug=verbose  ?

Check those hda_codec_setup_stream , hda_codec_prepare_stream and
hda_codec_cleanup_stream

when the driver is init, "independent HP" is off by default
so you should find one setup stream/cleanup stream for each DAC

when turn on , only four DAC is used when playing 8 channels

only 1 DAC is used for device 2
