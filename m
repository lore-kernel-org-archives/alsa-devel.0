From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 14:11:24 +0100
Message-ID: <200411151311.iAFDBKks005459@www5.pobox.sk>
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

>This approach sounds interesting. Unfortunately my impression after
>looking at the code is that the plugin interface only works with PCM.
>Also
>the library seems to be build tightly around ALSA kernel drivers and
>taking ALSA's place as the "hardware" driver (for the default and hw:*
>devices).

AFAIK every interface (control, pcm, midi, ...) in alsa can have it's
own plugins. These plugins can be compiled in lib and load at runtime
through .asoundrc file. I think, it is possible to even create virtual
user space soundcard. Only compilation depends on internal alsa-lib
heades (*_local.h) and on kernel asound.h file.
And these local headers can change at any time without warning.

But you should check LICENSE if you can use internal alsa-lib headers
and asound.h header.

If you implement your own alsa-lib you will be always one (or more)
step behind ALSA, and it will cost you too much. And missing functions
implementations can by problems too.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 spolahliva a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
