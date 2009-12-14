From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: More HDA NID / control / proc related changes
Date: Mon, 14 Dec 2009 13:34:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912141313150.2598@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0912140943390.2598@eeebox2.perex-int.cz>
	<s5h6389lqdc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 10D2C10387D
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 13:34:20 +0100 (CET)
In-Reply-To: <s5h6389lqdc.wl%tiwai@suse.de>
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

> At Mon, 14 Dec 2009 09:46:50 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Tue, 8 Dec 2009, Jaroslav Kysela wrote:
>>
>>> Hi all,
>>>
>>> 	continuing the work of extending the HDA codec proc contents, I would
>>> like to introduce two new patches:
>>>
>>> ALSA: hda - add more NID->Control mapping
>>> ALSA: hda - introduce HDA_SUBDEV_AMP_FLAG (ControlAmp in proc)
>>>
>>> 	Patches can be obtained here:
>>>
>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=shortlog;h=topic/hda-nid
>>
>> I merged these patches and added patch named:
>>
>> ALSA: hda - simplify usage of HDA_SUBDEV_AMP_FLAG
>>
>> .. to my main GIT tree.
>>
>> The next idea is to modify hda-analyzer to show the codec routes and
>> assigned mixer controls.
>
> snd_hda_add_nids() looks buggy to me.  It doesn't increment nids
> pointer.

Good point. Fixed now.

> Also, snd_hda_add_nids() and snd_hda_nid_add() are a bit confusing and
> inconsistent, IMO.

It is consistent with ctl functions:

snd_hda_ctl_add -> snd_hda_nid_add
snd_hda_add_new_ctls -> snd_hda_add_nids

> Anyway, it'd be really, really helpful if you make a proper pullable
> branch based on the upstream tree.  Right now I can't pull your
> commits but only do cherry-picks, which is basically stupid when both
> are using GIT.

I found the possible changes (resolving clashes) during merges very evil, 
altough I understand your easy work scheme. Also, I don't like the missing 
lines in comments (Signed-off-by etc.) for merged patches for all involved
people. It makes more difficult to track the patch flow.

My topic/hda-nid branch is now based on your master tree.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
