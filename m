From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 10 Feb 2012 11:36:06 +0000
Message-ID: <20120210113605.GF3056@opensource.wolfsonmicro.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4081168841055677934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D48A12412E
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 12:36:08 +0100 (CET)
In-Reply-To: <s5h39aj5569.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============4081168841055677934==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2012 at 11:55:10AM +0100, Takashi Iwai wrote:

> OTOH, we can take an optional directional suffix, i.e.
> "[location] base [direction] [channel]", too.  For example, base can
> be "Video" or "Line", and direction can be "Out" or "In".

These names are going to get pretty verbose very easily.  Might it be
worth putting some of this (and also other information like colour) into
TLV information rather than part of the base jack name?  So long as we
can extract a name for the jack itself (which is probably the location
in your example above) I think we're fine.

I think the main thing is to clean up this mess for 3.4 so we don't get
too many confused userspaces out there.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNQEfAAoJEBus8iNuMP3dNxAP/ivII2ewojKrOF2Ak14oIHqf
WA166OaxR+oqV8qKlrW1fIhFpvbO7q+cpXVl2+4v/qH11fm3UE2cRhgJ+JZE0sfb
u++6Ci96UCOGVNiMjoM+OvA4tXO4I0qT3FslVIOBouzMX4+0OYcXuQen41+g603h
Gd6qUcM1yW594btJkDSlojHiVUqyuZnXG5JHxrkw1t1N8zClRCHeHdoQyuHa0fQQ
HbxStoBp6HORt0GsIDFL9AByg6rqUCmK26o72YIb5aGJLa46xUD+LuWkAta6MCwp
0/EkLrdkiCFRVlPNp7cpPLxlRq1WhhbhtchRODswGc6nEQbSVYJJRXDFPaqb6NRe
CvGXFCVkuQNC/udUn6oJs+K7xSpoMKJ/FHkvEbNVQJbLZgqTGMawIqMrY8Ru50uw
n1R6f7RfX1x7MBFb8HygmtGXeDk+b9DXum3iMZ1wg81riBAQJeJnuYsxR7nEE68K
XOanmxgFmXvS6+tTNMzi0UNfgJsEw559brtWOKPmVvux2ZBZrRge0GpnIBijVXyN
xlB27dCb9yYcGxqFS2Y/qEwv/DSxSgznx4jqg2PpwbJqkc/Jo1u7OuYK1A+/XjpU
Y4aZHjkyf5aLuejWfMIt5B5R6ype8Siqld3i99c/33Say4B3MR72QvoefNqNQ6II
s6bf+1fB1OAbDckCzAT5
=JCKq
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

--===============4081168841055677934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4081168841055677934==--
