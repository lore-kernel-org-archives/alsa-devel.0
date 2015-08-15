From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/9] ASoC: Intel: Skylake: add DSP platform
 widget event handlers
Date: Sat, 15 Aug 2015 07:36:38 -0700
Message-ID: <20150815143638.GC10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
 <20150814214336.GU10748@sirena.org.uk>
 <20150815134208.GD13546@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8964771217761346380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C58D82650FE
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 16:37:22 +0200 (CEST)
In-Reply-To: <20150815134208.GD13546@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8964771217761346380==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a3TIYp8vN9YM5Qs8"
Content-Disposition: inline


--a3TIYp8vN9YM5Qs8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 07:12:08PM +0530, Vinod Koul wrote:
> On Fri, Aug 14, 2015 at 10:43:36PM +0100, Mark Brown wrote:

> > > +	list_for_each_entry(p, &w->sinks, list_source) {
> > > +		if (!p->connect)
> > > +			continue;

> > Hrm.  Do we handle routing changes well?

> Yes we do :)
> This is the pmu handler for a mixer widget. Here we need to send Bind event
> to firmware for the paths which are connected, so if a path is not connected
> we don't need to send bind event so we skip that.

And we couldn't connect in any other way?  This case is fine but I'm
worrying about what happens if that connection gets made later - we
won't get another PMU event since the widget is already powered.

> > > +			/* Add connected path to one global list */
> > > +			path_list->dapm_path = p;
> > > +			list_add_tail(&path_list->node, &skl->dapm_path_list);
> > > +			break;

> > We have our own private path list here which includes the DAPM path...
> > can't we outsource some of this to the topology and DAPM code?  I'm a
> > little fuzzy on what the list is for, it appears to be used mainly for
> > deallocation though it's called dapm_path_list (which is a bit worrying).

> If you look at the usage of the dapm_path_list, it is used in pmd handler
> for this mixer. For a mixer there can be many paths and we need to

This is the sort of thing where the whole lack of documentation thing
that I keep going on about becomes really important - there's a limited
amount of time I can spend on any individual patch series and so things
that need to be reverse engineered are just going to get queried a lot
of the time (and even if they get reverse engineered the feedback is
often going to be that the code needs to be clearer).

> disconnect the previously connected path. DAPM will disconnect and send
> event, so we wont know which paths were disconnected and thats why we keep a
> track if this by using this list. At PMU we keep adding and at PMD we check
> the path which was disconnected and send the event for that.
> This gives driver very quick lookup of which disconnect to send. I am not
> sure if we should be changing framework for this...

So this is about generating a notification to say which routes are being
disconnected?  That seems like a fairly general thing, I can imagine
that being quite common for DSPs - indeed it seems essential given that
we won't always trigger any power changes on disconnection.

> > > +static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
> > > +								struct skl *skl)
> > > +{

> > This looks a lot like the previous function, there's similar duplication
> > in the other event functions.

> Actually logic is quite different. The skl_tplg_mixer_dapm_post_pmu_event is
> for mixer and is supposed to bind to source pipe and start
> The previous one is for PGA and starts sink pipelines it is connected to and
> then its own. It doesn't do bind.

There's certainly a lot of visual similarity there.

--a3TIYp8vN9YM5Qs8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz051AAoJECTWi3JdVIfQeCUH/Rtkmt+1V2PutSDfFiJkMvIT
bNG0m9g04AZt53G4GglGPKmZj1f9w4k7w0/24FShUtejXO7NcwFgd/fEHJfgOU75
Six6YfNUOPeqp0qffvYsYkULALAmB7bdIBbjNs0nIr9cLljAACMnzruZZfsmGdK9
NoVnMs549Ta/IQzL7H6nCosGutXnoUsOT3eugbbe97JTQ97IY8CPRodmb3h9ciES
SoU5LjE8Fo18u2tw8b4Od4eTGgmfgUu64CDOsgKHM7kYVvpx4DiAogaRKieFlRXN
AUavFfl6DOdCB8cwwUDeq27x3PoXBoxTgZzjYaVoUUQ6znxvV5HX8XerS9xupto=
=rWmA
-----END PGP SIGNATURE-----

--a3TIYp8vN9YM5Qs8--

--===============8964771217761346380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8964771217761346380==--
