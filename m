From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Consider the codec->active also	when
	changing bias level
Date: Mon, 28 Sep 2009 12:17:36 +0100
Message-ID: <20090928111735.GA32420@sirena.org.uk>
References: <1254130688-6183-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 96CED103835
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 13:17:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254130688-6183-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 28, 2009 at 12:38:08PM +0300, Peter Ujfalusi wrote:

> Fixes the following scenario: if during active playback/capture the DAPM
> routes has been modified in a way, that there will be no complete route
> (for example muting the output) DAPM would set the codec into
> BIAS_STANDBY, which could disable the clocks from the codec (codec is
> master), which breaks the playback with error since the clocks are
> missing from the serial bus and no data is shifted out/in.

This is only helping because the clocks generation is controlled by the
bias level configuration.  That's not really the way things are supposed
to work - I'd rather see a different fix that explicitly represents
whatever the requirement is for controlling the clocks.  Turning on the
clocks based on the bais level will generally result in them being
turned on too much which will waste power.

I suspect you want to use AIF widgets and make the PLL a supply for them
and any other things that need the PLL, and we should make arrangements
to ensure that the AIF widget is enabled whenever the interface is live
and the CODEC is master.
