From: p z oooo <pzad@pobox.sk>
Subject: VIA 8233A with ALC650 codec
Date: Mon, 24 Feb 2003 08:34:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302240734.IAA27436@www2.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This weekend i tested via8233a + alc650.
Surround output jack is swaped with center/LFE jack (but not controls=20
in mixer - surround control controls volume of center/LFE, ..)
Please change condition in via82xx.c

unsigned short val;
if (runtime->channels > 4)
    /* slot mapping: 3,4,7,8 */
    val =3D 0;=20

to=20

if (runtime->channels < 5)

then everything works ok.

Thanks
Peter Zubaj

=0A____________________________________=0Ahttp://www.pobox.sk/ - urcujeme t=
rendy=0A


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
