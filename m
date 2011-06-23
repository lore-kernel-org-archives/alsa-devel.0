From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Pinfix quirk for HP Z200
	Workstation
Date: Thu, 23 Jun 2011 10:28:25 +0200
Message-ID: <4E02F929.40407@canonical.com>
References: <4E02510B.5090404@canonical.com> <s5hd3i5ypjw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D8C0B103ABE
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 10:28:27 +0200 (CEST)
In-Reply-To: <s5hd3i5ypjw.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-06-23 09:28, Takashi Iwai wrote:
> At Wed, 22 Jun 2011 22:31:07 +0200,
> David Henningsson wrote:
>>
>> BIOS lists the internal speaker as an internal line-out. Change to
>> internal speaker + model=auto for better auto-mute capabilities.
>>
>> Relevant alsa-info is here:
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/754964/+attachment/2002204/+files/alsa-info.txt
>
> Thanks, applied now.
>
> 3.0 should work even without this patch since line-out can be
> auto-muted now, but it's still more correct to show the speaker as
> speaker (e.g. the right mixer name).  So, it's still good to have
> this kind of fix.

I think it was not muted at all, because it is a mono pin, so it does 
not show up in the autocfg->line_out_pins array. (Perhaps this should 
change in the auto-mute behaviour?)

Also, the user wanted the real line out to mute the speaker.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
