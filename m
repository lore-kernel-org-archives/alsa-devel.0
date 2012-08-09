From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2 v3] ALSA: hda - Deferred probing with
 request_firmware_nowait()
Date: Thu, 9 Aug 2012 16:38:27 +0200
Message-ID: <20120809143827.GA10471@avionic-0098.mockup.avionic-design.de>
References: <s5hd3302ovw.wl%tiwai@suse.de> <s5ha9y42os2.wl%tiwai@suse.de>
 <5023BAA0.1080304@canonical.com> <s5h4noc2ntn.wl%tiwai@suse.de>
 <s5h1ujg2nm7.wl%tiwai@suse.de> <5023C0FC.2030207@canonical.com>
 <s5hsjbw17r0.wl%tiwai@suse.de> <s5hpq7017gw.wl%tiwai@suse.de>
 <20120809142536.GA1771@avionic-0098.mockup.avionic-design.de>
 <s5hhasc16d9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811377115304297017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E94B266393
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 16:08:44 +0200 (CEST)
In-Reply-To: <s5hhasc16d9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============2811377115304297017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 04:34:42PM +0200, Takashi Iwai wrote:
> At Thu, 9 Aug 2012 16:25:36 +0200,
> Thierry Reding wrote:
> >=20
> > On Thu, Aug 09, 2012 at 04:10:55PM +0200, Takashi Iwai wrote:
> > > For processing the firmware handling properly for built-in kernels,
> > > implement an asynchronous firmware loading with
> > > request_firmware_nowait().  This means that the codec probing is
> > > deferred when the patch option is specified.
> > >=20
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > v1->v2: drop superfluous chip->probe_deferred field
> > > v2->v3: fix missing chip->fw; renamed the variable to "probe_now"
> > >=20
> > >  sound/pci/hda/hda_codec.c |  2 +-
> > >  sound/pci/hda/hda_intel.c | 42 +++++++++++++++++++++++++++++++++++++=
+----
> > >  2 files changed, 39 insertions(+), 5 deletions(-)
> >=20
> > Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Thanks, now pushed to sound git tree for-next branch.
> As mentioned earlier, this is planned for 3.7 merge.
>=20
> Also, the patches are found in topic/hda-probe-defer branch so that it
> can be easily pulled to 3.6 kernel cleanly.

Great! Thanks,
Thierry

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI8tjAAoJEN0jrNd/PrOhNO0P/0gIBluxOk+wsjxK6JO1lOa4
/e28QygkZ1UhPPniKnIbk4xP7vgoXEKKCsokhK5LRI0wkLTRVifziKXJRHr/MrD7
FNGxYv7gbyVUt5HTdNaqwSdx02VrRYt0Nb/7vkDMLAUApHFw59OET5yY/Qw1JFhO
Glf5Wwq4d40Ma9dvNZWRS/D168yPBqc4B+uUawndafYaw6DGVzUBmlhcXMUwaBho
5Yvz6LUzozDhs7XAmrzbHmELiCUIvUZYkXprggFGXaqknMAbjaMaJWBEgQ0PZUnx
dQr+1oDjYr8kVGUNe5+ZD+HYF3cH7Im37RWFSrRAymrLim5rUl/7CXcESIl4qRNr
mEdZnEu+SIOLMfR8aS37I5XIanIEBMy75zCsU3UD5y5KImSi8VxX7qEbg9Ek9u2z
KDVSLsPY1GfBeNzMQtvDsdVecvSgiTFg3ZeJARhTd6MVEHsRDLbSISKJZT4eDOJZ
T67o6XKV0glYx6P3c79i5p9Br/XXk9L8LUI14h3EyihWiASDODKeGIEInMNplu/B
sYzJhzBOpx/oSI1s9KR6GX9P6L9boN9qUUDxDwLWr9aw6iQe2rSBgACfeIziW/xR
C4bjECqTf4aBKjqP05Oi7Qz/1p+/LJ6EZRniaR+UCpeF7HIPuDRNJ1yQ/ltlVcWB
C7P2t0xFY5A/2VGYuLo1
=7nMB
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============2811377115304297017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811377115304297017==--
