From: Rene Herman <rene.herman@keyaccess.nl>
Subject: GIT tree usage.
Date: Tue, 10 Jun 2008 23:19:12 +0200
Message-ID: <484EEFD0.4070804@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 76076245C6
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 23:19:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Good day.

I have been using Takashi's "sound-2.6" GIT repo:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

for pulling current ALSA (branch master) into the stock kernel tree and 
while rebuilding stuff thought I'd try switching to the official ALSA 
GIT repo(s). I'd like to make sure that I am now using the right trees 
and branches...

I start out locally with a fresh linus clone:

$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 local

and then want to pull latest ALSA into it:

$ git remote add alsa git://git.alsa-project.org/alsa-kernel.git
$ git remote show alsa
* remote alsa
   URL: git://git.alsa-project.org/alsa-kernel.git
   Tracked remote branches
     for-linus linux-2.6 master
$ git checkout -b current
$ git merge alsa/master

Am I using the right tree and branch for this? And is this branch being 
rebased?

Rene.
