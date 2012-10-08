From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - avoid unneccesary indices on
 "Headphone Jack" controls
Date: Mon, 08 Oct 2012 11:02:37 +0200
Message-ID: <507296AD.8090405@canonical.com>
References: <1349255573-11321-1-git-send-email-david.henningsson@canonical.com>
 <s5h391pl6lr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E52262614
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 11:02:38 +0200 (CEST)
In-Reply-To: <s5h391pl6lr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1060729@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 10/08/2012 10:18 AM, Takashi Iwai wrote:
> At Wed,  3 Oct 2012 11:12:53 +0200,
> David Henningsson wrote:
>>
>> In case there is one "Headphone Jack" and one "Dock Headphone Jack",
>> one of them will get an index, even though that is not needed.
>> This patch fixes that issue.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1060729
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Applied.  This one doesn't need to go to stable, right?

Good question. I guess it depends on how we look upon kcontrol indices 
in general.

PulseAudio never picks anything up if it has an index, therefore it 
becomes a real problem/bug for users. (Not sure if one could argue that 
this is a problem in PulseAudio rather than the kernel. Haven't thought 
that through.)

OTOH, if the reasoning is that you would break custom made scripts that 
depend on this index, i e it becomes a change of behaviour.

To be pragmatic about it, the chances that people are depending on this 
index being non-zero are probably very low, so I don't mind sending this 
one to stable.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
