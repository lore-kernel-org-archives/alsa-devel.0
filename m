From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Sat, 27 Nov 2010 15:48:53 +0800
Message-ID: <AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BA77C24141
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 08:48:55 +0100 (CET)
Received: by eyg24 with SMTP id 24so1270624eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 23:48:55 -0800 (PST)
In-Reply-To: <AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
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

2010/11/27 Colin Kincaid Williams <discord@uw.edu>

> On Fri, Nov 26, 2010 at 8:35 PM, Daniel Chen <seven.steps@gmail.com>
> wrote:
> > Please use http://www.alsa-project.org/alsa-info.sh
> >
>



Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0f

if your motherboard have 6 audio jacks (pink, blue , green , black , orange
and grey ) and digital output at rear panel, you should try model=6stack-dig

Simple mixer control 'CD',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [-35.00dB] [on]
  Front Right: Playback 0 [0%] [-35.00dB] [on]

Make sure that you have muted those playback volume control of "CD"
,"Line" to reduce noise from those input to your output



>> Simple mixer control 'Channel Mode',0
>>  Capabilities: enum
>>  Items: '8ch'
>>  Item0: '8ch'
>>


only those motherboard with less than 4 output jacks need the "channel mode"
control to retask some input jacks as output jacks
