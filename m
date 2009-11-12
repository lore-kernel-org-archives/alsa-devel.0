From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kmirror: ALSA kernel mirror
 repository branch, master now at v1.0.21-334-g6739046
Date: Thu, 12 Nov 2009 12:02:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911121154310.4806@eeebox2.perex-int.cz>
References: <20091112095403.1CAAE103807@alsa0.perex.cz>
	<s5hr5s4c9in.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DCCD8103938
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 12:02:41 +0100 (CET)
In-Reply-To: <s5hr5s4c9in.wl%tiwai@suse.de>
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

> At Thu, 12 Nov 2009 10:54:02 +0100 (CET),
> noreply-git@alsa-project.org wrote:
>>
>> commit 6739046df36c7adf80c961bcba4870270e66dbf6
>> Author:     Jaroslav Kysela <perex@perex.cz>
>> AuthorDate: Thu Nov 12 10:15:48 2009 +0100
>> Commit:     Jaroslav Kysela <perex@perex.cz>
>> CommitDate: Thu Nov 12 10:51:48 2009 +0100
>>
>>     ALSA: hda - proc - add support for dynamic controls to mixer<->NID mapping
>>
>>     This patch adds support for dynamically created controls to proc codec file
>>     (Control: lines).
>>
>>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>>
>> commit c45b73bf328cd8ace53cf39994328cf9d6548c4f
>> Author:     Jaroslav Kysela <perex@perex.cz>
>> AuthorDate: Wed Nov 11 13:43:01 2009 +0100
>> Commit:     Jaroslav Kysela <perex@perex.cz>
>> CommitDate: Thu Nov 12 10:51:16 2009 +0100
>>
>>     ALSA: hda - proc - introduce Control: lines to show mixer<->NID assignment
>>
>>     This is an initial patch to show universal control<->NID assigment in
>>     proc codec file. The change helps to debug codec related problems.
>>
>>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>
> I find the second one is the nice hack, but the first (newer) one
> isn't good since it abuses the subdevice field of the ctl id.
> It is a part of API/ABI, and if we do any changes the semantics, we
> should define the changed behavior *beforehand* publicly.

The subdevice member IS NOT used (it's always zero) for mixer elements and 
the value is not PASSED to the midlevel kernel API. Also, the 31. bit 
checking ensures that subdevice contains right value.

My idea was to keep the changes according the nid tracking at minimum (at 
least it would be difficult to do major changes for static 
snd_kcontrol_new arrays).

> Also, both commits give many warnings via checkpatch.pl...
> So I postpone the merge so far.

I'll fix that, if we agree how to go...

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
