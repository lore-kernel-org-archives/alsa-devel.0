From: Andreas Mohr <andi@lisas.de>
Subject: Re: Bugs on aspire one A150
Date: Fri, 20 Mar 2009 19:56:40 +0100
Message-ID: <20090320185640.GA17278@rhlx01.hs-esslingen.de>
References: <20090316212227.GA29471@rhlx01.hs-esslingen.de>
	<s5hfxhczinh.wl%tiwai@suse.de>
	<20090317100500.GA16029@rhlx01.hs-esslingen.de>
	<20090317103845.GA26007@rhlx01.hs-esslingen.de>
	<20090317104755.GA1446@rhlx01.hs-esslingen.de>
	<s5h3adcpf1i.wl%tiwai@suse.de>
	<20090317161828.GA32756@rhlx01.hs-esslingen.de>
	<s5h3adbhovj.wl%tiwai@suse.de>
	<20090318090507.GA30453@rhlx01.hs-esslingen.de>
	<s5hsklbchmu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BBA52414C
	for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2009 19:56:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsklbchmu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kernel Testers List <kernel-testers@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Mar 18, 2009 at 10:19:53AM +0100, Takashi Iwai wrote:
> At Wed, 18 Mar 2009 10:05:07 +0100,
> Andreas Mohr wrote:
> > 
> > Hi,
> > 
> > On Tue, Mar 17, 2009 at 09:32:16PM +0100, Takashi Iwai wrote:
> > > Don't use -Dplughw:0.  Then the default setup will be used.
> > > 
> > > 	% arecord -fdat -c1 test.wav
> > 
> > Tried that, didn't help. /usr/share/alsa/cards/HDA-Intel.conf still
> > contains the patch, but equal Capture Volume sliders still silenced
> > audio input, whereas non-equal worked. Hmm.
> 
> What is the output with -v option?

Sorry for the delay!

$ arecord -fdat -c1 -v test.wav; aplay test.wav 
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
^CAborted by signal Interrupt...
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
andi@andinet:/tmp$ 


Hmm. Note the pulseaudio stuff above...


I did verify that this test run using -v did exhibit failure again.

Thanks,

Andreas
