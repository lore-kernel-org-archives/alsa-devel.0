From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: CMI8768 patch
Date: Wed, 23 Feb 2005 11:42:53 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D658@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/2/22 [=ACP=B4=C1=A4G] =A4U=A4=C8 02:51
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] CMI8768 patch
At Wed, 23 Feb 2005 03:07:02 +0800,
Tien, C.L. wrote:
>=20

> But the aplay -D default still shows:
>=20
> ALSA lib pcm.c:2068:(snd_pcm_open_noupdate) Unknown PCM 0
> ALSA lib pcm_dmix.c:868:(snd_pcm_dmix_open) unable to open slave
> aplay: main:508: audio open error: No such file or directory

Hmm, are you using CVS version of alsa-lib or 1.0.8?
The config file I sent was for CVS version.

The message was created with alsa-lib-1.0.8 on RedHat 7.3 (kernel =
2.4.26)
Now I switch to CVS on FC3. I found the result is opposite:

alsa-lib-1.0.8+RH 7.3, front, rear can be used as -D option, while =
default shows the above message.

alsa-lib CVS+FC3 it is ok to "aplay" directly or "aplay -D default", but =
either front or rear I got
ALSA lib pcm.c:1939:(snd_pcm_open_conf) Cannot open shared library =
/usr/lib/alsa-lib/libasound_module_pcm_softvol.so
aplay: main:508: audio open error: No such file or directory

The libasound.so.2.0.0 is installed successfully and there is no =
/usr/lib/alsa-lib path
in my system (should I create?) Please help!

Sincerely,
ChenLi Tien

Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
