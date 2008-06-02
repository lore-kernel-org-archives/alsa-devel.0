From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Make Freescale MPC8610 drivers
	more dynamic
Date: Mon, 2 Jun 2008 15:42:37 +0100
Message-ID: <20080602144235.GA29975@sirena.org.uk>
References: <1212187311-22901-1-git-send-email-timur@freescale.com>
	<20080602110101.GE9031@rakim.wolfsonmicro.main>
	<48440123.5070508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67CB9245EC
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 16:42:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48440123.5070508@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 02, 2008 at 09:18:11AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > This change means that if someone builds another board with the same CPU
> > on it then they'll have to add all the objects for the core CPU support
> > to the Makefile entry for their board.

> They'll need to update Kconfig and the Makefile anyway, so I decided to cut out
> the "middle man" -- the SOC.

[As discussed on IRC, summarising for the list archive.]

For the user-visible menu that's sensible enough - the issue is more
with the fact that you've now got the CPU side objects encoded into each
individual board entry rather than having the board build machinery say
"I need the SSI controller" or similar.

> > though I
> > appreciate that at the minute you're making a lot of changes that go
> > over large portions of the code and can't be easily separated out so I
> > wouldn't worry about it too much.

> Normally, I would submit everything as one final patch, but I hate hanging on to
> uncommitted code for too long.

It's not the submitting individual patches that I was meaning, it's the
fact that individual patches cover multiple issues.
