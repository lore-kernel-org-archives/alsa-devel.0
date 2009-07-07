From: Louis Lee <lwhlee@hotmail.com>
Subject: Re: ALSA SoC driver playback twice as fast as desired
Date: Tue, 7 Jul 2009 11:57:24 -0600
Message-ID: <COL102-W3042238906FC802AF962FED0280@phx.gbl>
References: <COL102-W20FDDBC628826434E806E9D02F0@phx.gbl>
	<20090704094943.GB10490@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc4-s15.col0.hotmail.com (col0-omc4-s15.col0.hotmail.com
	[65.55.34.217]) by alsa0.perex.cz (Postfix) with ESMTP id 4A1892438C
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 19:57:25 +0200 (CEST)
In-Reply-To: <20090704094943.GB10490@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: ALSA Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> Date: Sat, 4 Jul 2009 10:49:43 +0100
> From: broonie@opensource.wolfsonmicro.com
> To: lwhlee@hotmail.com
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] ALSA SoC driver playback twice as fast as desired
> 
> On Thu, Jul 02, 2009 at 04:24:17PM -0600, Louis Lee wrote:
> 
> >   I'm out of ideas as to where to look.  The DAI interface is set as a I2S slave.  The clock is mastered by the Codec (WM8974).  I've set up min_channels and max_channels to be 1 whereever possible.  On a scope the clocking seems to be at the right speed.  Why is it sound is playing twice as fast?  Any ideas?  Any help is appreciated.
> >   WM8974 is a mono codec.  The SSI bus on the i.MX27 is set to I2S slave mode with a 16 bit word length.  The word length on the codec is set to 16 bits.  The audio interface on the codec is set to I2S, sample rate coded to do only 48kHz.
> 
> If you're running in I2S mode try playing back a stereo file instead -
> you'll need to adjust the capabilities of all the DAIs to say they
> support stereo.  I suspect that the CPU side is trying to play back
> stereo data and so plays back two samples for every frame (one in the
> left channel and one in the right channel) which would give double speed
> playback.
> 
> For mono data it's easier to use one of the DSP modes.

Hi Mark,
   I did get the playback working with your recommendations.  Thanks again.
  What's really strange is that this behavior is still present on the capturing of audio.
  I try to capture audio and the captured audio file turns out to be twice as long as the actual audio file.  A 5 second audio file becomes a 10 second audio file.  My voice in the file is stretched.  I tried the experiment of setting the capabilities of the DAI to support stereo and recorded a file and it played at the normal speed.  The volume of the audio is a bit low but the overall result audio quality was okay (not sure if that is relevant).
  SSI is set to DSP mode.  Control bus is SPI.  SSI and codec word lengths are coded as 16 bits.  The clock is mastered by the codec.  All the registers for DMA, SSI and SPI access seem to be setup correctly.
  Once again, the WM8974 is a mono codec.  What could I start looking for?  Any help is appreciated.
Thanks,Louis
_________________________________________________________________
Windows Live helps you keep up with all your friends, in one place.
http://go.microsoft.com/?linkid=9660826
