From: Rene Herman <rene.herman@keyaccess.nl>
Subject: GIT: something wrong with sound-2.6/devel?
Date: Sun, 20 Jul 2008 20:56:20 +0200
Message-ID: <48838A54.40404@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A521037F6
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 20:54:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi.

Is there something wrong with your devel branch or is it me?

rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
remote: Counting objects: 1695, done.
remote: Compressing objects: 100% (418/418), done.
remote: Total 1418 (delta 1182), reused 1222 (delta 1000)
Receiving objects: 100% (1418/1418), 275.35 KiB, done.
Resolving deltas: 100% (1182/1182), completed with 170 local objects.
 From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
  ! [rejected]        devel      -> tiwai/devel  (non fast forward)
  ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
    3e14b50..9432484  for-linus  -> tiwai/for-linus
  ! [rejected]        master     -> tiwai/master  (non fast forward)
    481c534..50515af  upstream   -> tiwai/upstream
rene@7ixe4:~/src/linux/7ixe4$ git checkout -b head v2.6.26
Switched to a new branch "head"
rene@7ixe4:~/src/linux/7ixe4$ git merge tiwai/devel
Auto-merged sound/pci/ac97/ac97_patch.c
Auto-merged sound/pci/emu10k1/emu10k1_main.c
Auto-merged sound/pci/hda/patch_analog.c
Auto-merged sound/pci/hda/patch_realtek.c
CONFLICT (content): Merge conflict in sound/pci/hda/patch_realtek.c
Auto-merged sound/pci/hda/patch_sigmatel.c
Automatic merge failed; fix conflicts and then commit the result.

It's no doubt trivial to fixup, but I believe this should've merged 
cleanly? (the master branch from where I'm branching off head is an 
undisturbed linus tree).

Rene.
