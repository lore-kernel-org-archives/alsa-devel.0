From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Add support for video out to the
	jack reporting	API
Date: Mon, 5 Jan 2009 10:40:45 +0000
Message-ID: <20090105104044.GA13436@rakim.wolfsonmicro.main>
References: <1231144642-7689-1-git-send-email-ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E42C1037EE
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 11:40:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231144642-7689-1-git-send-email-ext-jani.1.nikula@nokia.com>
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

On Mon, Jan 05, 2009 at 10:37:22AM +0200, Jani Nikula wrote:
> Add support for reporting new jack types SND_JACK_VIDEOOUT and
> SND_JACK_AVOUT (a combination of LINEOUT and VIDEOOUT) to the jack
> reporting API.

> Also add the corresponding SW_VIDEOOUT_INSERT switch to the input system
> header.

> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Could you please regenerate this against the topic/jack-core branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git?
I've redone the way the ALSA idea of jacks is mapped to the input layer.
