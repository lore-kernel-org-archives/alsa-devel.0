From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: patch for speaker-test to support 8 channels
Date: Thu, 17 Feb 2005 23:45:00 +0000
Message-ID: <42152C7C.7000404@superbug.co.uk>
References: <92C0412E07F63549B2A2F2345D3DB515F7D640@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D640@cm-msg-02.cmedia.com.tw>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?Big5?B?IlRpZW4sIEMuTC4gLSCl0KnTwqci?= <cltien@cmedia.com.tw>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tien, C.L. - =A5=D0=A9=D3=C2=A7 wrote:
> Hi,
>=20
> During testing cm8768 for 8 channels playback. I found the speaker-test
> can show up to 6 speakers name correcly, so I made following patch to a=
dd 8 channels support:
>=20
> --- alsa-utils-1.0.8/speaker-test/speaker-test.c	Sun May 16 09:43:29 20=
04+++ alsa-utils-1.0.8-update/speaker-test/speaker-test.c	Wed Feb 16 20:0=
7:10 2005@@ -55,7 +55,9 @@
>    "Rear Left" ,
>    "Rear Right" ,
>    "Center" ,
> -  "LFE"=20
> +  "LFE",
> +  "Side Left",
> +  "Side Right"
>  };
> =20
>  static void generate_sine(signed short *samples, int channel, int coun=
t, double *_phase) {
>=20
> Sincerely,
> ChenLi Tien
>=20

Did you look at http://www.alsa-project.org/~james/speaker-test/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
