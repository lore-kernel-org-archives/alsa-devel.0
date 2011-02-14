From: kuldeep ghan <ghankp@gmail.com>
Subject: Re: Unable to attach mixer to device AndroidOut: No
	such file or directory
Date: Mon, 14 Feb 2011 19:40:14 +0530
Message-ID: <AANLkTi=za9h-=brgcFLh7askFyjU1XkmmnyosqzsYdgB@mail.gmail.com>
References: <AANLkTindSL6f2TqJ96kXbbhMKgqxLWqGwCHGdy6tDSN-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA3DD10381E
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 15:10:17 +0100 (CET)
Received: by iye19 with SMTP id 19so5322234iye.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 06:10:14 -0800 (PST)
In-Reply-To: <AANLkTindSL6f2TqJ96kXbbhMKgqxLWqGwCHGdy6tDSN-@mail.gmail.com>
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

Hi, Here is the debug log I get when i try to create instance of audio
hardware device.

ALSAMixer:167 intializing AndroidOut Mixer!!!
ALSALib external/alsa-lib/src/control/control.c:902:(snd_ctl_open_noupdate)
Invalid CTL AndroidOut
initMixer:110 Unable to attach mixer to device: No such file or directory
ALSAMixer:169 intializing AndroidIn Mixer!!!
ALSALib external/alsa-lib/src/control/control.c:902:(snd_ctl_open_noupdate)
Invalid CTL AndroidIn
initMixer:110 Unable to attach mixer to device: No such file or directory
Mixer: master 'PCM' not found.
Mixer: route 'Earpiece' not found.
Mixer: route 'Speaker' not found.
Mixer: route 'Headphone' not found.
Mixer: route 'Bluetooth' not found.
Mixer: route 'Bluetooth A2DP' not found.
Mixer: master 'Capture' not found.
Mixer: route 'Capture' not found.
Mixer: route '' not found.
Mixer: route 'Capture' not found.
Mixer: route 'Bluetooth Capture' not found.
Mixer: route 'Bluetooth A2DP Capture' not found.
mixer initialized.
openOutputStream called for devices: 0x00000001
ALSALib external/alsa-lib/src/pcm/pcm.c:2210:(snd_pcm_open_noupdate) Unknown
PCM AndroidCapture
openOutputStream called for devices: 0x00000001
ALSALib external/alsa-lib/src/pcm/pcm.c:2210:(snd_pcm_open_noupdate) Unknown
PCM AndroidPlayback_Earpiece_incall
ALSALib external/alsa-lib/src/pcm/pcm.c:2210:(snd_pcm_open_noupdate) Unknown
PCM AndroidPlayback_Earpiece
ALSALib external/alsa-lib/src/pcm/pcm.c:2210:(snd_pcm_open_noupdate) Unknown
PCM AndroidPlayback

Where are AndroidOut and AndroidIn created? what is the possible reason for
failure above?

Kuldeep

On Sun, Feb 13, 2011 at 10:33 PM, kuldeep ghan <ghankp@gmail.com> wrote:

> I am trying to get audio working with android kernel. I am able to play wav
> files with alsa_aplay but when I try to open Output or Input stream using
> libadio Its failing.
>
> Can anyone help me with this? what could be wrong?
>
>
>
