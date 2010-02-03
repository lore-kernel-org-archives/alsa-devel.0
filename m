From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [Q] playing / recording mono on a stereo-only
 hardware
Date: Wed, 3 Feb 2010 23:11:21 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002032310230.19438@axis700.grange>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
	<4B645E51.900@gandalf.sssup.it>
	<Pine.LNX.4.64.1001301744580.9593@axis700.grange>
	<4B683B48.1030707@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021552450.6324@axis700.grange>
	<4B683DDC.5030209@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021606340.6324@axis700.grange>
	<4B6843E1.4050001@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021733550.6324@axis700.grange>
	<4f3252891002021807x4276d0b8y4c61c69aee2af3dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 66A30103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 23:11:33 +0100 (CET)
In-Reply-To: <4f3252891002021807x4276d0b8y4c61c69aee2af3dc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Feb 2010, Raymond Yau wrote:

> 2010/2/3 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> > On Tue, 2 Feb 2010, Michael Trimarchi wrote:
> >
> > > I have tested it on the no-bluetooth interface. What is your testing
> > > application and the reporting error?
> >
> > Using aplayer / arecord, I posted a couple of logs in other threads, see,
> > e.g., http://thread.gmane.org/gmane.linux.alsa.user/33861 and a log with
> > some debugging http://pastebin.ca/1773284
> >
> > Thanks
> > Guennadi
> >
> 
>  Try
> 
> export LIBASOUND_DEBUG=1
> arecord -v -Dplughw:0,0 -c 1 -f S16_LE -r 800 -d 30  any.wav

No success either (with 8000Hz instead of 800):

Recording WAVE '/tmp/any.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, 
Mono
CHOOSE called:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: ALL
choose done
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: 0
arecord: set_params:1053: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: 0

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
