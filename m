From: Gustavo Guillermo <gustavo@compunauta.com>
Subject: [REPORT as said in via82xx.c] ad1980 Asus A7V8X-X Working
Date: Mon, 12 Jan 2004 06:12:04 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040112.6120400.1307345935@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, gus_est_prgms@yahoo.com
List-Id: alsa-devel@alsa-project.org

I'm use via82xx module for ad1980 Asus A7V8X-X with option dxs_support=3D=
1=20
and weird sounds gets out, master channel volume seems to be Surround,=20
and VIA DXS (first one) needs to be at 75% to hear full volume, other=20
positions doesn't work.

PCM sound from whatever is a little bit weird because conversion to 48k,=
=20
but just fine, if we use arts, we can set sampling to 48k and everything=
=20
is perfect.

I will try to modify, by my self surround by master channel from=20
via82xx.c, but when I finish the read of documentation of api (I'm newbe=
)

Best regards.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
