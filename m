From: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Subject: intel8x0 not working in kernels greater than 2.6.9
Date: Fri, 19 Nov 2004 19:22:00 +0100
Message-ID: <ae4c715704111910226dae85f4@mail.gmail.com>
Reply-To: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all ;),

I got alsa working in 2.6.8, but after installing 2.6.9, sound just
vanished :(. Using native alsa or oss emulation makes no difference,
and i've tried all kind of applications (mpg123, ogg123, xine,
alsaplayer...). Logs are full of messages like
this:

codec_read 0: semaphore is not ready for register 0x2c

I've tested 2.6.9 and 2.6.10rc2 with the same bad results. Reverting
to 2.6.8 cause sound  to work again.

TIA,

--=20

David G=F3mez


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
