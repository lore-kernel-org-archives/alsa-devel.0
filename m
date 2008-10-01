From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
	board
Date: Wed, 1 Oct 2008 09:15:32 +0300
Message-ID: <bd7b27490809302315jfc8982bofbdb5ce9be3e834b@mail.gmail.com>
References: <48E23AE0.3040805@endrelia.com>
	<bd7b27490809300810n77b82690j4ddedb0a0f7108ac@mail.gmail.com>
	<48E2481D.6030208@endrelia.com> <20080930182520.GB3338@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id A56E8247CF
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Oct 2008 08:15:33 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w1so432525mue.2
	for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2008 23:15:32 -0700 (PDT)
In-Reply-To: <20080930182520.GB3338@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2008 at 9:25 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Tue, Sep 30, 2008 at 11:39:09AM -0400, Frank Mandarino wrote:
> > Jarkko Nikula wrote:
>
> > > In that sense these are nice reference implementations :-)
>
> Quite frankly nice isn't the first adjective that springs to my mind
> for how this stuff works in v1.  As with so many other things once v2
> is in that should make life better.
>

Unfortunately it's sometimes have to stick into older stuff :-)


>
> > My reasons for wanting it removed are that 1) it only works on our
> > proprietary board, and 2) I don't have time to maintain it as changes
> > are made to ASoC.
>
> I tend to agree with Frank here - if it's causing too much work for the
> people with access to the hardware and nobody else can get the hardware
> it's probably as easy to maintain it out of tree.  Like I say, there's
> another public example of this sort of setup.


Yeah, valid points. And anyway, this driver can still be found from git
history if needed.


> Ideally someone would contribute a driver for a reasonably available
> platform that does this - OpenMoko doesn't since they use an analogue
> connection for their Bluetooth audio.
>

Let's throw a hint here if some hacker is interested that it would be
possible with Nokia N810 (and N800 as well) by developing DAI driver for
OMAP2420 EAC - Enhanced Audio Controller. EAC has dedicated ports for codec
(pins can be muxed to McBSP port 2), modem (not used in N8x0) and bluetooth
(pins cannot be muxed to McBSP).

Unfortunately this EAC is found only from OMAP2420 where McBSP is in every
OMAP so EAC DAI driver doesn't have so generic use IMO. But I'm keen to help
testing and development if someone would do it :-)


Jarkko
