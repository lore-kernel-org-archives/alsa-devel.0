From: "Quod E. Demonstrandum" <nib_maps@yahoo.com>
Subject: apm and alsa driver for intel8x0 on dell inspiron 8200
Date: Sun, 16 Mar 2003 17:44:02 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030317014402.43727.qmail@web21010.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Hello,

It would seem that apm/acpi access (reading /proc/apm
or /proc/acpi, whichever is compiled into the kernel)
corrupts sound on my computer, a dell i8200 running
linux 2.4.20 and alsa 0.9.1.
This does not happen with the OSS driver.  Moreover,
gnomemeeting seems to work well, but .wav samples
played by esd get corrupted if apm/acpi is accessed
while they are played.

Is this a known phenomenon?
I know nothing about the ALSA project, but I can code:
could you give me a few tips as to where to start
debugging this?

Thanks.


__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
