From: Shane Walton <dsrelist@yahoo.com>
Subject: ALSA-0.9.0rc2 and RME HammerFall
Date: Wed, 4 Sep 2002 09:03:47 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020904160347.95202.qmail@web20809.mail.yahoo.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Is there any know problems with 0.9.0rc2/Linux
2.4.19/RME HammerFall.  I had a working application
using 0.9.0beta6/Linux/2.2.19/RME HammerFall, since I
am changing to a Intel P4 arch, I can't get the beta6
to work.  It fails on an ioctl with something about a
PVERSION...  I would like to use a new version of ALSA
but I can only get one channel to work.  In other
words, when I try to read from the HammerFall
configured as non-interleaved and two channels, I get
all zeroed data.  When I try to read from the
HammerFall configured one channel (mono), I get real
data, but it has not been checked for validity.  Is
this possibly a bug?  Thanks for the help.

=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
