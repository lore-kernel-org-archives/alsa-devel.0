From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: still hammerfall-mem on hdsp?
Date: Fri, 16 Jan 2004 23:20:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040116222019.GA12671@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

hope this list is o.k. for this question:

I try to get the alsa-drivers for the hdsp compiled with alsa-cvs of
today. After successful compile the snd-hammerfall_mem module doesn't
seem to be compiled and thus can't get modprobed. Isn't it needed any
more? I couldn't find any information about that in the docs.

Maybe someone can help with configure options or anything to get the
module compiled (the snd-hammerfall_mem.c file is there but the .o
file is missing) if it is needed or what else to do to get the rme
working.

The docs I found reflect my last knowledge that you need to modprobe
snd-hammerfall_mem and snd-hdsp first and then run hdsploader to
install the firmware.


Thanks,
Orm


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
