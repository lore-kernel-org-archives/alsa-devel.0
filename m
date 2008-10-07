From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: size of snd_hda_intel
Date: Tue, 7 Oct 2008 11:22:07 +0100
Message-ID: <20081007102205.GC19835@sirena.org.uk>
References: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
	<fd3eb9bf0810060128y3af886e0m1ad2c39b0f9c78f1@mail.gmail.com>
	<9e4733910810061829h3f607e99s73857005e7ace514@mail.gmail.com>
	<s5hljx0okzp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 80DA8103818
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 12:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hljx0okzp.wl%tiwai@suse.de>
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
Cc: Vedran Mileti? <rivanvx@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 10:41:30AM +0200, Takashi Iwai wrote:
> Jon Smirl wrote:

> > The base intel hda module would include code to figure out which codec
> > is attached. It can then use loadmodule() to dynamically load it. ASOC
> > use the separate codec driver model.

> You mean AOA?
> ASoC doesn't do any dynamic module handling by itself, AFAIK.

It does this through reuse of the standard module loader - the machine
drivers all have references to the codec and platform driver modules so
providing something can figure out how to load the only relevant machine
driver only the codec and platform drivers for that machine will be
loaded.

v2 pretty much keeps on with the same model, though codec and platform
drivers will be able to be instantiated via means other than the machine
drivers.
