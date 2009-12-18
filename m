From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsa device drain power
Date: Fri, 18 Dec 2009 11:32:26 +0000
Message-ID: <20091218113225.GD19544@sirena.org.uk>
References: <4B29F03F.4020100@gandalf.sssup.it>
	<20091217110334.GB12245@sirena.org.uk>
	<4B2B536F.4060800@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D414A1038B8
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 12:32:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B2B536F.4060800@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2009 at 11:03:27AM +0100, Michael Trimarchi wrote:

> As reported by the datasheet the LM4853 has a bias circuitry shutdown.
> This shutdown function is activated by applying a logic high to the
> SHUTDOWN pin. This pin as command by the

So this is an ASoC-specific question, not a generic ALSA one...

> static int lm4853_event(struct snd_soc_dapm_widget *w,
>                         struct snd_kcontrol *k,
>                         int event)

> in gta02. I don't put any debug stuff there but I suppose
> if I open the device with and asound.conf that set
> the value to true of the Stereo Out this event is called. Is it right?

ASoC will only power things up if they're being used so setting that
control may or may not power things up.  I'm still not sure what you're
getting at with these questions - are you experiencing some problem, or
is this just a case of getting things straight in your head?
