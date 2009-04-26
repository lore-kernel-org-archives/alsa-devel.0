From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Sun, 26 Apr 2009 10:49:17 +0100
Message-ID: <20090426094917.GA4760@sirena.org.uk>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DDC824495
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 11:49:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F1DE99.7050104@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 10:45:29AM -0500, Timur Tabi wrote:
> Daniel Mack wrote:
> > The control modifies the MUTE register, hence the polarity must be
> > inverted.

>                             L    R
>                             CAPTUR
> 
>                           < Master >

> What exactly does this mean?  Which one is supposed to mean "muted"?

Capture is enabled in the picture above; often when the alsamixer UI is
confusing amixer is a bit clearer about what's going on.

> And how come even though this switch is a SOC_DOUBLE, I cannot control
> the left and right channel independently with the < and > keys, and the
> "M" key doesn't toggle it either.

This is a property of capture controls.  I'm not entirely sure why,
CCing in Takashi who should be able to offer more knowledgable comment.
