From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Programming Interface for Kernel 2.6.8
Date: Wed, 08 Sep 2004 10:15:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409081003240.20437-100000@studcom.urz.uni-halle.de>
References: <20040907103237.46836.qmail@web8503.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040907103237.46836.qmail@web8503.mail.in.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Dinesh=20Ahuja?= <mdlinux7@yahoo.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dinesh Ahuja wrote:
> I have build and installed Kernel 2.6.8 which has a
> ALSA support. I want to do a programming with ALSA
> API's and for that I should get the hold of developers
> kit which will provide me all the neccessary headers
> and libraries to work with.

Headers and library are part of the alsa-lib package:
<ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.4.tar.bz2>

The documentation can be generated from the source files (run "make
doc" in the alsa-lib directory, if you have doxygen) or is available
online at <http://www.alsa-project.org/alsa-doc/alsa-lib/> (well,
currently it isn't).

There are some other packages containing utilities and some hardware-
specific tools for certain sound cards.  The source files in
alsa-utils can be helpful as examples how to use the ALSA API.
<ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.0.4.tar.bz2>
<ftp://ftp.alsa-project.org/pub/tools/alsa-tools-1.0.4.tar.bz2>
<ftp://ftp.alsa-project.org/pub/firmware/alsa-firmware-1.0.4.tar.bz2>
<ftp://ftp.alsa-project.org/pub/oss-lib/alsa-oss-1.0.4.tar.bz2>


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
