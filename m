From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: Interrupt-driven (or callback/handler?), Full-duplex (simultaneous capture/playback) without using JACK
Date: Sat, 8 Nov 2003 16:18:46 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000b01c3a657$0b150b80$264440ab@roboserv1>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: ryanc@ieee.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I am trying to write an application that uses ALSA interrupt-driven
(which I guess is obtained by adding PCM handler(s) in ALSA?),
full-duplex (simultaneous capture/playback) using the ALSA PCM API
directly (i.e. not using JACK).

My question: do I only need to register one callback/handler function to
take care of both capture and playback?  My hope is that when I link the
capture and playback streams, and register a single handler with either
capture or playback, this handler will be called whenever there is BOTH
capture data to be read and a free playback buffer to be written (?).
Is this the case?

Any help, info., or advice GREATLY appreciated.

Cheers, rjc.
--
Ryan Cassidy
Electrical Engineering Graduate Student, CCRMA Researcher
Stanford University
E-mail: ryanc@ieee.org
 




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
