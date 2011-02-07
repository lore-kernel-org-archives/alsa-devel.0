From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Tue, 8 Feb 2011 00:12:42 +0800
Message-ID: <AANLkTimYUk4fD8LDTPATRmkWvv_ycrVEqggnGtk8A_UM@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
	<AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
	<AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
	<AANLkTinoF-RqGFo7w57E8C+L5=zKH_hQ+0G0defh0WX-@mail.gmail.com>
	<AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 55C9424466
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 17:19:16 +0100 (CET)
Received: by ewy19 with SMTP id 19so2188197ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Feb 2011 08:19:10 -0800 (PST)
In-Reply-To: <AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
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

2011/2/7 Vincent Meserette <vmeserette@aldebaran-robotics.com>

>
> To record four channels simultaneously, I have created the following alsa=
 configuration file :
>
> *# output device
> pcm.AD1989A{
>     type hw
>     card 0
> }
>
> # input device* *
> pcm.quad {
>         type multi
>
>         slaves.a.pcm "hw:0,0,0" # ADC 0 of the codec (left and right mics)
>         slaves.a.channels 2
>         slaves.b.pcm "hw:0,0,1" # ADC 1 of the codec (front and rear mics)
>         slaves.b.channels 2
>
>         bindings.0.slave a
>         bindings.0.channel 0
>         bindings.1.slave a
>         bindings.1.channel 1
>         bindings.2.slave b
>         bindings.2.channel 0
>         bindings.3.slave b
>         bindings.3.channel 1
> }
>
> # input device containing interleaved data
> pcm.quad2 {
>         type route
>         slave.pcm "quad"
>         ttable.0.0 1
>         ttable.1.1 1
>         ttable.2.2 1
>         ttable.3.3 1
> }
>
> ### CTL DEVICES (controls)
> ctl.mixer0 {
>     type hw
>     card 0
> }*
>
> With this configuration file, I am able to record the four channels
> simultaneously with the following command :
>
> arecord -c4 -fS16_LE -r48000 -D =ABquad2 =BB -d5 /tmp/recording.wav
>
>
it is strange that I alway got overrun only at the first time of running the
above command but no overrun on the second time

arecord -v -c4 -fS16_LE -r48000 -D quad2  -d5 /tmp/recording.wav
Recording WAVE '/tmp/recording.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Channels 4
Route conversion PCM
  Transformation table:
    0 <- 0
    1 <- 1
    2 <- 2
    3 <- 3
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Multi PCM
  Channel bindings:
    0: slave 0, channel 0
    1: slave 0, channel 1
    2: slave 1, channel 0
    3: slave 1, channel 1
Its setup is:
  stream       : CAPTURE
  access       : MMAP_COMPLEX
  format       : S16_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave #0: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
Slave #1: Hardware PCM card 1 'HDA Intel' device 0 subdevice 1
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
overrun!!! (at least 0.001 ms long)
Status:
  state       : XRUN
  trigger_time: 1077.282286934
  tstamp      : 1077.282292637
  delay       : 0
  avail       : 16384
  avail_max   : 16384
overrun!!! (at least 0.001 ms long)
Status:
  state       : XRUN
  trigger_time: 1077.623810402
  tstamp      : 1077.623819150
  delay       : 0
  avail       : 16384
