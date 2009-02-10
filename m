From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: Juli@ ICE1724 and 24 bit audio
Date: Tue, 10 Feb 2009 13:45:41 -0800
Message-ID: <FD9DC57219D649799667EA3132AC773C@PDSDesktop>
References: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>	<49909186.4050902@insite.cz>	<67FF030CD7BA4BFB9ACE52B69F56D69D@DemianM1330>	<fd3eb9bf0902091338i7ffa51d6t5a62d82a6b48ada3@mail.gmail.com>	<47A687F571094A7F827250BBE602F100@DemianM1330>
	<fd3eb9bf0902100333m7ab4edc1g99de11000a794245@mail.gmail.com>
	<49919EA2.6030000@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.prem.mail.sp1.yahoo.com
	(smtp107.prem.mail.sp1.yahoo.com [98.136.44.62])
	by alsa0.perex.cz (Postfix) with SMTP id 972C5243E3
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 22:45:39 +0100 (CET)
In-Reply-To: <49919EA2.6030000@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Pavel Hofman' <pavel.hofman@insite.cz>, =?iso-8859-2?Q?'Vedran_Mileti=E6'?= <rivanvx@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Testing updates. =

First aplay w/ hw:0,0 gets this useless result:
linuxmce@dcerouter:/home/public/data/audio/RR HDaudio$ aplay -v -Dhw:0,0
1_Mystery_Pacific.wav                                      =

Playing WAVE '01_Mystery_Pacific.wav' : Signed 24 bit Little Endian in
3bytes, Rate 176400 Hz, Stereo
aplay: set_params:900: Sample format non available

Then w/ plughw:0,0
linuxmce@dcerouter:/home/public/data/audio/RR HDaudio$ aplay -v -Dplughw:0,0
01_Mystery_Pacific.wav
Playing WAVE '01_Mystery_Pacific.wav' : Signed 24 bit Little Endian in
3bytes, Rate 176400 Hz, Stereo
Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S24_3LE
  subformat    : STD
  channels     : 2
  rate         : 176400
  exact rate   : 176400 (176400/1)
  msbits       : 24
  buffer_size  : 32768
  period_size  : 8192
  period_time  : 46439
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 8192
  xfer_align   : 8192
  start_threshold  : 32768
  stop_threshold   : 32768
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'ESI Juli@' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 176400
  exact rate   : 176400 (176400/1)
  msbits       : 24
  buffer_size  : 32768
  period_size  : 8192
  period_time  : 46439
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 8192
  xfer_align   : 8192
  start_threshold  : 32768
  stop_threshold   : 32768
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
underrun!!! (at least 97.039 ms long)
Status:
  state       : XRUN
  trigger_time: 1234296814.359013515
  tstamp      : 1234296814.456029856
  delay       : 0
  avail       : 32768
  avail_max   : 32768
Aborted by signal Interrupt...

I have underrun issues I need to look into as well. Perhaps some buffer
setting needs to be changed? This is on a Via platform so it doesn't have a
whole lot of power. Any suggestions would be appreciated. That is an area
where I have gotten very lost in the past.


Demian Martin
Product Design Services
784 Cary Drive
San Leandro, CA 94577
209 613 6990


-----Original Message-----
From: Pavel Hofman [mailto:pavel.hofman@insite.cz] =

Sent: Tuesday, February 10, 2009 7:35 AM
To: Vedran Mileti=E6
Cc: Demian Martin; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Juli@ ICE1724 and 24 bit audio

What makes you guys think the plug plugin trims the data down to 16bits? =

  Sure if the rate is changed (the source code suggests only the =

low-quality linear rate algorithm supports above-16bit format - =

operation convert, the other resampling algorithms convert using the =

operation convert_s16).

Ice1724 supports all the general rates natively, the rate conversion in =

the plug plugin should not kick in for common audio formats. The only =

case I can think of would be switching Juli to external SPDIF-IN clock - =

the hw.rate_min =3D hw.rate_max =3D actual_rate and the automatic rate =

conversion could happen.

I did not use the hw device in my tests since all the tested tracks =

would have to be 32-bit for the hw device to accept the format when =

played via my favorite aplay.

My 2 cents guess is xine does the conversion.

Regards,

Pavel.
