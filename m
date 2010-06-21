From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 22:10:20 +0200
Message-ID: <AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E79AB2444F
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 22:10:41 +0200 (CEST)
Received: by wwb13 with SMTP id 13so514017wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 13:10:40 -0700 (PDT)
In-Reply-To: <AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/21 Hans Schou <linux@schou.dk>:

> I have just started:
> =A0arecord -B 1000000 -F 500000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec=
.wav

It gave a file size of 258822944 bytes. Almost 50 min:
  echo "258822944/(2*60*44100)" | bc -ql
48.90

This is the longest recording I have made on this hardware.

I have this running now:
+ arecord -B 200000 -F 100000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
Recording WAVE 'arec.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
Hardware PCM card 0 'SiS7019' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 8820
  period_size  : 4410
  period_time  : 100000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 4410
  xfer_align   : 4410
  start_threshold  : 1
  stop_threshold   : 8820
  silence_threshold: 0
  silence_size : 0
  boundary     : 1244678400

and no overrun within 2 min.

/hans
