From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA SoC driver playback twice as fast as desired
Date: Sat, 4 Jul 2009 10:49:43 +0100
Message-ID: <20090704094943.GB10490@sirena.org.uk>
References: <COL102-W20FDDBC628826434E806E9D02F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADE41037ED
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 11:49:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <COL102-W20FDDBC628826434E806E9D02F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Louis Lee <lwhlee@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 02, 2009 at 04:24:17PM -0600, Louis Lee wrote:

>   I'm out of ideas as to where to look.  The DAI interface is set as a I2S slave.  The clock is mastered by the Codec (WM8974).  I've set up min_channels and max_channels to be 1 whereever possible.  On a scope the clocking seems to be at the right speed.  Why is it sound is playing twice as fast?  Any ideas?  Any help is appreciated.
>   WM8974 is a mono codec.  The SSI bus on the i.MX27 is set to I2S slave mode with a 16 bit word length.  The word length on the codec is set to 16 bits.  The audio interface on the codec is set to I2S, sample rate coded to do only 48kHz.

If you're running in I2S mode try playing back a stereo file instead -
you'll need to adjust the capabilities of all the DAIs to say they
support stereo.  I suspect that the CPU side is trying to play back
stereo data and so plays back two samples for every frame (one in the
left channel and one in the right channel) which would give double speed
playback.

For mono data it's easier to use one of the DSP modes.
