From: Tom Watson <sdc695@yahoo.com>
Subject: Echo Echo Echo (or a small delay)
Date: Wed, 27 Aug 2003 23:10:24 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030828061024.27950.qmail@web21505.mail.yahoo.com>
Reply-To: tsw@johana.com
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm trying to make a player work with 4 channels.  I've got a Turtle
Beach Santa Cruz card, and it has (at least) 4 outputs, divided into
(this is a bit difficult to explain :-) "front" and "back".  Now I have
the proper library calls all setup and I send "interleaved" data which
IS in time sync from one channel to another.

The problem is that the back channels get out of sync with the front
ones, causing an echo.  This proceeds for a while getting a little
longer in the delay, then it "all of a sudden" seems to correct itself.
 During this "delay inducing" period, "clicks" appear in the sound.  I
can only assume that the clicks are the product of the delay on the
pair of channels that get out of sync.

Why does this happen (I've even heard it with "aplay"), and even
better, how do I stop it.

HELP!!
I'm under a bit of time pressure (what else is new!!).

p.s.  Most of the setup I'm doing is grafted from the test program
"pcm.c" (the one that generates sine waves).

...Thanks!

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
