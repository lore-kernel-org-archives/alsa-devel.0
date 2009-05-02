From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: New codec for STAC9766 used on Efika
Date: Sat, 2 May 2009 11:45:48 +0100
Message-ID: <20090502104547.GB4990@sirena.org.uk>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
	<20090501101402.GB6975@sirena.org.uk>
	<9e4733910905012046s6fc7f1cci6812f7fb6e493516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 04452248C3
	for <alsa-devel@alsa-project.org>;
	Sat,  2 May 2009 12:45:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905012046s6fc7f1cci6812f7fb6e493516@mail.gmail.com>
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
Cc: Matt Sealey <matt@genesi-usa.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 01, 2009 at 11:46:48PM -0400, Jon Smirl wrote:
> On Fri, May 1, 2009 at 6:14 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Are you sure about this? =A0AC97 generally does 16 bit samples...

> AC97 can be 16, 18 or 20 bit. The link always transmits 20 bits.
> This codec is a 20b version.

Sorry, I meant to say AC97 controllers.  Your driver should advertise
all rates up to 32 bit so that it can be used with any controller, not
just controllers that happen to do 32 bit data.
