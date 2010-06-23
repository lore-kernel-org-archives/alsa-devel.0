From: David Dillow <dave@thedillows.org>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Wed, 23 Jun 2010 01:36:59 -0400
Message-ID: <1277271419.10818.22.camel@obelisk.thedillows.org>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
	<1277262047.10818.9.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id F2B9D1037EC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 07:37:07 +0200 (CEST)
In-Reply-To: <1277262047.10818.9.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux@schou.dk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-06-22 at 23:00 -0400, David Dillow wrote:
> On Mon, 2010-06-21 at 22:10 +0200, Hans Schou wrote:
> > 2010/6/21 Hans Schou <linux@schou.dk>:
> > 
> > > I have just started:
> > >  arecord -B 1000000 -F 500000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
> > 
> > It gave a file size of 258822944 bytes. Almost 50 min:
> >   echo "258822944/(2*60*44100)" | bc -ql
> > 48.90
> > 
> > This is the longest recording I have made on this hardware.
> > 
> > I have this running now:
> > + arecord -B 200000 -F 100000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
> 
> Ok, it seems something is definately funky with the driver in general,
> and gets worse when we're using more than 2 periods per buffer.

The driver's funkiness may be limited to the more than 2 periods per
buffer/10 second pause issue.

> I don't have any overruns, nor does it go into the 10-second pause mode.
> I do see an odd alternating pattern of one period taking 1.4ms to
> capture, and the next taking 732ms. The period should be about 371ms, so
> the lumpyness of the timing is likely making it easier to hit overruns.

I can reproduce the alternating pattern of periods using a different
device, so this may be something in the core code of ALSA.

Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 32768
  period_size  : 16384
  period_time  : 371519
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 16384
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 32768
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0

strace -T gives:
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.371672>
write(1, ..., 65536) = 65536 <0.000035>
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.742746>
write(1, ..., 65536) = 65536 <0.000013>
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.000027>
write(1, ..., 65536) = 65536 <0.000016>
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.742694>
write(1, ..., 65536) = 65536 <0.000011>
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.000038>
write(1, ..., 65536) = 65536 <0.000024>
ioctl(4, 0x80184151, 0x7fff532cff70) = 0 <0.742600>

The first period gets clocked out close to the expected time --
371.672ms actual vs 371.519 ms expected -- but then we're either running
almost a full buffer -- 742.746ms actual vs 743.038ms buffer -- or very,
very short at 0.027ms.

Since this problem is not related to the SiS7019 driver, I'll leave it
to later -- or for others to investigate. Using three periods per buffer
sees a similar pattern, but one has an extra period time to work
within. 

Dave
