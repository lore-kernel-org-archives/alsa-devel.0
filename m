From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Add drivers for the Texas
	Instruments OMAP	processors
Date: Tue, 22 Apr 2008 19:38:42 +0100
Message-ID: <20080422183842.GA7437@opensource.wolfsonmicro.com>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskxe9dvs.wl%tiwai@suse.de>
	<20080422144331.GB5242@rakim.wolfsonmicro.main>
	<s5hlk369bvu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46C30245F8
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 20:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlk369bvu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 22, 2008 at 04:56:21PM +0200, Takashi Iwai wrote:

> The problem is that it wasn't passed through mm tree at all.

Oh, I see.  I had thought that you already maintained a separate -mm
tree.  Looking again it seems your linus tree is actually just for
backported fixes rather than a general submission to Linus tree.  I
must've looked at it at the wrong point in the cycle when figuring these
things out.

> If the stuff has to cooperate with the changes in other trees, pass it
> seprately to Andrew (or give me a hint) so that it's put to mm tree
> rightly at the next time.

I could also ask Andrew to pull the ASoC upstream branch (which is based
off the ALSA -mm branch) and keep any dodgy commits there without
e-mailing you.  I'm not sure if having a branch rebased off another
branch he's pulling would be too clever, though, but that would probably
be the lowest maintinence option.
