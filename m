From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: More HDA NID / control / proc related changes
Date: Mon, 14 Dec 2009 15:32:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912141457520.2598@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0912140943390.2598@eeebox2.perex-int.cz>
	<s5h6389lqdc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141313150.2598@eeebox2.perex-int.cz>
	<s5h3a3dlmqo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 55A63103803
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 15:32:55 +0100 (CET)
In-Reply-To: <s5h3a3dlmqo.wl%tiwai@suse.de>
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

> At Mon, 14 Dec 2009 13:34:19 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Mon, 14 Dec 2009, Takashi Iwai wrote:
>>
>>> At Mon, 14 Dec 2009 09:46:50 +0100 (CET),
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Tue, 8 Dec 2009, Jaroslav Kysela wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> 	continuing the work of extending the HDA codec proc contents, I would
>>>>> like to introduce two new patches:
>>>>>
>>>>> ALSA: hda - add more NID->Control mapping
>>>>> ALSA: hda - introduce HDA_SUBDEV_AMP_FLAG (ControlAmp in proc)
>>>>>
>>>>> 	Patches can be obtained here:
>>>>>
>>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=shortlog;h=topic/hda-nid
>>>>
>>>> I merged these patches and added patch named:
>>>>
>>>> ALSA: hda - simplify usage of HDA_SUBDEV_AMP_FLAG
>>>>
>>>> .. to my main GIT tree.
>>>>
>>>> The next idea is to modify hda-analyzer to show the codec routes and
>>>> assigned mixer controls.
>>>
>>> snd_hda_add_nids() looks buggy to me.  It doesn't increment nids
>>> pointer.
>>
>> Good point. Fixed now.
>>
>>> Also, snd_hda_add_nids() and snd_hda_nid_add() are a bit confusing and
>>> inconsistent, IMO.
>>
>> It is consistent with ctl functions:
>>
>> snd_hda_ctl_add -> snd_hda_nid_add
>> snd_hda_add_new_ctls -> snd_hda_add_nids
>
> Ah.  But both function names look too similar, I'd say, and the
> relationship above can't be seen obviously from the names.

Any idea to rename functions?

>>> Anyway, it'd be really, really helpful if you make a proper pullable
>>> branch based on the upstream tree.  Right now I can't pull your
>>> commits but only do cherry-picks, which is basically stupid when both
>>> are using GIT.
>>
>> I found the possible changes (resolving clashes) during merges very evil,
>> altough I understand your easy work scheme.
>
> Right.  IOW, the commits that have been already published for the
> public tree shouldn't be rebased.  The rebasing is the most evil thing
> for the published commits.
>
> Rebasing doesn't matter for local commits, of course.  Also, it's also
> more or less OK for some test trees / branches.  But, never rebase if
> a branch gets merged.
>
>> Also, I don't like the missing
>> lines in comments (Signed-off-by etc.) for merged patches for all involved
>> people. It makes more difficult to track the patch flow.
>
> Well, the meta info has to be set properly *before* merge.  So, the
> only question is whether a developed branch is ready for merging or
> not...

Unfortunately, I'm not talking about the meta-info. The patch delivery 
should be in the patch comment itself according to the SubmittingPatches 
document. For example:

commit 761c9d45d14e0afa3c0b8eb84b4075602e50533b
Author: Olof Johansson <olof@lixom.net>
Date:   Thu Dec 10 11:15:55 2009 -0600

     ASoC: Fix build of OMAP sound drivers

     ....
     Reported-by: Anand Gadiyar <gadiyar@ti.com>
     Signed-off-by: Olof Johansson <olof@lixom.net>
     Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
     Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Where's your Signed-off-by: line? You rely on the SCM system to obtain 
this information from the 'Merge' commit. I don't think that it's good.
Even if you do rebasing, you can have a clean repository. Just ommit git 
fancy merging and you'll see that you can work with patches in same way as 
in CVS or other "old" SCMs. I think that ONLY stable "fixed" commits 
should be in the Linus's tree and our patches should be commited as 
cleanly as possible with whole relevant information.

It's also about accepting the 'git pull' requests. If we accept the 'git 
format-patch' output via e-mail only , we can add appropriate information 
to the patch comment and the patches are valid without any requirement to 
know the "patch base" in the GIT repository.

The same rule should be applied to local branches - when merging, the 
contents should be cherry picked.

> If your topic/hda-nid branch isn't ready for merging, I don't care
> right now :)

It is ready (if you accept current function names).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
