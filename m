From: Giuliano Pochini <pochini@shiny.it>
Subject: [RFC] Echoaudio driver
Date: Tue, 31 Aug 2004 11:17:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040831111710.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


I'm developing the driver for Echoaudio cards for more
than a year and it is stable and it supports almost all
features of eight different soundcards. I think it's
near ready for inclusion in the official ALSA distro. Is
there someone who has time to have a look at the code ?

There are some known issues, though:

- Licence. Part of the driver is based on the reference
code released by the manufacturer with a BSD-like licence:
http://www.echoaudio.com/Downloads/license_agreement.php
and I'm not sure if it's fully GPL-compatible. (Firmwares
and headers are mostly unchanged. *_Dsp.c are 70% a direct
translation from C++ and the rest is all mine)

- Userspace firmware loading is still missing.

- Coding style: yes, I'll replace all C++ comments :)


The code is here: http://xoomer.virgilio.it/g_pochini/ea.html

Comments, suggestions, new hardware, are welcome.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
