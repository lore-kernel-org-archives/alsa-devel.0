From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Sun, 20 Jul 2008 21:35:14 +0200
Message-ID: <48839372.7020509@keyaccess.nl>
References: <48838A54.40404@keyaccess.nl>
	<Pine.LNX.4.61.0807202104390.7676@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id E5FE524492
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 21:33:02 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0807202104390.7676@tm8103-a.perex-int.cz>
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

On 20-07-08 21:08, Jaroslav Kysela wrote:

> On Sun, 20 Jul 2008, Rene Herman wrote:
> 
>> Hi Takashi.
>>
>> Is there something wrong with your devel branch or is it me?
> 
> I think that you have to recommit your patches on top of new Takashi's 
> tree, because Takashi rebased his tree on top of Linus's tree.

Thing is, I'm rebuilding my "head" branch here and there wasn't anything 
local in it yet. I know that his sound-2.6 is rebased at releases (the 
devel branch; the master branch more frequently) so I was trying to pull 
that into a clean linus 2.6.26:

(branch master is an undisturbied linus tree)

$ git checkout -b head v2.6.26
$ git fetch tiwai
$ git merge tiwai/devel

As far as I'm aware, this should've merged cleanly.

(next step here is pulling in a few local branches into "head", such as 
Krzysztof's wss branch and other local stuff but that's after the above)

> Anyway, I just synced git.alsa-project.org to Linus's and Takashi's trees 
> a few minutes ago, too.

Yes, I tried that to

rene@7ixe4:~/src/linux/7ixe4$ git remote show alsa
* remote alsa
   URL: git://git.alsa-project.org/alsa-kernel.git
   Tracked remote branches
     for-linus linux-2.6 master

However, while a "git pull alsa master" merges cleanly, it merges _all_ 
of current linus' GIT tree onto me!

This I definitely do not want at the moment. I want to be running 
2.6.26, with just a selected set of changes, not just whatever changes 
Linus decided to merge. One of the changes I want is current ALSA, but 
as far as remote tracking branches go, nothing else...

Furthermore, given that alsa/master is rebased frequently, I cant use it 
anyway as a downstream person. If I'd want to stay current, I'd need to 
rebuild the entire head branch _every_ time I'd want current ALSA since 
I can't just pull alsa/master again -- after a rebase it clashes with 
what's already there in my tree.

That's basically the trouble with rebasing: your downstream can't sanely 
use your tree. Takashi said his devel branch would not be rebased during 
a single -rc cycle so I'm using that one...

Rene.
