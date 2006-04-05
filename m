From: James Courtier-Dutton <James@superbug.co.uk>
Subject: amd64 bus error
Date: Wed, 05 Apr 2006 12:36:50 +0100
Message-ID: <4433ABD2.6030704@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Here is a backtrace of a alsa application that ran for about 1 hour 
before giving this:

[New Thread 1098918240 (LWP 23392)]

Program received signal SIGBUS, Bus error.
[Switching to Thread 1098918240 (LWP 23392)]
0x00002aaaac51bcc8 in ao_alsa_loop (iarg=<value optimized out>)
    at start_alsa.c:494
494                     if (poll (pfd, nfds, 200000) < 0) {


Have we had any bus error type fixes to alsa-driver between the current 
ubuntu alsa version and the latest?
The poll() call above is with alsa file descriptors.

James



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
