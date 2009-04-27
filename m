From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 14:57:37 +0100
Message-ID: <20090427135737.GA20591@sirena.org.uk>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7150524570
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 15:57:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 09:50:01AM -0400, Jon Smirl wrote:
> On Mon, Apr 27, 2009 at 5:25 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Does that patch need merging for 2.6.30 (you said I2S was broken)?

> Grant and I are the only two active users of I2S and we're passing
> patches to each other.  I don't have I2S completely fixed yet.

> I'll post a series today that reorgs things to make my real patches

If you're reorganising the code that's not really suitable for 2.6.30.

> My real patches fix up i2s and implement ac97.

It sounds like we need fixed I2S for 2.6.30 and then a 2.6.31 series
which does the reorganising and addition of AC97 support.
