From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: More HDA NID / control / proc related changes
Date: Mon, 14 Dec 2009 16:45:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912141627500.2598@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0912140943390.2598@eeebox2.perex-int.cz>
	<s5h6389lqdc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141313150.2598@eeebox2.perex-int.cz>
	<s5h3a3dlmqo.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141457520.2598@eeebox2.perex-int.cz>
	<s5hy6l5k3x3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B0A2F2414B
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 16:45:19 +0100 (CET)
In-Reply-To: <s5hy6l5k3x3.wl%tiwai@suse.de>
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

> Or, use the same name snd_hda_add_nid() and snd_hda_add_nids(), unify
> the argument order, but make the latter accept array, or so.

Renamed in this way. Please, check topic/hda-nid or for-next branch.

>>>>> branch based on the upstream tree.  Right now I can't pull your
>>>>> commits but only do cherry-picks, which is basically stupid when both
>>>>> are using GIT.
>>>>
>>>> I found the possible changes (resolving clashes) during merges very evil,
>>>> altough I understand your easy work scheme.
>>>
>>> Right.  IOW, the commits that have been already published for the
>>> public tree shouldn't be rebased.  The rebasing is the most evil thing
>>> for the published commits.
>>>
>>> Rebasing doesn't matter for local commits, of course.  Also, it's also
>>> more or less OK for some test trees / branches.  But, never rebase if
>>> a branch gets merged.
>>>
>>>> Also, I don't like the missing
>>>> lines in comments (Signed-off-by etc.) for merged patches for all involved
>>>> people. It makes more difficult to track the patch flow.
>>>
>>> Well, the meta info has to be set properly *before* merge.  So, the
>>> only question is whether a developed branch is ready for merging or
>>> not...
>>
>> Unfortunately, I'm not talking about the meta-info. The patch delivery
>> should be in the patch comment itself according to the SubmittingPatches
>> document. For example:
>>
>> commit 761c9d45d14e0afa3c0b8eb84b4075602e50533b
>> Author: Olof Johansson <olof@lixom.net>
>> Date:   Thu Dec 10 11:15:55 2009 -0600
>>
>>      ASoC: Fix build of OMAP sound drivers
>>
>>      ....
>>      Reported-by: Anand Gadiyar <gadiyar@ti.com>
>>      Signed-off-by: Olof Johansson <olof@lixom.net>
>>      Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>>      Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>> Where's your Signed-off-by: line? You rely on the SCM system to obtain
>> this information from the 'Merge' commit. I don't think that it's good.
>
> This is fully normal.  Do you see sign-off in each pull by Linus?

Linus should be only exception, because this patch route is quite obvious.

> Many trees with sub-trees or sub-projects are done in that way.
> See x86 tree, for example.

It does not mean that it's the correct way.

Anyway, I created for-next branch in my repository. Could you import changes
without explicitly asking if you do not have any comments? I'll merge 
patches from Clemens there as well.

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
