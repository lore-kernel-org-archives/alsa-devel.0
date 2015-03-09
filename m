From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ASoC: wm5100: match wait_for_completion_timeout return
	type
Date: Mon, 9 Mar 2015 07:22:26 +0100
Message-ID: <20150309062226.GA9226@opentech.at>
References: <1425812227-24172-1-git-send-email-hofrat@osadl.org> <20150308184902.GT28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150308184902.GT28806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 08 Mar 2015, Mark Brown wrote:

> On Sun, Mar 08, 2015 at 06:57:07AM -0400, Nicholas Mc Guire wrote:
> > return type of wait_for_completion_timeout is unsigned long not int. An
> > appropriately named unsigned long is added and the assignment fixed up.
> 
> You are sending these to a very large CC list many of whom have no
> obvious connection to the driver - please take care to ensure that the
> people you are sending patches to are likely to want to review the code,
> this helps keep people's mailboxes less noisy.

sorry if I messed that up - my understanding was that
it should go out to all that scripts/get_mainteiner.pl shows
for the espective file. Should some of those listed
not be put on the CC list - or only maintainers+mailinglists ?

thx!
hofrat
