From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: OOPS: Vmaster not freed on reconfig
Date: Wed, 09 Nov 2011 15:30:34 +0100
Message-ID: <4EBA8E8A.40708@canonical.com>
References: <4EB955F8.5070303@canonical.com> <s5hehxiefm5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id DDEB4103857
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 15:30:36 +0100 (CET)
In-Reply-To: <s5hehxiefm5.wl%tiwai@suse.de>
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

On 11/08/2011 05:36 PM, Takashi Iwai wrote:
> At Tue, 08 Nov 2011 17:16:56 +0100,
> David Henningsson wrote:
>>
>> Hi,
>>
>> I'm playing around with the reconfig functions of snd-hda-codec and got
>> an OOPS in slave_put. I tried to research this, and I think I've nailed
>> down the problem: the vmaster is not freed on reconfig (presumably, it
>> should be fixed in hda_codec.c:snd_hda_ctls_clear).
>
> Hmm, I don't figure out how it happens.
> The vmaster is added to the list via snd_hda_add_vmaster() by calling
> snd_hda_ctl_add().

You're correct. It must be some other error.

>> I'm a little unsure of whether the best thing is to just add it to
>> codec.mixers, keep them in a separate array, or something else. What do
>> you think?
>>
>> (It's on 3.0, it's a sigmatel/IDT, and I've got the screen captured by a
>> camera if anyone is interested.)
>
> Yes, it'd be interesting.  If the bug is easily reproducible, you can
> capture the oops text by netconsole, too.

I haven't had the time to troubleshoot further yet (and thus I don't 
know if it's reproducible), but at least I've uploaded the requested 
information:

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/888081/+attachment/2590781/+files/alsa-info.txt.ZE05tEjd8T

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/888081/+attachment/2590787/+files/DSC00007.JPG 


(Sorry about the bad quality of that picture, I think most of it should 
be readable at least)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
