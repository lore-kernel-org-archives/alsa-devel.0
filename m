From: Pierre Ossman <ossman@cendio.se>
Subject: [RFC][PATCH] Transparent network support through polypaudio
Date: Mon, 13 Feb 2006 15:53:42 +0100
Message-ID: <43F09D76.9060004@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D65411C2
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 15:53:44 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

(Repost with attachment as link to avoid size restriction.)

Hi!

I've implemented an ALSA plugin that allows any well-behaved ALSA 
application transparently use the Polypaudio network protocol.

It is my desire to have this included in ALSA (-lib preferably) so that 
it will be included in most dists. So I'm posting this first version for 
review. :)

It only supports playback at the moment. Polypaudio will undergo some 
changes to allow a capture implementation, but that's not ready yet. 
I'll do a mixer plugin in the coming days.

Some comments on the design. Polypaudio's lib requires a decent mainloop 
abstraction. But ALSA does not force, or even allow, applications to 
provide one (nothing wrong with that, it keeps the API simple). It meant 
a creative solution was required to get this plugin running.

The solution is a design borrowed from the Avahi project. A second 
thread is started that does the poll() call. Communication with the main 
thread is done through a socket pair, and that file descriptor is fed to 
the application to poll. Since some applications do not use these in a 
sane manner (I'm looking at you mplayer) the mainloop abstraction is 
also run on most of the ALSA plugin callbacks.


Code:

http://www.cendio.se/~ossman/alsa-polyp-1.0.10.tar.bz2


This is also not a patch per se, but I needed some tag to get people to 
notice that code is included. :)

You will need to check out polypaudio from svn to compile and use this. 
Also, the repository path on polypaudio's web page is out of date. This 
is the current uri:

svn://svn.0pointer.de/polypaudio/trunk

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
