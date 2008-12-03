From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] leds: Add WM8350 LED driver
Date: Wed, 3 Dec 2008 13:29:26 +0000
Message-ID: <20081203132925.GD2556@sirena.org.uk>
References: <20081203132005.GA5943@rakim.wolfsonmicro.main>
	<1228310694-6082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B311D1037EC
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 14:29:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 03, 2008 at 01:24:50PM +0000, Mark Brown wrote:
> The voltage and current regulators on the WM8350 AudioPlus PMIC can be
> used in concert to provide a power efficient LED driver.  This driver
> implements support for this within the standard LED class.

Gah, sorry - this was lying about in the directory when I did git
send-email.  It's not in the branch advertised.
