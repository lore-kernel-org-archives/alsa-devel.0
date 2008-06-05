From: Eliot Blennerhassett <linux@audioscience.com>
Subject: git workflow for casual developers
Date: Thu, 05 Jun 2008 16:57:22 +1200
Message-ID: <200806051657.22205.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 47078103839
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:57:14 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z005XI4FBXB80@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:57:13 +1200 (NZST)
Content-disposition: inline
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

Hi all,

So. we are now using git repositories. I'd better find out how to use git...

I plan to turn responses to this into a howto here
http://alsa-project.org/main/index.php/GIT_Server
I.e. what should someone do who is going to clone the repo, make a few 
changes, then email patches to a maintainer + alsa-devel?

0) clone the repository
    git clone git://git.alsa-project.org/alsa-driver.git alsa-driver 
    git clone git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror 

What should I do next if I want to make some changes?
Here's what I did, or discovered I should have done :(

1) git-config --add user.email me@domain.com
Otherwise commits get spurious email address for Author and Commiter (is there 
any way to fix this after the fact?)

2) should I create a branch in my cloned repo for my changes, or just go ahead 
and commit?
(I didn't create a branch)

3)  How do I generate patches for my changes to the repo?
Luckily for me there was a tag that was close enough so I could
git-diff v1.0.17rc1

Should I really have used this as the "revision"?
git-diff remotes/origin/master

Then do this to generate the patchset
git-format-patch -s -n -p --subject-prefix="PATCH - my module" v1.0.17rc1

4) Check the patches
/lib/modules/2.6.24-17-generic/build/scripts/checkpatch.pl --no-tree *.patch

5) Sending the patches
Make sure it knows how to send
git-config --add sendemail.smtpserver smtp.domain.com

git-send-email --from=me --to=tiwai@suse.de --cc=alsa-devel@alsa-project.org 
000*.patch                                           

6) OK, what have I missed?

regards

-- 
--
Eliot Blennerhassett
www.audioscience.com
