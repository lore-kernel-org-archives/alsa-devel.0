From: "Ulrich Zadow" <ulrich.zadow@ARTCOM.DE>
Subject: snd_pcm_open hangs intermittently?
Date: Mon, 11 Mar 2002 15:11:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <C1E3CFAE25BBCB45AAB06733BDC048DF18BBCC@tempo.INTERN.ARTCOM.DE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received: from tempo.artcom.de ([192.76.129.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA24520
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2002 15:11:18 +0100
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

snd_pcm_open() hangs on our machines about 1/10 of the time (ALSA =
0.9.12, RME and VIA686 cards). Our code looks about like this:

  snd_pcm_t * myDevice;
  cerr << "Opening sound device...";
  err =3D snd_pcm_open (&myDevice, "plughw:0,0", SND_PCM_PLAYBACK, 0);
  if (err < 0) {
    cerr << "failed." << endl;
  } else {
    cerr << "ok." << endl;
  }

The output of this piece of code is just "Opening sound device...". =
We're pretty sure that we're closing the device correctly before this =
happens.

Any ideas?

Regards,

  Uli
 =20

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
