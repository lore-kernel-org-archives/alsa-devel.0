From: "John W. Cocula" <john@cocula.com>
Subject: intel8x0.c doesn't do mic capture
Date: Tue, 20 Jan 2004 00:06:04 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <65148.138.88.11.209.1074575164.squirrel@cocula.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

Hi all,

In early December, Takashi updated intel8x0.c to allow fixed rate mic
capture, but it doesn't work on a Realtek ALC650 rev 3 chip.  It records
snow.  Can anyone confirm/deny my finding, and can anyone tell me what *I*
can do about it?  I haven't written a kernel device driver since 1989, but
I'm willing to dive in and try to fix it, if someone can shine a light on
the right path for me to follow.

Thanks in advance to any ALSA developers who can help me help myself, and
the project.

Best,
John




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
