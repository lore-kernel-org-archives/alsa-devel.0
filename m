From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia	ETI-B1
	board
Date: Tue, 30 Sep 2008 19:25:20 +0100
Message-ID: <20080930182520.GB3338@sirena.org.uk>
References: <48E23AE0.3040805@endrelia.com>
	<bd7b27490809300810n77b82690j4ddedb0a0f7108ac@mail.gmail.com>
	<48E2481D.6030208@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9BFB24599
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 20:25:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E2481D.6030208@endrelia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: alsa-devel@alsa-project.org, Sedji Gaouaou <sedji.gaouaou@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2008 at 11:39:09AM -0400, Frank Mandarino wrote:
> Jarkko Nikula wrote:

> > Does it make sense to remove these yet? I didn't check different
> > architectures in asoc-dev but are there any other platform and machine
> > driver using multiple DAI links with real and "dummy" codec in ASoC v1?

There's also an out of tree Mainstone Bluetooth driver which does the
same thing (in the pxa directory in ASoC git).

> > In that sense these are nice reference implementations :-)

Quite frankly nice isn't the first adjective that springs to my mind
for how this stuff works in v1.  As with so many other things once v2
is in that should make life better.

> My reasons for wanting it removed are that 1) it only works on our
> proprietary board, and 2) I don't have time to maintain it as changes
> are made to ASoC.

I tend to agree with Frank here - if it's causing too much work for the
people with access to the hardware and nobody else can get the hardware
it's probably as easy to maintain it out of tree.  Like I say, there's
another public example of this sort of setup.

Ideally someone would contribute a driver for a reasonably available
platform that does this - OpenMoko doesn't since they use an analogue
connection for their Bluetooth audio.
