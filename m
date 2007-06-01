From: David Topper <topper@virginia.edu>
Subject: Configure problems for alsa-utils-1.0.4
Date: Fri, 01 Jun 2007 13:32:49 -0400
Message-ID: <46605841.20709@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fork2.mail.virginia.edu (fork2.mail.Virginia.EDU
	[128.143.2.192]) by alsa0.perex.cz (Postfix) with ESMTP id 55A21246F8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 19:31:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by fork2.mail.virginia.edu (Postfix) with ESMTP id 4A8561BFE7
	for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2007 13:31:09 -0400 (EDT)
Received: from fork2.mail.virginia.edu ([127.0.0.1])
	by localhost (fork2.mail.virginia.edu [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 25970-08 for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 13:31:09 -0400 (EDT)
Received: from [128.143.140.146] (pawn.music.Virginia.EDU [128.143.140.146])
	by fork2.mail.virginia.edu (Postfix) with ESMTP id 1FBE91BEFF
	for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2007 13:31:08 -0400 (EDT)
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

So I've managed to compile alsa-drivers-1.0.4 for ARM.  I can even load 
the modules.  I've also successfully compiled alsa-libs-1.0.4 ... but I 
had to do it on the board.  Cross compiling simply didn't seem to work.

I've been using --prefix=/ and --exec-prefix=/ for configures.

But when I do ./configure --prefix=/ --exec-prefix=/ for 
alsa-utils-1.0.4 it fails with:

checking for libasound headers version >= 0.9.0... not present.
configure: error: Sufficiently new version of libasound not found.

But they're there, for sure.  Perhaps it doesn't like looking in 
/include/alsa?

Thanks,

DT
