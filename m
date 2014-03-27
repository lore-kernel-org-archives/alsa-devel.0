From: Matthias Larisch <mail@matthias-larisch.de>
Subject: [PATCH] src/pcm/pcm_ladspa.c: Delay LADSPA plugin
	activate call
Date: Thu, 27 Mar 2014 19:05:10 +0100
Message-ID: <20140327190510.5cf481d0@purefruit>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3229150919111843116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mlh-server.de (mail.mlh-server.de [5.9.104.232])
 by alsa0.perex.cz (Postfix) with ESMTP id DAF7E26546E
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 19:05:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============3229150919111843116==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/cJN6EihMsshGObf2RJ23_Xd"; protocol="application/pgp-signature"

--Sig_/cJN6EihMsshGObf2RJ23_Xd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Some LADSPA Plugins rely on connected control ports on activate call.
While this is not okay by spec, the spec also encourages the activate
call happening as late as possible.

Signed-off-by: Matthias Larisch <mail@matthias-larisch.de>
---
 src/pcm/pcm_ladspa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 9ce5242..7d1e3df 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -645,8 +645,6 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t
*pcm, snd_pcm_ladspa_t *l return -EINVAL;
 			}
 			list_add_tail(&instance->list, &plugin->instances);
-			if (plugin->desc->activate)
-				plugin->desc->activate(instance->handle);
 			if (plugin->policy =3D=3D SND_PCM_LADSPA_POLICY_DUPLICATE)
{ err =3D snd_pcm_ladspa_connect_plugin_duplicate(plugin, &plugin->input,
&plugin->output, instance, idx); if (err < 0) {
@@ -664,6 +662,8 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t
*pcm, snd_pcm_ladspa_t *l assert(err >=3D 0);
 			err =3D snd_pcm_ladspa_connect_controls(plugin,
&plugin->output, instance); assert(err >=3D 0);
+			if (plugin->desc->activate)
+				plugin->desc->activate(instance->handle);
 		}
 		err =3D snd_pcm_ladspa_check_connect(plugin, &plugin->input,
&instance->input, depth); if (err < 0)
--=20
1.9.1

--Sig_/cJN6EihMsshGObf2RJ23_Xd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNGhkAAoJEA3wWo+7JR3fFs4QALy9M7n7ohwvMg5sbwtgjeSU
qIJFHQ/YJuxPoVcwOgdVM0pfhSj0qb1KOkntnfCnCDGXa8FsaBIjp5MUWpwyl1G3
0A6zIYExEwWVnN8VsZz1iaf1cKTOljtUtQYtmeoQ8pUll+SgbimxFndABAC3nVSu
7sHoKQu+p6MDe9sm/sn3BMNpr2cIE1uz0zAnDzdeImvQgQessYzTl+ejkz0lxwR3
0FdvAfgBuxPRHgKQNbX+QfBIQs5Q9Hb/J5oYHJN83MXdGH2DOT39ZTkCEWVpTG95
q6hXLZIY3Cnjolcgn15qFHAsPFbpvS8xUb5JvNzKZbVXAHzUR6C3iDrVG8R9uPuj
t/be7xfSP3UPnqmAHGz3VZn5qfSXwtYmvzzDWRGQwH4ZCNb67tiGverxiZZ2V1ko
gRO3xcoBZCdEBrK94QFTfK44If8LkOQ/Iz2HZdbThi+9Xgo+npb9hOnjWqA4Wbs2
wzqUH28VNG+qi1VOQGojgFlnkDV8SAJ/os/K1/q+q1EX0e83ismKpK9xUDt6Ikbp
w+5JpYVoyGkMLWnV03nRrHz+w9zBTIIv8pYdnvR0CQnoZAsRQMb72IpApp81V/HL
L+PN02Vr7B4V44oflu7A1d+uWhK4CQJ127Qwimh3skrioRBF5gPmRv91fp+Tj129
x/7CI0XmjRs3yRz32a4l
=Gu7r
-----END PGP SIGNATURE-----

--Sig_/cJN6EihMsshGObf2RJ23_Xd--

--===============3229150919111843116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3229150919111843116==--
