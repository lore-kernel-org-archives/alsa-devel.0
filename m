From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Confusion about Playback/Capture, CODEC/CODEC	links,
	and snd_soc_dapm_link_dai_widgets()
Date: Tue, 5 Jun 2012 21:48:01 +0100
Message-ID: <20120605204758.GA8486@opensource.wolfsonmicro.com>
References: <4FC7F576.30101@wwwdotorg.org> <4FCE6B0F.6080106@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E5811043A6
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 22:48:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FCE6B0F.6080106@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 05, 2012 at 02:24:47PM -0600, Stephen Warren wrote:

> Initially, I thought that snd_soc_dapm_new_dai_widgets() could just
> return if the DAI already had widgets, but that doesn't work, since the
> widgets were created for the wrong DAPM context - the I2S1 DAP DAI's
> rather than the I2S CODEC's.

> Perhaps instead of blindly probing the CPU DAI, soc_probe_dai_link()
> should check whether that DAI is part of a CODEC, and instead of calling
> try_module_get() and snd_soc_dapm_new_dai_widgets(), it should just call
> soc_probe_codec() on the parent CODEC (guarded by whether the CODEC was
> already probed). Does that sound right? I'm attempting to make that work
> now, in case it's right.

No, we should just probe CODECs sensibly before we do any of the DAIs
instead of trying to guess what we're doing in the middle of handling
the DAI links.  Your changes will be making the logic even more
complicated here, it should be getting simpler - the reason this blew up
for you is that the probe logic is already far too baroque.  Given the
data we have it'll boil down to similar checks bit it'll be in a clear,
comprehensible CODEC probe step rather than intertwined with other
stuff.  This will also mean that aux_devs make more sense.
