From: "Brian Welch" <Brian-Welch@cox.net>
Subject: Installing a "different" version of Alsa
Date: Sat, 19 Dec 2009 21:48:16 -0700
Message-ID: <0640B473256C4948B7A16988809F8AB2@brianoffice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DFC424564
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 05:48:20 +0100 (CET)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao106.cox.net
	(InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP id
	<20091220044818.ZLRI18268.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 23:48:18 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

It's been a year since I posted to this list, but I'm running into a problem and can't figure out the best way to solve it, so I'm hoping someone here can help.

I've got an SDK for an embedded platform that includes a specific version of Linux with ALSA built-in.  On my platform, I want to use a different (newer) version of ALSA than the built-in version, so I want to build and load the binaries from the newer version and, more importantly, I want to compile my custom sound hardware driver against the newer alsa version and the SDK's Linux version.  I don't really want to touch the kernel files that are in the kerenl/include/sound directory in the SDK.

When I use kbuild to build my custom sound hardware driver against the SDK in the kernel, it always trys to pick up the older ALSA header files that are in the SDK, but I want to use the newer versions that are in the directory with the newer version of ALSA.  What the best way to make sure I get the correct headers?  Is what I'm trying "dangerous" and should I be going about this a different way?

Thanks for any advice,

Brian
