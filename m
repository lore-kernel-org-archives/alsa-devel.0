From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 12:25:29 +0100
Message-ID: <200411151125.iAFBPN9Z031710@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: hannu@opensound.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am not alsa-developer, but:

Would be simpler and faster to implement only alsa-lib plugin as whole
alsa-lib (I never tryed this) ????

And if you create new alsalib (SALSA) you will overwrite old one -
this will prevent ussage of both sound systems at same time.
For example soundcard 1 uses ALSA and sound card 2 uses OSS.

Look at pcm_jack.c (from alsa-lib) - this plugin implements output to
jack from every alsa app (I think).

I think API is stable, but I think kernel api can be changed, because
these changes will be hiden in alsa-lib.

Peter Zubaj
=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
