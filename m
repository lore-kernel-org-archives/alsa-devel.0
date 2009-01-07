From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ALSA: Add support for video out to the
	jack reporting API
Date: Wed, 7 Jan 2009 11:07:20 +0000
Message-ID: <20090107110720.GB16772@sirena.org.uk>
References: <1231322065-23337-1-git-send-email-ext-jani.1.nikula@nokia.com>
	<16517540c378d98be9727ce97b7803e686663bf2.1231319590.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D1BE41037F6
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 12:07:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <16517540c378d98be9727ce97b7803e686663bf2.1231319590.git.ext-jani.1.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2009 at 11:54:25AM +0200, Jani Nikula wrote:
> Add support for reporting new jack types SND_JACK_VIDEOOUT and
> SND_JACK_AVOUT (a combination of LINEOUT and VIDEOOUT) to the jack
> reporting API.

> Also add the corresponding SW_VIDEOOUT_INSERT switch to the input system
> header.

> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

I've applied this to my jack branch - I'd been intending to push once
the merge window closes.
