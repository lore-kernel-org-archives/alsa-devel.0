From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt286: Add API to set supported jack
 type
Date: Thu, 14 Aug 2014 20:09:31 +0100
Message-ID: <20140814190931.GD17528@sirena.org.uk>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
 <20140807173136.GN17528@sirena.org.uk>
 <1407751185.2487.150.camel@loki>
 <20140811122415.GZ17528@sirena.org.uk>
 <1408004988.2506.13.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6855003695050365353=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408004988.2506.13.camel@loki>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Graeme.Gregory@linaro.org, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6855003695050365353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEEZHtZ3GUnhFvAc"
Content-Disposition: inline


--FEEZHtZ3GUnhFvAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2014 at 09:29:48AM +0100, Liam Girdwood wrote:
> On Mon, 2014-08-11 at 13:24 +0100, Mark Brown wrote:

> > Sounds like DMI is going to be needed then - whatever ends up being done
> > I'd expect it should just be a case of putting the checks done to work
> > out the machine configuration into the CODEC driver instead of the
> > machine driver.  If it looks ugly this can be used to explain to people
> > why we need something more sensible!

> It sure will be ugly ;) This would involve the codec driver checking for
> the existence of the Broadwell ADSP ACPI ID and then configuring jack
> mode depending on whether it finds this ID or not.

> We have the opposite implementation atm where the Broadwell machine
> driver sets the jack mode at machine driver init time.

> I'm not sure that showing ugly code here would help justify anything
> either as we will kind of be at the mercy of whether the Windows driver
> needs this information or not.

It's going to be ugly either way, it's just a question of how the code
get partitioned - I'd expect that whatever does this is going to end up
having to cope with working out which configuration to apply anyway.

What it does buy us is consistency in where these things get handled -
it's easier to have a consistent rule that the device is responsible for
platform data (wherever that actually comes from) than to have different
rules for different firmware styles and it'll help with back pressure on
other people who do care more about Linux even if it doesn't help with
the immediate use cases.

--FEEZHtZ3GUnhFvAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7QloAAoJELSic+t+oim9yZAP/AozUgnOIivWwLF/giMOVBa1
w+xivW+aVhNbLS4Zjsrjb4pq5TnFT1/ztQgOTijDP0O7X+v+plwyODmK3kM+K0Sc
Od+/BCpeJF9k374t1jSIRjGBSFt4HnHsocg56zYsgaQGOsWadHesvTMq2QvES4mO
G35px+jQby64L5CaD69CPgL5t7WwrwSncsF/LxzVmvWuStGc4n/if6rPcehgyM5T
PnHlNZUoeiEsRlHw/oPUVKBiVndgjl7Eru1jJH36QWHebksDN2rrwxxjjFy9YHEv
bGG0nNS1n3YUjXw7PtD6aCRCQTcZA/m4cIdwDlCfGqBZ/H8D3XJXvjFV8aKlXv+V
Ji403pzPiS3Ml6jzsO0SUo5YLcQwNnKLNd9c0ONKvYxoAwcrA9bsmLpoVPYXVuPO
9SkLrYM3PQfAqHD3mRRLQkS6/3wTD/XRs4XgM2ZNcdK/FStvf0BKmJMswgsTwTQo
eLF0BctFD5/Y0wUNDcOlsY9N8NUPWNKF8siNkEzfriZlz59WUdLYga+RxrqBH5HO
XYrPRLzlEWLzl5QTLuZVXiKprGjBggA443NPkymfSsCJK64GGUxMT8FxX+PNVqOm
qlrt41ZylIjDZkkxRN8Q5xmWePp+GX3Eyt4mJJ7xdgnGEDeFWzj9uD6yaAvX0ci+
itqn7ruYsnP229vKaqX7
=4sGS
-----END PGP SIGNATURE-----

--FEEZHtZ3GUnhFvAc--


--===============6855003695050365353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6855003695050365353==--
