From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: es1978 maestro-2e-rev10
Date: Fri, 23 Aug 2002 00:26:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020822222613.31490.qmail@web12207.mail.yahoo.com>
References: <Pine.LNX.4.44.0208221713430.10988-100000@aino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web12207.mail.yahoo.com (web12207.mail.yahoo.com [216.136.173.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA26509
	for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2002 00:26:20 +0200
In-Reply-To: <Pine.LNX.4.44.0208221713430.10988-100000@aino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: kai.vehmanen@wakkanet.fi, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 --- Kai Vehmanen <kai.vehmanen@wakkanet.fi> schrieb:
> With rc3 I get a
>=20
> "arecord: pcm_params.c:1051:
> _snd_pcm_hw_param_refine: Assertion '0'=20
> failed."
>=20
> error when running:
>=20
> "arecord -f cd foo.wav"
>=20
i get here lots of:
arecord: pcm_plug.c:68: snd_pcm_plug_close: Assertion
`plug->slave =3D=3D plug->req_slave' failed.

followed by:
Segmentation fault

usind snd-es1968 from rc3. you use that module with
2.4.18?

karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
M=F6chten Sie mit einem Gru=DF antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
