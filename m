From: Jaroslav Kysela <perex@perex.cz>
Subject: Merging alsa-driver and alsa-kmirror to one GIT repo
Date: Tue, 24 Jul 2012 15:17:57 +0200
Message-ID: <500EA085.8090105@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 055F326527C
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 15:17:13 +0200 (CEST)
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

Hi all,

	I believe, it's time to manage only one GIT repository for the
alsa-driver package now. The merge has benefits mainly for the end users
- bisecting may work, the correlation between kernel sources and our
out-of-kernel build framework becomes more strong.

	I merged the alsa-driver and alsa-kmirror repos with full history. I
also added some code changes to enable the "build-in" mirror tree in
Makefile and gitcompile from v1.0.18 (but I don't think that it will be
used).

	The structure of new repository is similar, but the kernel mirrored
code is located in the mirror/ subdirectory. The paths are exactly same
as in the Linux kernel tree, so possible patches can be applied without
any path modifications. Of course, we may create a bash script to do
proper and full cherry-picks between kernel and mirrored trees
(comments, author, dates).

	New temporary repository has name alsa-driver.new:

http://git.alsa-project.org/?p=alsa-driver.new.git;a=summary

	The another difference is that the releases are now branches not tags.
It allows me to do quick fixes out of the standard development or
separate the main development in the release time window (to not include
some very new code). The previous branches won't contain probably any
additional commits, but it's probably better to play with only one
reference scheme.

	I think that the change from alsa-driver.git to alsa-driver.new.git
should be quick. Please, report any objections or acks now.

	Schedule: When accepted, I will rename the original alsa-driver.git
repository to alsa-driver.old.git and move alsa-driver.new.git to
alsa-driver.git quickly.

	1.0.26 release: This was my last big change (with the ALSA server
upgrade) which blocked me to do the 1.0.26 release. I'm going to create
new release after the repos switch ASAP.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
