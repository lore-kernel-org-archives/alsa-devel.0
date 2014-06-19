From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine
 driver
Date: Thu, 19 Jun 2014 09:34:19 +0800
Message-ID: <53A23E1B.3070008@kosagi.com>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com> <1403063242-20840-4-git-send-email-xobs@kosagi.com> <20140618100233.GE5099@sirena.org.uk> <53A1687C.9010705@kosagi.com> <20140618103111.GH5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M9VNTpH1FtAf5oGVeIv9gahJ8fWfi3DT8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140618103111.GH5099-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M9VNTpH1FtAf5oGVeIv9gahJ8fWfi3DT8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/14 18:31, Mark Brown wrote:
> On Wed, Jun 18, 2014 at 06:22:52PM +0800, Sean Cross wrote:
>> On 06/18/14 18:02, Mark Brown wrote:
>>> This should be handled by the clock bindings not open coded in the
>>> driver - leaving this here most likely won't play nicely when the clo=
ck
>>> API can configure the defaults for the tree.  There is supposed to be=

>>> support for setting default clock trees going in (or perhaps already =
in)
>>> the clock bindings.
>> Can you give me more information on it?  Currently, it looks like most=

>> boards use a 24 MHz clock, judging from this comment in
>> mach-imx/clk-imx6q.c:
> Look at the clock API, this stuff was introduced in the last merge
> window if it's there yet at all.
I don't see anything mentioning it.  If I remove the parenting calls
then the es8328 will refuse to run as its clock is at 66 MHz rather than
the requested 22.5792 MHz.  But since you say the default clock tree
support is going to be merged, I'd like to try using that code.  Is this
the "assigned-clock-parents" patch you're referring to, or is there a
patchset that will automatically reparent as necessary?

>> This codec requires the more unusual 22.5792 MHz clock.  What is the
>> appropriate method of obtaining this particular frequency?
> clk_set_rate() on the directly connected clock, the problem is fiddling=

> about with the parenting rather than setting the rate.
>
>>> No, this is broken.  The CODEC should request its own supplies which
>>> need to correspond to the supplies the physical device has and failin=
g
>>> to get the supplies should be a fatal error unless the device works
>>> without power (in which case why bother enablin them at all?).
>> Not all codecs have power supplies.  Most don't, in fact, it's just th=
is
> The manufactuers of those that don't are being awfully quiet about what=

> sounds like a rather impressive feature...
>
>> Additionally, since the regulator is external to the codec (as it
>> physically cuts 3.3V from the power supply), it doesn't make sense to
>> put it in the codec driver.
> I'm not sure you've quite understood what the regulator API is there
> for.
I'm having trouble understanding where the separating line is between
machine drivers and codec drivers.  A random sampling of codec drivers
doesn't yield any drivers grabbing their own power switches.  Is that an
oversight?  Should every codec driver include at least one regulator to
describe its power source?

If you like, I can move the regulator from the machine driver to the
codec driver, and make it non-optional.  But we've done designs in the
past where it just hangs off the 3.3V rail where it's non-switchable,
and the concept of describing a regulator seemed overkill.


Sean


--M9VNTpH1FtAf5oGVeIv9gahJ8fWfi3DT8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iQIcBAEBAgAGBQJToj4cAAoJEKuwFcVr1hraCCIQAIvzT/GlLJwReQ0nNc08RxqS
wW6yjKCTOetwMxvPhQGcpiCB737g/ophMDS/qslWQuUe8d7iW7B9C7brQCpdaW4h
yGPwuujtFMUa0HZ1+Z2Gfm2bhuCU8HJPAC54qsI14fc+GNbDtX1kQTYx/o4cpXu/
BaXw1+IiaXu8D7MEehEFRl8o/3aqrtHejFlVrcxQkF2/vqt91JGB8EPOrFhwkCNz
OkduJzZU4f/cCoUPihotojjBEjh64T4XobB6S4OBlfxBanvq+5ghdH+X6fw6Hjko
iVDe8MuEtSC4rX7XjdMeR7zjTd6gq3oJNWMMuEKC/HK7yDG2jtcZxSxdnWEhe2Gb
dzEIIMmE9sz57pnyh0KEhg+jPj9n4+qt/rZhrWdR0r8ErjoZmXsrNi8XXxfzvxpR
SrGWeuh74U2TbxRoLx34qiwq2HYSKwpUfjTw/JdQHqvJGLZllgIZUncRIhG1/fz4
vIV803q0DIhEyRvx+xRX3ujE7XGpSijHfTTq/6xaY29JIx30DBqhvIyvHQZBh3pZ
RY8JfTVnoYHcUDBDgniZGNar4C/pXAPor9Mpc2/in4PCtEVoIwtGwaKuS7soUoqc
giKj5DZwpM0/92lLP2OFQixUkWkWyJjuYjTHoF6CpdVJ++8DdjUXCbzlw53jFJpX
hghnR4GeEEo1Zvu9Zsvh
=RlcT
-----END PGP SIGNATURE-----

--M9VNTpH1FtAf5oGVeIv9gahJ8fWfi3DT8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
