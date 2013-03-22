From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Fri, 22 Mar 2013 12:10:41 +0100
Message-ID: <20130322111040.GJ22890@opensource.wolfsonmicro.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
 <20130322101820.GC22890@opensource.wolfsonmicro.com>
 <514C3124.8010806@gmail.com>
 <20130322103247.GF22890@opensource.wolfsonmicro.com>
 <514C3AD6.6080301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897759274681718998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B41692664C2
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:10:42 +0100 (CET)
In-Reply-To: <514C3AD6.6080301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0897759274681718998==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 12:04:54PM +0100, Daniel Mack wrote:
> On 22.03.2013 11:32, Mark Brown wrote:

> > You're not really responding to what I'm saying here.  What I'm saying
> > is that if this is useful it should be implemented in the core unless
> > there's some reason I'm missing why this is specific to this driver.

> Ok, point taken. It's just not really a drop-in equivalent, given that
> both the numid and the name string will change then.

Well, we could probably arrange something for the name string (and I'd
think we'd want to).

> I'll see when I'll find some time to do that. Your idea is to have a
> "Master Playback Switch" for both the CPU and the Codec on each link, if
> the driver implements either ->mute_stream or ->digital_mute, right? And
> the control would default to "on"?

Yes, something like that.  Providing a way to set the name of the
control would be good but it could be done as a stage two.  I'm still
swithering about applying the patch, it's driver local and won't really
interfere with any generic support that comes along.

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTDwOAAoJELSic+t+oim9TUwP/1XlEul/rU5ehi76ycv6U+1D
q6P75n+wrItv5WMOfxO4qVZhqiKohJIwM+ahU1z4ODxRpJIb7AQY/6+ldQhxynDy
eO19FbGHyJHE3Zg1adeoj8o1kcibiZD9CK8baPHi9s/mjzHos9YvrxWbkMf9z9L9
uGYKmKe7lqrKyrxIEUT8KbzGQ39L842ZFQYPZ73tSa8SjhXcNJgaoLU6L5j50OkO
KBUOQfjsvJesvm3Bil4+XIGV5TnK8MamZ1Gw+58dYEgrQaXDm5hr6BEmxEFmguJZ
Kla4OYoYdGcYKTaQ8/zczbLt4ujldl7wPp20hw74cQskLNUjRuAEpHWbkr/PxkpY
4GkISlANkHAyR/le6942PK3fCYn2EhctZFRHvBDax1FnQpsipprdCA1XPXw7Lqe6
GZry5LpGraciqEaPvAntXMgfCVwKgCq5vqfZ8+gYBpKdMzHrH2h+V/oO6Xr2URch
1iP1KbFJtLLEZvgDjz9v7K49OPF+ovOAT5+Xu1kfzcdJDswbJgAo5KXUbvw0J/bl
1XLiJx77cdG8RrJHdtcAZHYNC08Nkw5c62uM0MNhAB6B06h9czfFokCLLlbnLNmg
ZPsNuHkSsCosnSS96ROze6RCO60LqhlLwpzlrFNC7z6ZOo3ev/53Btf/TU0ViaCg
HrEI8g3fovVlzazlbxuF
=JekS
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--

--===============0897759274681718998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897759274681718998==--
