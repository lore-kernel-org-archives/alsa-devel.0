From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix inverted Bass, Treble,
	Mono volume and Phone volume WM9712 mixer controls.
Date: Tue, 20 Nov 2007 10:52:48 +0000
Message-ID: <20071120105247.GY21414@sirena.org.uk>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hfxz1jkmm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 831E9248D4
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 11:52:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxz1jkmm.wl%tiwai@suse.de>
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joe Sauer <jsauer@vernier.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 11:07:13AM +0100, Takashi Iwai wrote:

> We have already a patch to fix Mono and Bass/Treble on ALSA HG tree
> but only Phone volume seems missing.  Is it right?

Yes, that's right - the same fix was made independantly to ALSA and the
ASoC tree with these extra changes appearing in the version that was
submitted to ASoC.
