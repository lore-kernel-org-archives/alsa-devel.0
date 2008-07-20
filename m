From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Sun, 20 Jul 2008 22:04:37 +0200
Message-ID: <48839A55.6080304@keyaccess.nl>
References: <48838A54.40404@keyaccess.nl>
	<Pine.LNX.4.61.0807202104390.7676@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id F134410383A
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 22:02:24 +0200 (CEST)
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

>> Is there something wrong with your devel branch or is it me?
> 
> I think that you have to recommit your patches on top of new Takashi's 
> tree, because Takashi rebased his tree on top of Linus's tree.

Hmm. If Takashi did not just now change something, then something that I 
don't understand is happening since right now it's working fine:

rene@7ixe4:~/src/linux/7ixe4$ git remote show tiwai
* remote tiwai
   URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
   Tracked remote branches
     devel dma-fix for-linus master upstream
rene@7ixe4:~/src/linux/7ixe4$ git checkout -b alsa v2.6.26
Switched to a new branch "alsa"
rene@7ixe4:~/src/linux/7ixe4$ git pull tiwai devel
Updating bce7f79..e0bf09b
Fast forward

[ ... ]

... and a clean merge. Takashi, if you did -- it's fixed.. :-/

Rene.
