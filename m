From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Current CVS doesnt compile on latest RedHat
Date: Fri, 07 Nov 2003 12:43:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311071239240.21540-100000@studcom.urz.uni-halle.de>
References: <20031107110745.86961.qmail@web10101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20031107110745.86961.qmail@web10101.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: spetreolle@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sylvain Petreolle wrote:
> serialmidi.c:164: error: invalid operands to binary >

This is an incompatibility between the official Linux kernel and the
-ac patch.  Apparently, RedHat now includes this patch.

Change the offending line in serialmidi.c to

	if (atomic_read(&tty->count) > 1) {


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
