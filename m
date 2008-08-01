From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to
	override	register display
Date: Fri, 1 Aug 2008 17:16:13 +0100
Message-ID: <20080801161613.GA2076@rakim.wolfsonmicro.main>
References: <1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de>
	<20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
	<9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D24A02439B
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 18:16:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 12:13:52PM -0400, Jon Smirl wrote:

> Allow external register display to suppress sparse registers

As I said when you originally proposed this I'm really not happy about
changing to that interface.

Adding explicit information about registers to skip and having this
function use it would be useful but munging it in makes the register
display function non-reusable and means that other parts of ASoC will be
unable to use the information about the void registers should they have
a use for it.
