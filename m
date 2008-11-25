From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][PATCH 0/2] ASoC: OMAP: Add support
	for mono audio links in McBSP DAI (take #2)
Date: Tue, 25 Nov 2008 15:13:53 +0000
Message-ID: <20081125151351.GF12414@sirena.org.uk>
References: <1227609909-25273-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CB4A824475
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:13:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227609909-25273-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 25, 2008 at 12:45:07PM +0200, Jarkko Nikula wrote:

> Second version adding support for mono audio links in OMAP McBSP DAI. At this
> time, the channels_min is defined to 1 in omap-mcbsp.c and no hacks in
> machine drivers wanting to use mono link are required.

> If channel restrictions are required, then machine driver can use
> snd_pcm_hw_constraint_minmax. Now only N810 machine driver is affected since
> all other OMAP machine drivers are using TWL4030 or TLV320AIC23 codecs which
> all claim to support only 2 channels so the link remains always stereo even
> playing mono audio.

Applied both, thanks.
