From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Wed, 3 Sep 2014 19:39:04 +0100
Message-ID: <20140903183904.GA29327@sirena.org.uk>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
 <20140901121753.GC12898@vinod.koul@linux.intel.com>
 <20140901125114.GV29327@sirena.org.uk>
 <20140901135702.GA14646@vinod.koul@linux.intel.com>
 <20140901144134.GY29327@sirena.org.uk>
 <20140902052225.GA1610@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7772973007985561870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA911265665
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 20:39:11 +0200 (CEST)
In-Reply-To: <20140902052225.GA1610@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7772973007985561870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J8ZfMsDg90ddfAv1"
Content-Disposition: inline


--J8ZfMsDg90ddfAv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 10:52:25AM +0530, Vinod Koul wrote:
> On Mon, Sep 01, 2014 at 03:41:34PM +0100, Mark Brown wrote:

> > No.  You've described what happens when things are working and
> > everything is operating correctly and there are no bugs in the kernel,
> > the goal with error checking is to provide robustness against the
> > possibility that one of those things isn't true so we can tell what went
> > wrong more easily than if we get memory corruption.

> Lets assume a wrong case here is triggered due to some other issue. So we
> get invoked twice for the same pointer.
> Since the function holds the lock and searches the object in the list, only
> first access will find the object and start to free it and relinquish the
> lock.

> Now, the second access will not find this and return, so no harm done.

Consider the case where we do another allocation and happen to get a
previously allocated address back; if we end up doing a double free
then that would result in the new allocation being freed which would in
turn lead to memory corruption problems.  It's the sort of thing that's
really unlikely to happen but can be a nightmare to debug when it does,
a little bit of defensiveness early on can help a lot with avoiding
having to deal with such issues.

> I agree that we need to at least put a log indicating such a scenario
> did occur and we failed to find the object. So we can return immediately
> after freeing up and then if we hit end of function implying we haven't found
> the object we should complain.

> Would that help?

That's exactly what I'm asking for, thanks.

--J8ZfMsDg90ddfAv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUB2BEAAoJELSic+t+oim9a3sP/jilfX8tPOl26PPPLOrFADlF
+MYnKHXWRxXYbDq6AKCCOxSCpgtH9v7E1/Bnw4gPspEqWUtisQ2NcVomRKdiR/IP
t2oRzPM9YXJAfr+EqB+yBuJMnogIv3cyFsG/pJZbhf6KJUQ+oyAJQXHMmOlIDT4E
BdX39J/7RXnNaN1oKXBNnlPNEI3qn28o1zZWOZ7qIAHxjAVXdZ8VmLCO7YlMnfV/
igfvTW6iya34oZxYLoDZIKODfzSvMqC2HWmnIa++rP3zMuVMeAgZugLdOuq+MWnP
i8PrHWalzKu/gpVHKZS6AoTINjMEhH0yxwtYXt7x7x4r0YNx9GkQzMwk2jaeWD5D
IuOUa7FJOxCEUY6tNNr+RDMm1vSvvh26ARBORLDJLDFy7NHl2vhhAotcXsdQr2fz
PteNaFRXnrFX0cXvZS4VgoW7JuIzf6vD/DUBVqELHf3VjZngag26WL0pRMUHH/K8
/uGKN8zBdbOrQgNFN0WBtJf7kjUD3YcTxD+ND45SEHrH2W52iLF6Kw8r+P5k7OOM
jP9VpcIZN9+/568cZWFsasOtMz4zH4VrQpOVXs3h9CWM9GbsgEoBLqToeaoMYx4A
Ip0hoi5eCJ0pnFJtgxTok9I8dOPX12pEReOk59qGIRuzDcN4cc/Bc2fYX7oJCekQ
+Vu7EDex31xYJFD8BMCf
=eLxR
-----END PGP SIGNATURE-----

--J8ZfMsDg90ddfAv1--

--===============7772973007985561870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7772973007985561870==--
