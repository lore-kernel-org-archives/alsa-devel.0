From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: Add jack reporting API
Date: Mon, 28 Jul 2008 18:47:25 +0100
Message-ID: <20080728174723.GA7141@sirena.org.uk>
References: <1217263836-1270-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hr69eaqow.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B695D10388F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jul 2008 19:47:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr69eaqow.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2008 at 07:01:19PM +0200, Takashi Iwai wrote:

> They are bitmask, so HEADSET should be better defined as
> SND_JACK_HEADPHONE | SND_JACK_MICROPHONE ?

Done.

> > +void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
> > +{
> > +	BUG_ON(jack->registered);

> I'm afraid BUG_ON() is brutal for this kind of check.

I'll change it down to a WARN_ON() but I do feel that this is something
that should be complained about loudly, it's a clear error to try to
reparent the instantiated device.
