From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI
	assignments"
Date: Tue, 18 Jul 2017 10:21:18 +0200
Message-ID: <20170718082118.GG29638@localhost>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
 <20170717145127.ke5o65as35itamaf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C3E55266C40
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 10:21:10 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id t72so1002243lff.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 01:21:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170717145127.ke5o65as35itamaf@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, stable <stable@vger.kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 17, 2017 at 03:51:27PM +0100, Mark Brown wrote:
> On Wed, Jul 12, 2017 at 05:55:30PM +0200, Johan Hovold wrote:
> > This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
> > assignments"), which seems to have been based on a misunderstanding and
> > prevents the platform driver callbacks from being made (e.g. to
> > preallocate DMA memory).
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

I try to, but reverts are special as the default commit summary tend to
already contain the subsystem prefix and some maintainers find that
sufficient (or even preferred as this also makes reverts stand out more
clearly).

But now I know your preference, and thanks for fixing it up this time
before applying.

Johan
