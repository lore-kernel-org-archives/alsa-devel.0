From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Mon, 26 May 2008 11:07:55 +0100
Message-ID: <20080526100755.GB18721@sirena.org.uk>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080519171558.c37b980b.jarkko.nikula@nokia.com>
	<20080519183654.GB30712@sirena.org.uk>
	<20080520125325.b17ba0b3.jarkko.nikula@nokia.com>
	<20080522233414.GB31117@sirena.org.uk>
	<20080523110107.e1671a7c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23FEE248C0
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 12:07:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080523110107.e1671a7c.jarkko.nikula@nokia.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 23, 2008 at 11:01:07AM +0300, Jarkko Nikula wrote:

> Now snd_soc_dapm_device_event calling codec->dapm_event seems to be
> stream centric only. How about the case if only bypass path is active?
> Also then biases should be managed?

Yes, for best performance.  However, it will need a more detailed look
before changing anything due to the behaviour change if nothing else.
