From: Tom Watson <sdc695@yahoo.com>
Subject: Muting at startup in ICE1724 based devices
Date: Fri, 7 Nov 2003 16:32:09 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031108003209.80199.qmail@web21501.mail.yahoo.com>
References: <E1AIFvE-0005PO-00@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1AIFvE-0005PO-00@sc8-sf-list2.sourceforge.net>
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

A while ago (about 1 week), there was a message noting that ICE1724
based devices (I have a revolution 7.1) mute the left-front channel (or
the first channel) on startup.  This happens even though you set the
level to something and the startup routines seem to set it.  Any simple
adjustment to the level (via alsamixer, or alsactl) will properly set
the level.  This seems to happen ONLY on the first channel (LeftFront),
and just for the first setting of the day (boot).

I didn't see any modifications that address the problem (of course that
doesn't mean they didn't exist), and was wondering if anything has been
done to address this problem.

Thanks for the info.

p.s.  At the moment I have a work around, but a fix would be nice!

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
