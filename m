From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Emulated IEC958 Card
Date: Fri, 17 Sep 2010 13:27:24 +0100
Message-ID: <20100917122724.GA29739@sirena.org.uk>
References: <AANLkTi=52wHCZZNSBitaMO+O6--JLHg7nmtNOVYQ6cof@mail.gmail.com>
	<AANLkTi=oECj18_gWM-16YTHrCOE-=nTnG9L0CummTdvh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D3C6F24475
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 14:27:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=oECj18_gWM-16YTHrCOE-=nTnG9L0CummTdvh@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, yadi brar <yadi.brar01@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 09:20:16PM +0900, Jassi Brar wrote:

> I would really appreciate your take on the idea if you could spare a
> few moments please.
> Actually I just might get our AP design folks to implement such a
> dedicated shifter IP in later SoC.
> Also, I don't wanna direct the bloke(Angat) in a direction that is
> outright unacceptable
> to maintainers -- if it is so.

The idea of having a full IEC958 emulation layer that just needs a
generic serial port or shifter accessed through some standard interface
seems entirely sensible.  This isn't so different to what things like
the McBSP, PXA SSP or FSL SSI ports do.
