From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc-v2 ac97-wm9713 suspend/resume
Date: Mon, 23 Jun 2008 02:21:54 +0100
Message-ID: <20080623012152.GA21357@sirena.org.uk>
References: <485E890D.2070307@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B2292482D
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 03:21:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <485E890D.2070307@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 22, 2008 at 06:17:01PM +0100, Oliver Ford wrote:

> To make the touchscreen work after suspend I had to add a cold reset to 
> sound/soc/wm9713.c : wm9713_resume().

You should do this in your machine driver - the decision about doing a
cold reset depends heavily on the system.  Some systems will require it
but others (especially those where the WM9713 is a wakeup source) would
be broken by extra cold resets.  This is as much about what the AC97
controller needs on a given system as anything else.

> Also I have to remove the calls to snd_soc_card_suspend_pcms() and
> snd_soc_card_resume_pcms() from my hpipaq214-audio.c's normal
> suspend/resume functions. These calls were originally in
> sound/soc/pxa/zylonite.c but I notice there is now no suspend/resume
> functions in there. Some of the other platform audio drivers call

There are (or were at the time I last worked on ASoC v2 Zylonite)
suspend and resume issues in the base Zylonite machine support so I
removed the suspend/resume code until it can be tested - IIRC the code
was never even compiled.

> Only snd_soc_suspend_pcms() seems to actually exists. If I do actually 

snd_soc_card_resume_pcms() appears to exist in the current branch?

> call snd_soc_card_suspend/resume_pcms() then any use of the audio or 
> touchscreen later on freezes the process doing it.

The audio needs to be the very last thing that is suspended since the
codec driver does the final power off of the AC97 bus - once that has
happened nothing will be able to access the codec until at least a warm
reset has been completed.

> Which am I actually supposed to do, and is there a more 'proper' way way 
> of bringing the wm9713 back up from complete power down on resume?

What you're doing seems reasonable.

The most complete worked example of an ASoC v2 driver is the
i.MX31ADS/WM8350 driver in sound/soc/imxa31/imx31ads-wm8350.c in the
imx31 branch of

	git://opensource.wolfsonmicro.com/linux-2.6-audioplus

(it's in a separate place because the base i.MX machine support
currently needs a Freescale vendor kernel).
