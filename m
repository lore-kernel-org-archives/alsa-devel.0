From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Minor WM8580 enhancements.
Date: Sun, 6 Sep 2009 14:42:07 +0100
Message-ID: <20090906134207.GA9009@sirena.org.uk>
References: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
	<20090906012232.GA4239@sirena.org.uk>
	<1b68c6790909051850y2386addhae71898ada96954@mail.gmail.com>
	<20090906111133.GA26748@opensource.wolfsonmicro.com>
	<1b68c6790909060513v4f315f93uf4203408ba5baeab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 83E3F24486
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 15:42:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909060513v4f315f93uf4203408ba5baeab@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 06, 2009 at 09:13:14PM +0900, jassi brar wrote:
> On Sun, Sep 6, 2009 at 8:11 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > which are already known. =A0The Samsung CPUs aren't particularly
> > restrictive here as far as I remember, the fact that they implement
> > standard I2S helps a lot. =A0If you have datasheet references for any
> > restrictions you're concerned about please let me know.

> Some SoC may recommend 'preferred' RFS for a given BFS selection.

> For ex, @16bits/sample in either Master or Slave mode:-
>     SoC recommends     - BCLK=3D{32}         RFS=3D{256, 384}
>     Codec recommends  - BCLK=3D{32, 48}   RFS=3D{384}

I'm not sure where these CODEC recommendations come from?

> How and what values wud the codec and cpu driver choose if not the
> machine driver?

It looks like by "RFS" you mean the MCLK/sample rate ratio?  As
mentioned in my previous e-mail this is fixed by those two parameters.

The BCLK required is fixed by the number of clocks required to transfer
the samples.  Mostly this is a minimum but there are some CPUs that
can't tolerate any extra cycles at all (generally due to being generic
synchronous serial ports simulating an I2S mode) which means that
selecting the minimum BCLK is generally what you want.

Anything else can be dealt with if something needs it but should only be
visible to those systems - the overwhelming majority of systems that
just need to transfer the data should never need to deal with this at
all.

> > All I'm saying is do the CPU drivers first - like I say, the main
> > obstacle to finishing off refreshing the CODEC driver has been having
> > the CPU driver to work off. =A0I'd expect to have something quickly giv=
en
> > that. =A0There shouldn't be much overall delay to getting the boards fu=
lly
> > supported.

> It seems basic features(play and capture) may simply work with
> existing Samsung cpu drivers,
> all we need to do is write the missing machine driver for 6410(as Ben not=
ed).

> Only after we have _some_ support for 6410 I2S in mainline, we shud go on=
 to
> implement v40 features in the cpu driver (assuming we are to keep the
> status quo with Samsung SoCs' I2S architecture).

The lack of IISv4 support is the major issue with these machines - I'd
be quite surprised to see the machine driver without the 6 channel
interface, it's the major reason I've not already merged something.

> And if the cpu driver isn't good enough, i can only test it if i have
> the machine driver.

I'm saying don't spend too much time on it - you'll certainly need
something to test with but you should be able to get a long way with =

a basic connection to the existing CODEC driver.  I wouldn't want to see
you spend much effort on the machine driver only to have changes in the
CODEC driver cause substantial reworking of the machine driver.

How about starting off with an initial machine driver which runs IISv4
in master mode using the existing CODEC driver?  That's not the ideal
configuration but it will allow you to work on the CPU support without
needing to do too much to the CODEC.  I will then try to get the updates
for the CODEC which would allow the machine driver to be finished off
done as quickly as possible.  Does that sound like a reasonable plan -
it should allow us both to work on this without much duplication?

If you do want to work on the CODEC driver then the clocking needs to be
redone more in line with one of the modern CODEC drivers.  Unfortunately
I can't point you at a specific one which is quite as flexible to use as
an example but something more like WM8903 is more what we're looking
for.  This will need to take account of digital routing for the device
(which also needs to be implemented).
