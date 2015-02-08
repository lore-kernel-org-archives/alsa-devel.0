From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: fix failure to return
 numerical ID in event data
Date: Sun, 08 Feb 2015 22:08:45 +0900
Message-ID: <54D75FDD.1050208@sakamocchi.jp>
References: <1423391336-2167-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h386gr770.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id EC93F260410
 for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2015 14:08:49 +0100 (CET)
In-Reply-To: <s5h386gr770.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Feb 8 2015 20:09, Takashi Iwai wrote:
> At Sun,  8 Feb 2015 19:28:56 +0900,
> Takashi Sakamoto wrote:
>>
>> Currently an instance of control has zero as its member for numerical
>> ID even if any IDs are assigned to. According to this bug, any userspace
>> applications cannot identify controls by the ID when handling any events.
>> On the other hand, the other members such as name are still valid,
>> therefore applications can identify controls without fixing this.
>>
>> This is not preferable because the ID has an advantage to allow userspace
>> applications to distinguish each controls by itself, without any
>> combinations.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> You're trying to address two individual bugs.  Please split.
> The first bug is the missing zero clear of id.numid, and the second
> bug is the missing numid set for notification.  Both can be oneliner.
> The latter would be something like:
> 
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -371,7 +371,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
>  	}
>  	list_add_tail(&kcontrol->list, &card->controls);
>  	card->controls_count += kcontrol->count;
> -	kcontrol->id.numid = card->last_numid + 1;
> +	id.numid = kcontrol->id.numid = card->last_numid + 1;
>  	card->last_numid += kcontrol->count;
>  	count = kcontrol->count;
>  	up_write(&card->controls_rwsem);
> 
> If you want to reorder the calls and add the comments, do it in
> another patch to make clear that it's just a refactoring.  Don't mix
> up refactoring and a fix, unless it's really trivial.

OK. In next patch, I'll remove the refactoring codes (including
zero-clear) because it depends on developers' style and easy to bring
bike-shed discussion.

Regards

Takashi Sakamoto
