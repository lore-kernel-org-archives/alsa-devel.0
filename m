From: Gorka Olaizola <gorka@escomposlinux.org>
Subject: Re: Channels jumping with snd_intel8x0, nforce2 and 5.1 output
Date: Mon, 5 Jan 2004 18:59:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040105175916.GA22830@helvete.escomposlinux.org>
References: <20040104175552.GA16063@helvete.escomposlinux.org> <s5hk74631z0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-Message-ID: <20040105201819.GA25439@helvete.escomposlinux.org>
Resent-To: alsa-devel@lists.sourceforge.net
Content-Disposition: inline
In-Reply-To: <s5hk74631z0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2004 at 03:27:15PM +0100, Takashi Iwai wrote:
>=20
> does this happen with 4.0 output?
>=20
With 4.0 and 4 channels it doesn't seem to happen.

Output while using #speaker_test -Dsurround40 -c 4 -r 48000

cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 4
rate: 48000 (48000/1)
period_size: 1200
buffer_size: 4800
tick_time: 1000

cat /proc/asound/card0/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1200
xfer_align: 1
start_threshold: 4800
stop_threshold: 4800
silence_threshold: 0
silence_size: 0
boundary: 1258291200

cat /proc/asound/card0/pcm0p/sub0/prealloc
64


The output of  #speaker_test -Dsurround51 -c 6 -r 48000
is the same than the above one but with 6 channels.

Sometimes, when the channel jumping happens in surround51, playing
speaker_test with surround40 scrolls the channels too (The rear speaker
play instead the front speaker). Playing speaker_test
again and again in surround40 mode does not seem to scroll the channels.
They stay changed until I change them in surround51 mode.

If I change the period_size and buffer_size in the speaker_test code
to 1024 and 8192, the values stay the same in surround40 mode but the
buffer_size value change to 5120 in surround51 mode. I don't know if it does
matter.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+aX0AJWwPWWa2yoRAsu+AKCrKsRscHNsrk4Du1qO7ghxKyRzRgCgna6Y
2DrxOb4pfs69tkn7QKIWHgo=
=+ixK
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
