From: Louis Lee <lwhlee@hotmail.com>
Subject: Re: ALSA SoC driver playback twice as fast as desired
Date: Mon, 6 Jul 2009 14:03:31 -0600
Message-ID: <COL102-W384376C56DD69BA58C7D8BD02B0@phx.gbl>
References: <COL102-W20FDDBC628826434E806E9D02F0@phx.gbl>
	<20090704094943.GB10490@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc4-s15.col0.hotmail.com (col0-omc4-s15.col0.hotmail.com
	[65.55.34.217]) by alsa0.perex.cz (Postfix) with ESMTP id D8FD0244A8
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 22:03:35 +0200 (CEST)
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

  I set the DAI to support Stereo and magically it plays the files properly with the correct timing!!

  I took your recommendation as well.  I setup the SSI and code in DSP mode instead of I2S mode and everything plays back fine as expected.

  Thanks for your help, I'd have never figured that out!

Regards,
Louis

_________________________________________________________________
We are your photos. Share us now with Windows Live Photos.
http://go.microsoft.com/?linkid=9666047
