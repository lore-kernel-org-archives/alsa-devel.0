From: Paul Davis <paul@linuxaudiosystems.com>
Subject: trident driver bug
Date: Wed, 19 Mar 2003 13:10:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303191810.h2JIA2o01270@linuxaudiosystems.com>
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

there still appears to be a bug in the trident driver. i have been
running jack with a period size of 1024, and it works fine. when i
change that to 4096 frames, the kernel does a hard oops, with the oops
occuring in enable_hlt(). the rest of the trace doesn't make much
sense, and i cannot feed it to ksymoops because the machine locks
hard.  what can i do to make it eas(y|ier) to debug?


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
