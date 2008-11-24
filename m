From: "Keith A. Milner" <maillist@superlative.org>
Subject: CVS, git, or something else?
Date: Mon, 24 Nov 2008 23:10:29 +0000
Message-ID: <200811242310.29792.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E621244AB
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 00:10:34 +0100 (CET)
Received: from [82.152.152.239] (helo=asmodeus.superlative.org)
	by apollo.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L4kZa-0004mt-A6
	for alsa-devel@alsa-project.org; Mon, 24 Nov 2008 23:10:30 +0000
Content-Disposition: inline
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

I've been trying to check out the latest alsa-driver source to do some work on 
it. I followed the instructions at:
http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers

But when I cd alsa-drivers and gitcompile, it fails:

make[1]: Entering directory 
`/homedirs/kamilner/Development/Workspace/alsa/alsa-driver/acore'
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #2 succeeded at 280 (offset 3 lines).
Hunk #3 succeeded at 306 (offset 3 lines).
Hunk #4 FAILED at 568.
1 out of 4 hunks FAILED -- saving rejects to file init.c.rej
make[1]: *** [init.c] Error 1
make[1]: Leaving directory 
`/homedirs/kamilner/Development/Workspace/alsa/alsa-driver/acore'
make: *** [dep] Error 1

Do I have the right version? Am I going about this the right way? I see a lot 
of posts on this list talking about CVS but none mentioning git.

Maybe I should be using CVS instead?


-- 
Keith A. Milner
