From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: aoss: problems with using functions in dlfcn.h
Date: Fri, 11 Jun 2004 00:56:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C8F53B.4010303@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F2DD198
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 01:56:48 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BYZPb-000GHU-0b
	for alsa-devel@alsa-project.org; Fri, 11 Jun 2004 00:56:47 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have an application (xine) that opens oss output from a plugin.
This plugin is loaded into xine using dlopen(), dlsym() and friends.
When, during runtime, dlsym() resolves the open() function, it bypasses 
aoss, and links directly to open() instead of linking to the aoss's 
version of open().

Is there any way to fix this problem with dlopen and friends.

Although we don't actually need aoss to work with xine, because xine has 
good native alsa support, it just highlights a possible problem that 
other apps might have.

James


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
