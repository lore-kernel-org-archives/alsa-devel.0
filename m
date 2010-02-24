From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 24 Feb 2010 08:57:49 +0800
Message-ID: <4f3252891002231657w1cde569bw29461367142cc905@mail.gmail.com>
References: <4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002202001gb6df8cg6c023c52e7d8394a@mail.gmail.com>
	<20100221192951.GD30380@tango.0pointer.de>
	<4B83A912.1050501@ladisch.de>
	<20100223223234.GB5313@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 98DE51037EE
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 01:57:55 +0100 (CET)
Received: by pvc22 with SMTP id 22so528331pvc.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 16:57:50 -0800 (PST)
In-Reply-To: <20100223223234.GB5313@tango.0pointer.de>
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

2010/2/24 Lennart Poettering <mznyfn@0pointer.de>

> On Tue, 23.02.10 11:08, Clemens Ladisch (clemens@ladisch.de) wrote:
>
> >
> > Lennart Poettering wrote:
> > > On Sun, 21.02.10 12:01, Raymond Yau (superquad.vortex2@gmail.com)
> wrote:
> > > > However Simple Mixer API cannot know the subdevice number , you have
> to use
> > > > control API ( the lower level API used by Simple Mixer API )
> > >
> > > Unfortunately there is no way from the simple mixer to the lower level
> > > mixer.
>
>
> > > It would be great if the smixer would include some API that gives me a
> > > hint to which device/subdevice a specific snd_mixer_elem_t belongs to.
> >
> > Often, there is no 1:1 correspondence between mixer elements and PCM
> > devices.  Only mixer controls with interface PCM (not MIXER) have (sub-)
> > device numbers, and at the moment this is used only for controls that
> > are associated with the streams of hardware-mixing-capable cards.
>
> Which are not that many, right? Not HDA at least?
>


Card hw:1 'Intel'/'HDA Intel at 0xff9f4000 irq 22'
  Mixer name    : 'Analog Devices AD1988'
  Components    : 'HDA:11d41988'
  Controls      : 48
  Simple ctrls  : 26

Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]


Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Line' 'Mic' 'CD' 'Mix'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Line' 'Mic' 'CD' 'Mix'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Line' 'Mic' 'CD' 'Mix'
  Item0: 'Front Mic'

    control.28 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        value.0 false
        value.1 false
    }
    control.29 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 54'
        comment.dbmin -5850
        comment.dbmax 2250
        iface MIXER
        name 'Capture Volume'
        index 1
        value.0 39
        value.1 39
    }
    control.30 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        index 1
        value.0 false
        value.1 false
    }
    control.31 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 54'
        comment.dbmin -5850
        comment.dbmax 2250
        iface MIXER
        name 'Capture Volume'
        index 2
        value.0 39
        value.1 39
    }
    control.32 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        index 2
        value.0 false
        value.1 false
    }
    control.33 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        value Mic
    }
    control.34 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        index 1
        value 'Front Mic'
    }
    control.35 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        index 2
        value 'Front Mic'
    }


>
> > Getting information about the mixer layout (like the nodes reported by
> > HDA and USB devices) is on the TODO list; the only reason it isn't being
> > implemented is lack of time.
>
> Would be great to have that.
>
> Lennart
>
>
