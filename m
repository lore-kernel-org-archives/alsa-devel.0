From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 0/4] ASoC: fix saif record unwork issue
Date: Wed, 25 Jul 2012 14:44:41 +0800
Message-ID: <20120725064440.GA30982@shlinux2.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
 <20120724192125.GF3099@opensource.wolfsonmicro.com>
 <500F838E.6050709@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id D0FCA2652D7
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 08:56:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500F838E.6050709@bluegiga.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 25, 2012 at 01:26:38PM +0800, Lauri Hintsala wrote:
> On 07/24/2012 10:21 PM, Mark Brown wrote:
> > On Tue, Jul 24, 2012 at 03:46:38PM +0300, Lauri Hintsala wrote:
> >
> >> 1. Recorded audio file is totally silent. Hexdump shows zeros.
> >
> > This one is commonly due to devices powering up muted by default and
> > requiring that you set some controls to route the audio through - are
> > you sure you've not missed anything there?
> 
> I tried to set gains and other settings with alsamixer. I didn't see any 
> options for muting. Here is the output of amixer.
> 
> $ amixer
> Simple mixer control 'Headphone',0
>    Capabilities: pvolume penum
>    Playback channels: Front Left - Front Right
>    Limits: Playback 0 - 127
>    Mono:
>    Front Left: Playback 122 [96%] [9.50dB]
>    Front Right: Playback 122 [96%] [9.50dB]
> Simple mixer control 'Headphone Mux',0
>    Capabilities: enum
>    Items: 'DAC' 'LINE_IN'
>    Item0: 'LINE_IN'
> Simple mixer control 'Headphone Playback ZC',0
>    Capabilities: pswitch pswitch-joined penum
>    Playback channels: Mono
>    Mono: Playback [on]
> Simple mixer control 'PCM',0
>    Capabilities: pvolume penum
>    Playback channels: Front Left - Front Right
>    Limits: Playback 0 - 192
>    Mono:
>    Front Left: Playback 173 [90%]
>    Front Right: Playback 173 [90%]
> Simple mixer control 'Mic',0
>    Capabilities: volume volume-joined penum
>    Playback channels: Mono
>    Capture channels: Mono
>    Limits: 0 - 4
>    Mono: 2 [50%] [30.00dB]
> Simple mixer control 'Capture',0
>    Capabilities: cvolume penum
>    Capture channels: Front Left - Front Right
>    Limits: Capture 0 - 15
>    Front Left: Capture 14 [93%]
>    Front Right: Capture 14 [93%]
> Simple mixer control 'Capture Attenuate Switch (-6dB)',0
>    Capabilities: volume volume-joined penum
>    Playback channels: Mono
>    Capture channels: Mono
>    Limits: 0 - 2
>    Mono: 2 [100%]
> Simple mixer control 'Capture Mux',0
>    Capabilities: enum
>    Items: 'MIC_IN' 'LINE_IN'
>    Item0: 'LINE_IN'
> Simple mixer control 'Capture ZC',0
>    Capabilities: pswitch pswitch-joined penum
>    Playback channels: Mono
>    Mono: Playback [on]
> 
> The testing is not currently very reasonable. I have to reboot my 
> machine after every single recording because of "busy" bug.
> 
I reproduced your issue.
It seems the root cause is that you used the wrong device to record.
The record device is 1.
root@freescale ~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Can you try again with below command?
arecord -D hw:0,1 -d 5 -f S16_LE -r 44100 -c 2 1.wav

However, i think it is an issue of the driver that it should report an error
if find user are using a device to do playback or capture without that capability.

I'm wondering soc-core may need provide an interface for user to change the DAI capability
according to the real using, e.g: only playback are used.
I'm not sure if we already have one.
Will do some research on it.

Regards
Dong Aisheng
