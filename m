From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add WM8580 CODEC driver
Date: Wed, 6 Aug 2008 15:18:22 +0100
Message-ID: <20080806141821.GA31889@rakim.wolfsonmicro.main>
References: <1218025106-1360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h63qeqnxa.wl%tiwai@suse.de>
	<20080806133532.GC26169@sirena.org.uk>
	<s5h1w12qlnr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78B5B103865
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 16:18:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1w12qlnr.wl%tiwai@suse.de>
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

On Wed, Aug 06, 2008 at 04:10:32PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Doing this conversion is on my todo list but getting at least enough of
> > v2 merged to allow dynamic codec driver registration should probably be
> > done first.

> OK, then I'll apply your patch as is.
> Let's see whether we do convert them soon later or wait for ASoC v2.

I've got a half done merge of dynamic codec registration which should be
the next bit of v2 to get backported - it should make it for 2.6.28 at
the very least.
