From: Linus Walleij <triad@df.lth.se>
Subject: Error in alsa-tools/seq/sbiload/Makefile.am
Date: Sat, 19 Jun 2004 09:22:38 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406190915290.2947@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

In the alsa-tools module of the CVS, the seq/sbiload/Makefile.am has an
incomplete EXTRA_DIST line, omitting several important files that must be
included in the dist. tar.gz-files. It currently reads:

 EXTRA_DIST = README COPYING depcomp

But shall read:

 EXTRA_DIST = README COPYING depcomp drums.o3 drums.sb std.o3 std.sb

Or the instrument patches does not come with the install... Perhaps these
should also be:

 instruments_DATA = drums.o3 drums.sb std.o3 std.sb

or similar so that the instruments get installed in /usr/share or similar.
(Not 100% about the syntax here right now.)

Yours,
Linus Walleij


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
