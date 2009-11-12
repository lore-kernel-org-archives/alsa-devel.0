From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kmirror: ALSA kernel mirror
 repository branch, master now at v1.0.21-334-g6739046
Date: Thu, 12 Nov 2009 12:11:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911121209170.4806@eeebox2.perex-int.cz>
References: <20091112095403.1CAAE103807@alsa0.perex.cz>
	<s5hr5s4c9in.wl%tiwai@suse.de> <s5hljicc8cf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 31AA910395D
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 12:11:18 +0100 (CET)
In-Reply-To: <s5hljicc8cf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Nov 2009, Takashi Iwai wrote:

> At Thu, 12 Nov 2009 11:39:12 +0100,
> I wrote:
>>
>> At Thu, 12 Nov 2009 10:54:02 +0100 (CET),
>> noreply-git@alsa-project.org wrote:
>>>
>>> commit 6739046df36c7adf80c961bcba4870270e66dbf6
>>> Author:     Jaroslav Kysela <perex@perex.cz>
>>> AuthorDate: Thu Nov 12 10:15:48 2009 +0100
>>> Commit:     Jaroslav Kysela <perex@perex.cz>
>>> CommitDate: Thu Nov 12 10:51:48 2009 +0100
>>>
>>>     ALSA: hda - proc - add support for dynamic controls to mixer<->NID mapping
>>>
>>>     This patch adds support for dynamically created controls to proc codec file
>>>     (Control: lines).
>>>
>>>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>>>
>>> commit c45b73bf328cd8ace53cf39994328cf9d6548c4f
>>> Author:     Jaroslav Kysela <perex@perex.cz>
>>> AuthorDate: Wed Nov 11 13:43:01 2009 +0100
>>> Commit:     Jaroslav Kysela <perex@perex.cz>
>>> CommitDate: Thu Nov 12 10:51:16 2009 +0100
>>>
>>>     ALSA: hda - proc - introduce Control: lines to show mixer<->NID assignment
>>>
>>>     This is an initial patch to show universal control<->NID assigment in
>>>     proc codec file. The change helps to debug codec related problems.
>>>
>>>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>>
>> I find the second one is the nice hack, but the first (newer) one
>> isn't good since it abuses the subdevice field of the ctl id.
>> It is a part of API/ABI, and if we do any changes the semantics, we
>> should define the changed behavior *beforehand* publicly.
>
> BTW, I don't mean that using subdevice is wrong.  Instead: if we use
> it, let's define the proper definition first.  For example, define
> (1 << 31) as the private (driver-specific) field bit in control.h.
>
> Actually, using the subdevice can make the change of snd_hda_add_ctl
> easier, too.  Then you don't keep nid in another field but just use
> snd_kcontrol to retrieve the nid.
>
> Of course, we'd need to check the existing apps (at least our own)
> whether subdevice is really safe to change freely, though.

I think that you overlooked this code in snd_hda_add_new_ctls():

                if (knew->subdevice & (1<<31)) {
                         nid = knew->subdevice & 0xffff;
                         kctl->id.subdevice = 0;
                 } else {
                         nid = 0;
                 }

The subdevice value for nid contents will never leave the HDA code.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
