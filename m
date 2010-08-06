From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Fri, 6 Aug 2010 08:26:17 +0800
Message-ID: <AANLkTimSVVvT2zvhKhcSPyOgf76q2ea61xtjEOd3Kp3t@mail.gmail.com>
References: <4C595A52.7030401@gmx.de>
	<AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>
	<4C5AB324.2020006@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 304A8243A3
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:26:18 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2522853ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 17:26:18 -0700 (PDT)
In-Reply-To: <4C5AB324.2020006@gmx.de>
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

2010/8/5 Sebastian H. <vand2@gmx.de>

> Hello Raymond
>
> >> I've been working on Alsamixer-Qt4 lately and compiled
> >> the changes into a new release version 0.4.0.
> >
> > 1) au8830 Equalizer
> > you can find the screenshot of the equalizer ( gnome volume control) and
> the
> > correct implementation of the equalizer of the vortexcontrol and python
> > version of the equalizer
> >
> > the asound.state of au8830
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678
>
> Ok, I tried to figure out how this relates to alsamixer-qt4 (since I
> don't have the sound card).
>
> Please correct me if I'm wrong.
>
> The "EQ Peaks" Simple Mixer Element has more channels than the 9
> channels described in the snd_mixer_selem_channel_id_t enum.
> ( SND_MIXER_SCHN_FRONT_LEFT up to SND_MIXER_SCHN_REAR_CENTER ).
>

EQ Peaks is a  volatile control without write access  (i.e. you cannot use
slider since you cannot modify the value ) which provide the peak of  10
bands (31Hz, 63Hz, 125Hz, 250Hz, 500Hz, 1Kz, 2Kz, 4Kz, 8Kz , 16Kz) stereo
channels of the au8830's hardware equalizer  ,  ( one stereo vu-meters at
each band )

The values are ordered  by left channel of 10 bands followed by right
channel of 10 bands


 control.12 {
        comment.access read
        comment.type INTEGER
        comment.count 20
        comment.range '0 - 32767'
        iface MIXER
        name 'EQ Peaks'
        value.0 1
        value.1 1
        value.2 0
        value.3 0
        value.4 1
        value.5 1
        value.6 1
        value.7 1
        value.8 0
        value.9 0
        value.10 1
        value.11 1
        value.12 0
        value.13 0
        value.14 0
        value.15 0
        value.16 1
        value.17 1
        value.18 0
        value.19 0
    }

EQ enable switch control the output of DSP pass through/bypass the equalizer
,
so your application can based on the on/off state of the switch to
start/stop a timer which  read the value from EQ peak control and display on
10 stereo vu-meters at regular time intervals

There are also 10  stereo volume controls to control gain/atten of 10 bands
of the hardware equalizer

if your application are unable to display EQ peaks , it is better to skip
this "EQ peaks" control with count =20 or simple mixer control with 20
channels

All the EQ controls appear on capture side is a bug of alsa-lib or the
driver , either change the name of those  "EQ xx" controls to "EQ xx
Playback" in the driver or add "EQ" to the definition of the controls name


Simple mixer control 'EQ Peaks',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Rear Left - Rear Right -
Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ?
- ? - ? - ? - ? - ? - ? - ?
  Capture channels: Front Left - Front Right - Rear Left - Rear Right -
Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ?
- ? - ? - ? - ? - ? - ? - ?
  Limits: 0 - 32767
  Front Left: 0 [0%]
  Front Right: 0 [0%]
  Rear Left: 0 [0%]
  Rear Right: 0 [0%]
  Front Center: 0 [0%]
  Woofer: 0 [0%]
  Side Left: 0 [0%]
  Side Right: 0 [0%]
  Rear Center: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]




>
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___simple_mixer.html#g9cb8437b2f92d168c43e4da2c667e823
>
> Alsamixer-Qt4 currently can only show these 9 channels - in the channels
> mixer dialog - which is not sufficient.
>
> I did not find a function like snd_mixer_selem_playback_channels
> which would return the number of channels.
> So to find out how many channels there actually are I would have to do
> something like this
>
> int num_playback = 0;
> for ( int ii=0; ii < 1024; ++ii ) {
>        if ( snd_mixer_selem_has_playback_channel ( elem, ii ) ) {
>                num_playback += 1;
>        } else {
>                break;
>         }
> }
>
>
