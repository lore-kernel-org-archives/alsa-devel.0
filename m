From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: configure error with alsa-driver-0.9.7a
Date: Fri, 10 Oct 2003 01:29:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F85FD72.6070805@superbug.demon.co.uk>
References: <000701c38d7f$538b31a0$fcf8e589@farnorth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA01289
	for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2003 02:24:38 +0200
In-Reply-To: <000701c38d7f$538b31a0$fcf8e589@farnorth>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Berry <pnberry@gustavus.ak.us>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Berry wrote:
> Hello kind alsa developers:
> 
> I was attempting to upgrade the alsa-drivers in an old system,  Redhat 7.0
> (upgraded to a custom compiled 2.2.20 kernel) that is presently using
> alsa-driver-0.9.0rc6.
> The system works fine, just wanted the latest drivers, but when I tried to
> upgrade to the 0.9.7a drivers the configure script stopped midway. I'm
> puzzled as I've compiled this kernel using the same gcc version (2.96) that
> I am attempting to use on for the new drivers.
> 
> Here is the configure report as requested and thank you in advance for any
> help.
> 
> Sincerely,
> Paul
> 
> checking for GCC version... Kernel compiler: gcc egcs-2.91.66 19990314/Linux
> (egcs-1.1.2 release) Used compiler: 2.96
> Fatal error: Compiler type does not match
> Decoded kernel compiler: type=egcs version=2.91.66
> Decoded used compiler: type=gcc version=2.96
> Please, send ./configure output to <alsa-devel@alsa-project.org>
> [root@FarNorth alsa-driver-0.9.7a]#
> 
> 

That message is correct.
You should NEVER compile kernel modules with a different compile than 
you did the kernel.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
