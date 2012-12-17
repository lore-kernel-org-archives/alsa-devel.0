From: Jaroslav Kysela <perex@perex.cz>
Subject: The new alsa-driver repository
Date: Mon, 17 Dec 2012 16:52:28 +0100
Message-ID: <50CF3FBC.7010309@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABDD264F11
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 16:52:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello all,

	the ALSA server has new alsa-driver repository which contains several
branches for now:

master	- just empty one with README
build   - the previous master branch
	  (but all was moved to the alsa/ subtree)
mirror	- mirrored code from upstream (ALSA parts only)
release	- merging branch for mirror/build trees to create
	  a relationship between them

All branches are ophan. It means that they have no common parent.

I put some handy configuration hints to the ALSA WIKI:

http://www.alsa-project.org/main/index.php/GIT_Server#Syncing_the_branch_release_in_alsa-driver.git

The reason to move the old master branch to the alsa/ subtree is quite
simple - you can merge/pull the branch to the full linux-2.6 kernel tree
now and do your development there. Also, cherry picks between mirror and
the linux-2.6 tree should work.

Another handy extension - in the current repo - might be to create the
linux-2.6 branch with the whole upstream and create another branch for
merging the build branch with the whole tree like 'release26' or so. In
this way, we can manage another releases of the out-of-kernel build code
for the ALSA tree in stable linux kernel versions.

Comments, other ideas are welcome.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
