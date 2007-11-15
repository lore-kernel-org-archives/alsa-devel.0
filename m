From: Ben C <bchang_2@yahoo.com>
Subject: alsa-lib module path question
Date: Thu, 15 Nov 2007 12:14:39 -0800 (PST)
Message-ID: <674790.40730.qm@web36512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36512.mail.mud.yahoo.com (web36512.mail.mud.yahoo.com
	[209.191.85.12]) by alsa0.perex.cz (Postfix) with SMTP id 5B9DF247C6
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 21:14:41 +0100 (CET)
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

I've written an ALSA external PCM plugin for a client's embedded device. During the client's compilation of alsa-lib (which I have no control over), they did not specify where the module directory should be at. In fact, they're using 1.0.13 where there isn't a configure option to specify the module directory  (this was added 1.0.14?). Since this is an embedded project, due to cross compilation, alsa-lib is currently looking at some host directory that does not exist on the target to search for the libasound_module_pcm_xxx.so files. What's worse is that seems like it is dependent on where the client decides to build the RFS (say from /home/joe/project/xxx, but then later /home/bill/project/yyy) -- the alsa-lib module directory could change.

For now I've manually created the non-existent host directory on the target and dropped a symbolic link there. But since that could change should they decide to rebuild the RFS, that's not even a viable bad hack solution.

Is there any environment variable, configuration option or some other methods where this could be overwritten at runtime?

Thank you,
Ben




      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
