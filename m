From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: handle an external PWM amplifier via alsa interface
Date: Tue, 27 Jan 2009 11:44:43 +0000
Message-ID: <20090127114423.GC1794@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 371501037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:44:46 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matteo Canella <matteo.canella@mta.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 11:15:48AM +0100, Matteo Canella wrote:

> I'm trying to implement an alsa interface for the audio section of my board.
> I have an mpc5200 that control via i2s a pcm1774 stereo DAC and I also have
> an amplifier between the DAC and the speakers.
> At the moment I have the pcm1774 driver properly working, but I have a few
> ideas on how to integrate the control of the external amplifier in the alsa
> structure. I need to set the amplifier level with a PWM input to it.

> Now I'm trying to use "non dapm" controls, adding the PWM settings into this
> structure...

> What do you guys think about this?
> Am I completely wrong or could this be a good way?

Using a non-DAPM control to set gain sounds sensible.  Depending on how
exactly this works you may want to also have a DAPM control so you can
power the amplifier off when the path isn't in use (though your
application may not be sufficiently sensitive to power consumption to
make it worth bothering or the hardware may not let you do anything
useful).
