From: Jan Binder <phoenix.diablo@googlemail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Wed, 22 Jun 2011 10:02:25 +0200
Message-ID: <201106221002.26119.phoenix.diablo@gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1A4DA2455A
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 10:02:31 +0200 (CEST)
Received: by fxm5 with SMTP id 5so495741fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 01:02:30 -0700 (PDT)
In-Reply-To: <s5hvcw04k50.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, alex.baldacchino.alsasub@gmail.com, haraldwelte@viatech.com, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

Am Montag, 20. Juni 2011, 17:06:51 schrieb Takashi Iwai:
> Hi,
> 
> as there have many problems reported for VIA codecs, I started looking
> at the driver code, and decided to rework on it.
> 
> The current development is found in sound git tree topic/via-cleanup
> branch:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> You can pull into the latest Linus tree from topic/via-cleanup
> branch:
>    # this is the vanilla tree
>    % cd linux-2.6
>    % git pull \
>       git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git \
>       topic/via-cleanup
> 
> A good thing is that a fair amount of code reduction is done there:
> 
> % git diff HEAD..topic/via-cleanup --stat sound/pci/hda/patch_via.c
>  sound/pci/hda/patch_via.c | 5892
> +++++++++++---------------------------------- 1 files changed, 1453
> insertions(+), 4439 deletions(-)
> 
> But, the driver isn't tested with real machines, yet.  That is, I need
> testers with real machines.
> 
> Could VIA machine owners take a look at these commits and test it if
> possible?  Especially, I'd like to know whether the headphone
> auto-mute works in this form or not.

I will have a look at this.
On a related note, I am experiencing a bug regarding SPDIF output as  
described here: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4330
If this could be fixed within this rework, it would be greatly appreciated.

> FWIW, the branch was merged to sound-unstable tree, so you can build
> from alsa-driver-unstable snapshot tarball if you'd like to build
> external modules without the kernel tree and git-merge.
>  
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-un
> stable-snapshot.tar.gz
> 
> 
> Also, if anyone has alsa-info.sh outputs of VIA codecs, please let me
> know.  It'd be very helpful for debugging, since I can check it via
> hda-emu with alsa-info.sh output.  For now, I have the files of only
> VT1702, VT1708S, VT1718S, VT1828S and VT2020 codecs.  The alsa-info.sh
> outputs of other VIA codecs would be greatly appreciated.

You can find the info-alsa.sh output for my VIA VT1708B 8-Ch at
http://www.alsa-project.org/db/?f=05281895eb77de2a22257e27fb2ecab1a959cb92
 
> thanks,
> 
> Takashi
--
Jan Binder
