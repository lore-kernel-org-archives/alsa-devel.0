From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH for-3.2 2/2] ASoC: Davinci: Fix FS polarity
	for I2S format
Date: Fri, 30 Sep 2011 12:49:57 +0100
Message-ID: <20110930114957.GA5366@opensource.wolfsonmicro.com>
References: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
	<1317369333-20814-2-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A5622446D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 13:50:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317369333-20814-2-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Kevin Hilman <khilman@ti.com>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 10:55:33AM +0300, Jarkko Nikula wrote:
> Commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the dai_link")
> changed DAI format flag values and we cannot simply invert anymore e.g.
> frame-sync with ^= SND_SOC_DAIFMT_NB_IF (which was anyway misuse) as there
> is no anymore fixed bit position for bit-clock or frame-sync inversion.
> 
> Fix this by relying only on DAI format flag values passed to us and by not
> making any assumption on individual bit positions

This doesn't apply against for-3.2.
