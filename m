From: Wolfram Schlich <lists@wolfram.schlich.org>
Subject: configure PDE detection seems to be broken
Date: Mon, 13 Oct 2003 09:19:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031013071914.ALLYOURBASEAREBELONGTOUS.H27165@bla.fasel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA-Devel mailinglist <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

please have a look at this Gentoo Linux Bugzilla entry:

	http://bugs.gentoo.org/show_bug.cgi?id=29965#c11

The PDE detection of the configure script seems to be broken (switch
lines 1033 and 1034 of configure.in to fix).
Linux 2.4.23-pre7 does have a PDE function but it's not detected,
thus, compilation fails.
-- 
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
