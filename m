From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Mon, 21 Jul 2008 10:45:29 +0200
Message-ID: <48844CA9.9060408@keyaccess.nl>
References: <48838A54.40404@keyaccess.nl>
	<Pine.LNX.4.61.0807202104390.7676@tm8103-a.perex-int.cz>
	<48839A55.6080304@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 824B6245E0
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 10:43:16 +0200 (CEST)
In-Reply-To: <48839A55.6080304@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20-07-08 22:04, Rene Herman wrote:

> On 20-07-08 21:08, Jaroslav Kysela wrote:
> 
>> On Sun, 20 Jul 2008, Rene Herman wrote:
> 
>>> Is there something wrong with your devel branch or is it me?
>>
>> I think that you have to recommit your patches on top of new Takashi's 
>> tree, because Takashi rebased his tree on top of Linus's tree.
> 
> Hmm. If Takashi did not just now change something, then something that I 
> don't understand is happening since right now it's working fine:
> 
> rene@7ixe4:~/src/linux/7ixe4$ git remote show tiwai
> * remote tiwai
>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>   Tracked remote branches
>     devel dma-fix for-linus master upstream
> rene@7ixe4:~/src/linux/7ixe4$ git checkout -b alsa v2.6.26
> Switched to a new branch "alsa"
> rene@7ixe4:~/src/linux/7ixe4$ git pull tiwai devel
> Updating bce7f79..e0bf09b
> Fast forward
> 
> [ ... ]
> 
> ... and a clean merge. Takashi, if you did -- it's fixed.. :-/

But you didn't... the "manual" git fetch tiwai/git merge tiwai/devel 
still fails.

It probably has something to do with this:

rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
 From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
  ! [rejected]        devel      -> tiwai/devel  (non fast forward)
  ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
  ! [rejected]        master     -> tiwai/master  (non fast forward)

I'll go ask on the GIT list what this might be about...

Rene.
