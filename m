From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: add support for multiple
	cards/codecs in debugfs
Date: Thu, 1 Oct 2009 08:41:07 +0300
Message-ID: <200910010841.07085.peter.ujfalusi@nokia.com>
References: <1254306259-8098-1-git-send-email-peter.ujfalusi@nokia.com>
	<200909301421.46742.peter.ujfalusi@nokia.com>
	<20090930123938.GC12101@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id ED02C1037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 07:41:20 +0200 (CEST)
In-Reply-To: <20090930123938.GC12101@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 30 September 2009 15:39:38 ext Mark Brown wrote:
> On Wed, Sep 30, 2009 at 02:21:46PM +0300, Peter Ujfalusi wrote:
> > Yes, when I have moved to 2.6.31 it was kind of weird to have the
> > snd_soc_init_card(socdev) called from the codec driver itself, which I
> > still not feel too comfortable with...
> =

> That was always happening anyway, the function just got renamed.

Might be, but in case if you have one sound card with two (or more) codecs =
(or =

dai_link) on it than all codecs will call the snd_soc_init_card(socdev), ri=
ght?

For me at least this does not sound right. I have to check the code itself =
what =

it actually does.

> > I have in my board two codecs, using separate sound cards for each.
> > One card - one codec.
> > So far DAPM and in general ASoC behaved quite well in all possible
> > scenarios.
> =

> I can't remember off-hand what they are but there are some issues you'll
> run into if you look hard enough - I certainly wouldn't say that it's a
> supported configuration.  Device probe/removal is where the issues are
> if I remember correctly, it can work but it's fragile.

At the moment I'm compiling things in (no problems so far), but I'll try th=
em as =

modules and see how they behave.
 =

> > Btw. do you have some information about this upcoming reorganization, to
> > see what is coming?
> =

> Probably from an external point of view it'll have a dev_name added to
> all the strings in the DAPM maps for deduplication when used in the
> board drivers (which are the only things that ought to need to know
> about more than one device).  For the cards the soc-audio device will go
> away and the card device will be used directly, possibly with only the
> DAIs being directly referenced from the machine driver.
> =

> It's much more of an upheaval internally.

I see, thanks.

> =

> > All of that being said, it would be still nice to at least fix the
> > current situation in some way, since the current implementation is
> > clearly not behaving correctly.
> >
> > Does it help, if I use the dev_name() instead of the codec->name for the
> > directory for now?
> =

> I'd use both, the dev_name() is rather illegible by itself.

Is it good if the patch creates a directory hierarchy like this:
debugfs/asoc/{dev_name()}/{codec->name}/...

Or should I use some intermediate buffer to construct a single level tree:
debugfs/asoc/{dev_name()}-{codec->name}/...

>From the point of what is coming the former is much more future proof, if w=
e =

take into account that we can have more than one codec in one soc device (o=
r =

card).

-- =

P=E9ter
