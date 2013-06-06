From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Thu, 6 Jun 2013 09:56:15 +0100
Message-ID: <20130606085615.GM31367@sirena.org.uk>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
 <20130605115544.GX31367@sirena.org.uk>
 <20130606043920.GA19094@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7925102024991140824=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130606043920.GA19094@MrMyself>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7925102024991140824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IWOW6f13lWWiH/hK"
Content-Disposition: inline


--IWOW6f13lWWiH/hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 12:39:20PM +0800, Nicolin Chen wrote:
> On Wed, Jun 05, 2013 at 12:55:44PM +0100, Mark Brown wrote:

> > > +- hp-det-gpios : The gpio port of Headphone detection.
> > > +- mic-det-gpios: The gpio port of Micphone detection.

> > I'd say a bit more about these - obviously the CODEC has its own
> > accessory detection here, and I rather suspect that in fact the HP
> > detection you have there is really jack detection.

> hasn't been included in this patch though. So since hardware has pins here,
> I think it's better to put in the binding doc as well. But I guess it'd be
> better to put it into OPTIONAL area?

Yes, they need to be optional and you need to explain what the function
of these pins is so people can tell what they are.  As I said I really
do expect that the pin you have labelled headphone detect is really a
jack detect pin.

> > The sample rate checking can be done with the symmmetric_rates feature
> > in the core.  The sample_bits check can't be but it's something that a
> > lot of systems probably ought to have so it ought to be factored out
> > into the core too rather than open coded in the driver.

> [Nic:] fsl_ssi.c uses symmmetric_rates, but last time I traced soc-pcm.c
> and found the core only cares about symmmetric_rates during pcm_open(),
> which means the startup() in dai/machine driver, while what I'm considering
> is something like "arecord -Dhw:0 -r 44100 | aplay -Dhw:0 -r 48000":
> The two startup() would run almost at the same time and each of them would
> be earlier than hw_param() -- the exact point we can get the sample rate
> from application, but before this point no sample-rate actually be set to
> make hw_constraint(). Then the two hw_param() would continue their code and
> successively call set_fll() twice with different sample rates.
> But I agree that it's kinda ugly to put code here. So I think maybe I need
> to drop this part of code and to think about another patch for the core?

Yes, you certainly need to drop this patch.  There is no way of fixing
this with the current ALSA APIs, they are fundamentally racy and you
will always have the possibility of failures during simultaneous startup
for hardware with these limits.

> > You're enabling and disabling the CODEC only while there's an audio
> > stream active.  This means that it's not possible to support analogue
> > bypass paths (which the device can do) - you should probably also
> > support enabling the FLL via set_bias_level() and use set_bias_level()
> > to turn it off (which works in all cases).

> [Nic] I've seen and tested set_bias_level() way as samsung/tobermory.c does.
> But I find a flaw to the method that if I play two and more wav files like
> 'aplay -Dhw:0 audio44Khz.wav audio48Khz.wav audio22Khz.wav', which needs to
> set_fll() before each playback and to keep SYSCLK valid by changing its source
> to MCLK after the playback, but I only found that hw_param() and hw_free()
> are symmetrically called before/after each playback in this case.

Two things here.  One is that of course there's no reference counting on
FLL enables, they just happen, and the other is that as you'd expect the
bias level callbacks just won't happen for the second stream as the
device is powered up.  You only need to set the clocking up for the
first stream as the clocking can't be changed when the device is active.

--IWOW6f13lWWiH/hK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsE6sAAoJELSic+t+oim9qigQAIBNqv5UvV+IIn+8ggFYGK70
Tx0tqwIAfXj7zqEXFYdWyZRrs7WIlMLVUn7TgMta5dMMMyu1mn1jdj65f8rV0nro
1+W2VC6WeiqPbW0isdPj+M357CAZbSsMIKcJDNb1IJ7q8lkbBmWLb1O2m0L3WmzM
gOYzcBgXSzueZ5iT6GabaY15kXAPCleOPslDHXdqm681j+DoacAFwLVyOAyNZzmd
TkXoZaso7vDx9C+kGaYEbW5b0OS0w9DMEFSWR09J5ketRVQ6wzD7IIykjfYOJk7d
Vzo5VZ7SqKLSCxzs62YdKQW6FeU+/T8kOLaUjHggA+zs9n3ZSeiU+iRT/J8TFKiq
my2ioJJ8yxen86wcx9DxJUap5L8mjxZdjBPooAIZ0TaK4ABv+wMiv2K46p3W0WZ7
D84vrz8i/LZFHmRz/lOPwrj6wKrmXbADqp5opGoTi/16Cqe5QeTYN2+ANbonir65
gRvaHYq4Me6YWEwGyNXuznBRHEjHZh40URRYkfe01Em8eO50S2zFg4QM1OXJgSgB
yutFKWOaXLHoT6PRVZGcY7znHzXYBsyRFZKjR8EcXUTVb9/Car5oxZymeWQNN8pu
000bB285MFmJ9XVM6annicOQSPOL/Hbz9XDGntSbrSctdGKnO0TMFcriv71Vl1J+
aN84083ykHgj4l0/+TPZ
=XNFn
-----END PGP SIGNATURE-----

--IWOW6f13lWWiH/hK--

--===============7925102024991140824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7925102024991140824==--
