From: Johannes Berg <johannes@sipsolutions.net>
Subject: ac3 in/out
Date: Tue, 21 Mar 2006 11:27:16 +0100
Message-ID: <1142936836.4759.3.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZPjmcy5S7Mn7OZaRfBos"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-ZPjmcy5S7Mn7OZaRfBos
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

=46rom what I've seen about ac3 in and also out, the support in alsa for
that is more of a hack, and the data that is passed down the pcm
interface actually contains the channel status bits for some drivers...
Working on the new Apple stuff this isn't possible -- only some channel
status bits can be set by the software, some are fixed. And they aren't
interleaved in the stream, but set externally.

So the question is -- are there any plans to abstract some digital out
API within alsa? Otherwise the userspace will need to handle all kinds
of different devices differently since the data on the stream is
essentially the same as the data the chipset needs.

johannes

--=-ZPjmcy5S7Mn7OZaRfBos
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARB/VAqVg1VMiehFYAQLWXg/+LA9zeocyWEoT0MYJb9GVUpdCVMqYR73a
eKSkqW4SpiHgN+d6UVN6H0MVcrcNNLCU3G4Ez1JaRC04CgjhJdCY2Vx8W0vVgv7P
rgKPMUqfQ92uH2Y0+L9ysdlUppkj1pVToPfD6xX7Ecyto4DDgu0qfOHjpmRv4NAl
0tw/54BI3/DboUTTEjCOZ7RJJgWZwRrNyiegNepCqGYL9K66Bg98ueTBRxFlvYZu
Sd3cYVUgMpJgJauylvZUL+dgb7cDDo+JfTKjaSYAZLTHpoUuNsHsNfh+lpbRGAWD
sIQWgcSJYTV4/hKdWPBpfvGv/h19fUnhMQKs/t8YDxPYL6O/wRcfzihQx0sZmOnn
1EbxhBodV80FebZ2HObVgaN3ClgDpLKFwT3PCiPt4ymTPl+FHnrxpnHimTNSulEG
ikWxFtwhDTTwMIytBZ6YqbMz3wC4w+LPKcMFC88/V9tw9APemK5gmLqGneFRehtc
WEhItlwFCaY4qcJ8qDYIZ4swDt3pwXR4B3WxFhSvNXSiqwSlHBMuaxZSp8ZRiffW
XEwxc+CYAW84PMQ6eP113M5eFDlTQ8TIIlvjkI4xrKylnCxasJinDT9un6576a5X
+O5HIVZYvhi6p4n4j/W3JiP3wD/g8QruCIUfEjpype6kKOrITjfor2A0ERWpeKkT
+iTwz8y137U=
=fqmp
-----END PGP SIGNATURE-----

--=-ZPjmcy5S7Mn7OZaRfBos--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
