From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: More HDA NID / control / proc related changes
Date: Tue, 15 Dec 2009 09:42:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912150935540.2598@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0912140943390.2598@eeebox2.perex-int.cz>
	<s5h6389lqdc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141313150.2598@eeebox2.perex-int.cz>
	<s5h3a3dlmqo.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141457520.2598@eeebox2.perex-int.cz>
	<s5hy6l5k3x3.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141627500.2598@eeebox2.perex-int.cz>
	<s5hk4wpjxkk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E0D24558
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 09:42:05 +0100 (CET)
In-Reply-To: <s5hk4wpjxkk.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Dec 2009, Takashi Iwai wrote:

> At Mon, 14 Dec 2009 16:45:18 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> Anyway, I created for-next branch in my repository. Could you import changes
>> without explicitly asking if you do not have any comments? I'll merge
>> patches from Clemens there as well.
>
> Could you rebase it rather on the latest Linus tree instead?
> Or, rebase it on topic/hda branch I opened now for 2.6.34
> development.
>
> My master branch is for the development tip, and its merge history
> is pretty messy.  Ditto for for-next branch.  It contains lots of
> unneeded merge commits.  The merge history gets straightened when
> backed to for-linus branch.
>
> If your changes are only for HD-audio, then you can branch from either
> fix/hda or topic/hda branch in my tree.  The former is for the current
> kernel and the latter for the next kernel.
> For ASoC, fix/asoc and topic/asoc, and for others, fix/misc and
> topic/misc branches are available for (relatively) straight history.
>
> I cherry-pick'ed the last commit of Clemens to topic/misc.
> So I'd need only your topic/hda-nid branch for merge.

Ok, I would propose a bit different approach. I created two new branches
in my tree:

fixes - for current kernel
devel - for next kernel

To avoid too many merges, I would like that you pull from these branches
only when you compose the changeset for Linus (fixes) or for your next 
kernel (master branch - pull from fixes+devel). In case of problems or 
comments, I will fix them with new patch (so, in these trees, my patches 
will have stable SHA keys).

Do you think that it will work for you?

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
