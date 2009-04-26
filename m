From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master
	Capture	Switch polarity
Date: Sun, 26 Apr 2009 12:21:37 +0100
Message-ID: <20090426112137.GA20714@sirena.org.uk>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
	<20090426094917.GA4760@sirena.org.uk>
	<s5hmya3wu3d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AB4424533
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 13:21:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmya3wu3d.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 01:08:22PM +0200, Takashi Iwai wrote:

> OTOH, "* Capture Switch" is handled as "capture" switch, which is
> indicated as "CAPTURE" (and "L" & "R") in the above.  Also, if the

Right; however the effect of a capture switch is pretty much equivalent
to mute for a playback control.

> The keys you mentioned above are all for playback mute controls, thus
> irrelevant with the capture switch.  User space key to toggle the
> capture switch.

That doesn't quite answer Timur's question - the question was more why
capture switches are being presented to the user as mono controls even
when the two channels can be switched independantly.
