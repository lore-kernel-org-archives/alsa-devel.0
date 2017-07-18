From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI
	assignments"
Date: Tue, 18 Jul 2017 12:36:29 +0200
Message-ID: <20170718103629.GI29638@localhost>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
 <20170717145127.ke5o65as35itamaf@sirena.org.uk>
 <20170718082118.GG29638@localhost>
 <20170718100655.topzzdu6n7rd6euk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 85EE92664EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 12:36:21 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id t72so1357389lff.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 03:36:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170718100655.topzzdu6n7rd6euk@sirena.org.uk>
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

On Tue, Jul 18, 2017 at 11:06:55AM +0100, Mark Brown wrote:
> On Tue, Jul 18, 2017 at 10:21:18AM +0200, Johan Hovold wrote:
> > On Mon, Jul 17, 2017 at 03:51:27PM +0100, Mark Brown wrote:
> 
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem.  This makes it easier for people to identify relevant
> > > patches.  Look at what existing commits in the area you're changing are
> > > doing and make sure your subject lines visually resemble what they're
> > > doing.
> 
> > I try to, but reverts are special as the default commit summary tend to
> > already contain the subsystem prefix and some maintainers find that
> > sufficient (or even preferred as this also makes reverts stand out more
> > clearly).
> 
> Reverts shouldn't be special - they're just regular patches and should
> have sensible changelogs like any others.

Stating that you're reverting a commit and which commit that is is in
the summary is arguable sensible (of course, you still also need further
details in the commit message body itself describing why it was needed).

Check the logs and you'll see that we have a ton of "Revert <reverted
commit summary>" for various subsystems. In fact, it seems to be by far
the most common summary for direct reverts.

But again, now I know your preference.

Johan
