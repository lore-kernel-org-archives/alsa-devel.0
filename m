From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] ALSA: hda - Load firmware in
	hda_intel.c
Date: Thu, 9 Aug 2012 16:26:02 +0200
Message-ID: <20120809142602.GB1771@avionic-0098.mockup.avionic-design.de>
References: <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de>
 <s5hd330frn1.wl%tiwai@suse.de>
 <20120809073642.GA24695@avionic-0098.mockup.avionic-design.de>
 <s5h7gt8fr47.wl%tiwai@suse.de>
 <20120809080713.GC24808@avionic-0098.mockup.avionic-design.de>
 <s5hzk64earo.wl%tiwai@suse.de>
 <20120809103430.GA1560@avionic-0098.mockup.avionic-design.de>
 <s5hobmk2ql5.wl%tiwai@suse.de> <s5hd3302ovw.wl%tiwai@suse.de>
 <s5hboik2otu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7581560394188075815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0DA26638F
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 15:56:22 +0200 (CEST)
In-Reply-To: <s5hboik2otu.wl%tiwai@suse.de>
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


--===============7581560394188075815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 03:10:37PM +0200, Takashi Iwai wrote:
> This is a preliminary work for the deferred probing for
> request_firmware() errors at init.
>=20
> This patch moves the call of request_firmware() to hda_intel.c, and
> call it in the earlier stage of probing rather than
> azx_probe_continue().
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_codec.h |  2 +-
>  sound/pci/hda/hda_hwdep.c | 39 +++++++++++++--------------------------
>  sound/pci/hda/hda_intel.c | 29 ++++++++++++++++++++++++-----
>  3 files changed, 38 insertions(+), 32 deletions(-)

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI8h6AAoJEN0jrNd/PrOhh8AQAJ4M88lL8CcMbQf9lpn68t7o
I8j36GbcC7ixXc8d1Audvd4gS2ZTLa0AGQY3XJsCXShKiI+BFIDxYIz75lIrMhyK
RtKXXAfJY1lWLriDi6EaOBRSnnXCDXctKFrOBbsNZJL8rry6DgRh15J2H8/QZT8/
SEcaGKgjGbeBYs1OyP3+zRPejwKDKvHMp9/J76noNX6WZRh0FD6Qc8L6mJir6KXy
GQtiHeipyliikqNC+85C6to1d4Tp7tOZRk8wlKdw5uLT/fUvrYEYnpwtReTa/Zqt
1DpY/FFLjJzPg/shkt80ZY+wa5FRoGHVV+kadeSu17FWQm/Q4IOFGCfH0t74pOWn
zbnNJUT4zrf3BhcThYyXcE58YoOOaC5tgfrbfuNR4GRsAqCKwtbdWdAf588IUBa/
OFItZyBgVWwHtEbtjyBu7+vxRDBjyzq+b7xZP3XT1VGnrCYJ+Qs6B+dUuk1wm5mG
xKWatr6+Xx5Upl0znTsZnpOIPZXmwRnpOefX2/4gGdWseICL26KVKffmuw8jInGb
PaHy1MVWBcQwIsiucgQXi+jwrA8pJsim1pQ82E8x+dBbYEeiEtPFIAl8TRSx3K93
1UUqa9ZRCsZgq/vTRtp8Ff9i1PVUtXgg+805cMgz2vlEdoLPi4RYJueOiL06W7qd
4MPFVobllzjSW9Q3qCm+
=sIjn
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

--===============7581560394188075815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7581560394188075815==--
