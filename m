From: Giuliano Pochini <pochini@shiny.it>
Subject: Control attribute
Date: Sat, 13 Nov 2004 22:57:32 +0100
Message-ID: <20041113225732.69cefe2d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Some ctl interface elements may change without an explicit request of the
application. I know there is the SNDRV_CTL_ELEM_ACCESS_VOLATILE attribute,
but it matching the behaviour of some control very well. My driver has two
controls that are somewhat related: Sample clock source switch and Digital
mode switch. They never change if nobody touches them, but if an app changes
the digital mode also the clock source may change. For example if dmode is
ADAT and clock source is ADAT and the user sets dmode=S/PDIF, the driver
must switch the clock source to something compatible with the new dmode. Is
SNDRV_CTL_ELEM_ACCESS_VOLATILE the right flag ? I don't think so, but there
are no other suitable flags AFAIK.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
