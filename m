From: "Ulrich Zadow" <ulrich.zadow@ARTCOM.DE>
Subject: AW: snd_pcm_open hangs intermittently?
Date: Mon, 11 Mar 2002 15:38:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <C1E3CFAE25BBCB45AAB06733BDC048DF13FA93@tempo.INTERN.ARTCOM.DE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received: from tempo.artcom.de ([192.76.129.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA24866
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2002 15:38:54 +0100
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > The output of this piece of code is just "Opening sound=20
> device...". We're pretty sure that we're closing the device=20
> correctly before this happens.
> >=20
> > Any ideas?
>=20
> It looks like that another task uses given device (perhaps=20
> some daemon=20
> like arts).

Is there a way to
  a) find out who's using it? and/or
  b) tell snd_pcm_open() to return with an error in this case?

  Uli

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
