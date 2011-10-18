From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Tue, 18 Oct 2011 13:55:19 +0100
Message-ID: <20111018125519.GB18713@sirena.org.uk>
References: <1318670595.613.42.camel@matrix>
	<20111017214242.GD5200@opensource.wolfsonmicro.com>
	<1318938548.13721.23.camel@matrix>
	<20111018120841.GA28501@opensource.wolfsonmicro.com>
	<1318940943.13721.25.camel@matrix>
	<20111018123124.GC28501@opensource.wolfsonmicro.com>
	<1318942828.13721.39.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F7A424556
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 14:55:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318942828.13721.39.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, David@alsa-project.org, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 06:30:28PM +0530, Ashish Chavan wrote:

> > Eh?  One is a Volume, the other is a Switch.  Note that alsamixer does
> > render the two stacked on top of each other in the UI.

> Yes, I guessed that earlier. Anyways I generally don't rely on alsamixer
> and use amixer whereever possible. In amixer also, it shows only one
> control, the one that I add first. If I change "Mic" to some thing else
> like "MicM" or "Mic Mute", then it shows both controls.

Check again, amixer also merges controls.

> BTW does amixer version have any significance here? I know my alsa-utils
> are quite old (1.0.14)

That's spectacularly old, I guess it's possible it's buggy.
