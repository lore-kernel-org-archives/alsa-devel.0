From: "Steve Langstaff" <steve.langstaff@pebblebay.com>
Subject: Re: plug:dmix slows playback
Date: Fri, 12 Jun 2009 11:28:38 +0100
Message-ID: <47026.1972900063$1244802567@news.gmane.org>
References: <000001c9eb46$24a60d30$6df22790$@langstaff@pebblebay.com>
	<alpine.LNX.2.00.0906121213520.13028@eeebox2.perex-int.cz>
Reply-To: steve.langstaff@pebblebay.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ares.krystal.co.uk (ares.krystal.co.uk [77.72.0.130])
	by alsa0.perex.cz (Postfix) with ESMTP id AC4D124672
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 12:28:42 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0906121213520.13028@eeebox2.perex-int.cz>
Content-Language: en-gb
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Jaroslav Kysela

> On Fri, 12 Jun 2009, Steve Langstaff wrote:
> 
> > Hi All.
> >
> > I've got an installation of ALSA (1.0.19 on an embedded device) where
> using
> > plug and dmix as my output device slows down playback - voices and
> tones are
> > lower in pitch and the playback takes longer than when not using
> plug:dmix,
> > e.g.
> 
> Does 48000Hz 2 channel source work OK with direct device (without dmix)
> for your hardware?

Yes, I converted the original sample to 48000 Hz, Stereo, and it sounds OK
when I don't use dmix.

/mnt # time aplay -v ignition48000s.wav
Playing WAVE 'ignition48000s.wav' : Unsigned 8 bit, Rate 48000 Hz, Stereo
Plug PCM: Linear conversion PCM (S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 24480
  period_size  : 2040
  period_time  : 42500
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2040
  period_event : 0
  start_threshold  : 24480
  stop_threshold   : 24480
  silence_threshold: 0
  silence_size : 0
  boundary     : 1604321280
Slave: Hardware PCM card 0 'LM4549' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24480
  period_size  : 2040
  period_time  : 42500
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2040
  period_event : 0
  start_threshold  : 24480
  stop_threshold   : 24480
  silence_threshold: 0
  silence_size : 0
  boundary     : 1604321280
  appl_ptr     : 0
  hw_ptr       : 0
real    0m 3.02s
user    0m 0.07s
sys     0m 0.02s
