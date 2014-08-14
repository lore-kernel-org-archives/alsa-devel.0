From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Thu, 14 Aug 2014 14:07:08 +0100
Message-ID: <20140814130708.GX17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
 <20140814102152.GA8028@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0948038420900858593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 231C32656FF
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 15:07:26 +0200 (CEST)
In-Reply-To: <20140814102152.GA8028@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0948038420900858593==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1W/X7vAKQqX9TGO"
Content-Disposition: inline


--C1W/X7vAKQqX9TGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2014 at 03:51:56PM +0530, Subhransu S. Prusty wrote:
> On Wed, Aug 13, 2014 at 09:14:54PM +0100, Mark Brown wrote:
> > On Mon, Aug 04, 2014 at 03:16:01PM +0530, Subhransu S. Prusty wrote:

> > > +	pr_debug("%s: widget = %s\n", __func__, w->name);
> > > +	for (i = 0; i < w->num_kcontrols; i++) {
> > > +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > > +			mc = (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> > > +			val |= 1 << mc->shift;
> > > +		}
> > > +	}

> > All my concerns about this still stand - using something called
> > _get_value() to do something other than read the control value (which
> > this does - it uses it as a boolean then does something else to read the
> > value) which doesn't seem good.

> I think this can be optimized. This need a bit of rework in the code, but
> need to check. But this would need an assumption that the controls are
> created in order.

> for (i = 0; i < w->num_kcontrols; i++) {
> 	if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> 		val |= 1 << i;
> }

> Is this ok?

No, that doesn't seem safe.  Why not read the data from the control - if
we were calling a function which returned the value that'd be much
clearer.

--C1W/X7vAKQqX9TGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7LR4AAoJELSic+t+oim9Gf4P/iMeMQ6dnWADnXrKWhMbEBdV
dxOOn+t3lgYqejJ0EgatJE+ci13jRXWQKpstnEkwBRkHXhTOZag+zDmPlfMP1NCV
5l6q4nSaQdNCr8N0nCDnFEuSMa5nfWmc/I+hat3+HOZ9GXwcAweXmxVwBWe9O34L
bK6D2eCZHTu15nxRvgCy5z1AqYKD77OmJRpWAbGa6QS+XjJfZK1ovtqTZV0MVTQX
e8zrdm0MPYAMk1ZhRwC1Can1l6fi+lLYkDWQqtfwDIUVW87dw43lbLkGdjJHF8E4
l5xHZxhZ0t36OkGsSLMV9FseSF04P/G2Q/TSpy119V+k/G213WCgYUIgLmgKtJKx
4IK0zrisYabMqterw688wDF0CewDBR9LrS07RcO0bAd0ZpHdMIyrhiQVa3utQNqf
4rT1LokzyKWqMnjhHoa9NK42HJiLISDqX/UWrrSWmIYDL8q+ftC/pG27scSRKkfc
GqKW/V/dICvEQN2L8EptBDBBQLZ74OoMMr4Mya13lqWDEWYbzZPQ8N/COyMN/qZI
UMI+gAVGANAKZzwFWW5ILhRMnubFnk2kQM35F7C7oNciBiKGTlnhRG7qG5rOF3oj
ax3vi1DKp2ShU7tR01cLydvrC14zEiOd1m0DL5DC9+9wCYDweVCn+fjZqWNfcN1b
4uKFXxXNGi2p8lOwNlK5
=H5sV
-----END PGP SIGNATURE-----

--C1W/X7vAKQqX9TGO--

--===============0948038420900858593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0948038420900858593==--
