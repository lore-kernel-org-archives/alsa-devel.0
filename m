From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: firmware core: Add core support
 for dynamic kcontrols and widgets.
Date: Tue, 20 Nov 2012 11:36:09 +0900
Message-ID: <20121120023606.GB4483@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-3-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6714652275300546698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 902CF264FEB
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 03:42:21 +0100 (CET)
In-Reply-To: <1353348765-6238-3-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6714652275300546698==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JyUo+2rKuw1VKSUr"
Content-Disposition: inline


--JyUo+2rKuw1VKSUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 06:12:44PM +0000, Liam Girdwood wrote:

> @@ -584,6 +584,8 @@ struct snd_soc_dapm_widget {
>  	int num_kcontrols;
>  	const struct snd_kcontrol_new *kcontrol_news;
>  	struct snd_kcontrol **kcontrols;
> +	int denum;
> +	int dmixer;

In the patch adding the actual functional code it looks like these are
just treated as booleans saying if the control is dynamic.  This in
conjunction with the fact that we've got a single list of dynamic
controls means that we can only have one block of dynamic controls on
this device.  Is that correct?  If not then I've got the wrong end of
the stick otherwise...

It occurs to me that if we just assign these to numbers per thing with
firmware then we can easily use this data structure to support multiple
firmwares per device.  We just go through the list and delete all mixers
numbered 1 or something.  If we do that I think we can simplify the code
a little and just make all the mixers and controls "dynamic", using ID 0
for the non-changable ones.

The patch itself looks good but leaving it for now since it's so closely
tied in with patch 4, any change in patch 4 is likely to give changes in
the data structure I guess.

--JyUo+2rKuw1VKSUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQquyDAAoJELSic+t+oim9rXIP/i6KXeA1rCYzu5kwPlsmhYzh
7lX0qJMo1S/pcU//oQYs5xTUlzO8cbk9VjpR+HAfHDHmL3zMHlpFw3NN8QGdl2nt
gFSjh2/4vmpuUztwQACsrTwRqBn2Wq68bEQMiyGQn1C4WjjRjyHxMl3Bzfb72E8r
jWlTtI+zJmDbiYgt0+CsNxi8oR8PYqTu7Dxm6U2DMNXYPnJjzdPcXGf2jalsyo4j
aBg96UxYVrn4f04n9byS+0bmbh2f6TKIQGHnSdg0OSdXfSZ9POqX3zhcyy1wwOJj
lE0Cm3wm9FACwP1nMgnGNeI7KSrGUL2Ge+bZj/6DWN72FxZ8vrJ72FKOwcswW+6S
c5sWWaZIZcC+OCfeBZWcZCxCHtAURth4z+ZvouMTPZf2Ghu1iiyAraahBDh+gC9P
9WAWRoUBmL4g6JSQlMBt7o6BURFgAL+F1fyUGDNOpigY8Q+8fVpdpIoPgl0KpBMJ
fr6NYOx/RGDKTegd56EVQNb0/RmvswmvMKEORw/c23DK9leJKl6w1aQ9AM/BBDKc
dV9Csmf7CloPcX405zE2UcwNfsOFdfsqhLlD/3Vh4MZAC2n3L5k/LD5O06TRBl5C
/4R30/mSlnbkV0tiZZU7U3z7DMUNnXEUnHXswMgusuSNWmkbSP0jhoMhPOQHTr9d
PdWGfvOLNfqQtNx7ps6x
=KNwE
-----END PGP SIGNATURE-----

--JyUo+2rKuw1VKSUr--

--===============6714652275300546698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6714652275300546698==--
