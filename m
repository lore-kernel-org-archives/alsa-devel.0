From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: make dapm cache search depth
	configurable
Date: Thu, 10 Sep 2015 11:31:35 +0100
Message-ID: <20150910103134.GE20922@sirena.org.uk>
References: <1441707097-11200-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
 <20150908104241.GA9751@sirena.org.uk>
 <55F1509A.4040303@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6719290087616407864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B97F2614A1
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 12:31:50 +0200 (CEST)
In-Reply-To: <55F1509A.4040303@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikesh <noswal@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com, linux-kernel@vger.kernel.org, Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6719290087616407864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2015 at 10:42:50AM +0100, Nikesh wrote:
> Hi Mark,

As I'm fairly sure I've had to tell you before don't top post.  This
means that when someone sees something like this:

> The reason I though this will be usefull is as below:

while reading they know what the "this" you are talking about is.

> the widgets in wm5110_dapm_widgets[]) as defined in this macro. But if you
> notice the way DSP widgets are created they use a WM_ADSP2 macro which
> creates a preloader widget for every DSP widget and we want to skip past
> this preloader widget when doing a cache search so increasing the cache
> search depth helps here.

Why is the solution to this problem to add device specific tuning?  Is
this extremely expensive so no other device would want it?

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8Vv9AAoJECTWi3JdVIfQmYYH/25xD6KbbF8opYgRUDKwyRPI
wyZhpIRB+ktEMBno8y+LxEMYWOblwyj0cjM+aAG4gRRa7C/ObxlKySM0eflr05Li
xuoWEBps9EpTKLq3o0t7m1LTHkMfL/Uvi7tTQcn2wTmQSB+YA+mHU8rXmNpMIHQY
0Gj8GXwxVUyWJ9QojoAnNBPnHBwiRkTOSx0JBudufZZl8j1iXM797UYtSJnNIBpN
Iz9WYFgtHHqYIvZSk+B10bao1B95+Ss6hzDbIzAGmFmnEEThe5ipX91f9oaHQvo9
fhl2pYOALp4+Sr0QznKprdD/h8gqdUSUq2+nTuAdQZUJ/qtEyng9feFS3g3l7p0=
=ssx5
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--===============6719290087616407864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6719290087616407864==--
