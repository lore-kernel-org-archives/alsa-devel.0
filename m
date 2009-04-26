From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Sun, 26 Apr 2009 13:30:48 +0200
Message-ID: <20090426113048.GA31947@buzzloop.caiaq.de>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
	<20090426094917.GA4760@sirena.org.uk>
	<s5hmya3wu3d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE4A2453C
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 13:30:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 01:08:22PM +0200, Takashi Iwai wrote:
> > Capture is enabled in the picture above; often when the alsamixer UI is
> > confusing amixer is a bit clearer about what's going on.
> 
> The "mute" is only for "* Playback Switch" mixer controls.  In this case,
> if you have "Master Playback Switch", it's handled as the mute switch
> in the mixer interface.  If you don't have such a control element,
> there is no "mute" for "Master" mixer element.

So but what about the polarity then? 'Master Playback Switch' == 'on'
means _not_ muted, right?

Daniel
