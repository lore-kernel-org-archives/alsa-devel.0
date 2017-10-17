From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/2] Add snd_card_disconnect_sync()
	helper
Date: Wed, 18 Oct 2017 00:16:51 +0900
Message-ID: <384d526d-f193-a237-750c-d0fae69c38cb@sakamocchi.jp>
References: <87k1zu7g1l.wl%kuninori.morimoto.gx@renesas.com>
 <20171017142510.7959-1-o-takashi@sakamocchi.jp>
 <s5h60bdx2qt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E694F266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 17:17:31 +0200 (CEST)
In-Reply-To: <s5h60bdx2qt.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Oct 17 2017 23:34, Takashi Iwai wrote:
> Well, as I mentioned, a potential breakage would appear in the legacy
> AC97 codec binding -- if it would do any hot-unplug.  But most of
> legacy drivers work fine without my patches just because it has only
> top-level unbind.

Yep. Recent drivers get no suffers from the issue because AC'97 is
enough ancient, at least for rsnd.

> So, the top-level hot-unplug as you tested with the dummy driver works
> as is.  The problem is only about unbinding the middle-layer
> component, as mentioned in the patch.  It's found mostly in ASoC, but
> not necessarily tied only with ASoC.

Are there any driver outside of ALSA SoC part to use the feature?
Actually, not. It's quite natural to assume that the feature is somehow
specialized for ALSA SoC part even it it's in ALSA PCM core.

And today I have little time to review the patch. Please check
in-reply-to field of my previous message. This is not a reply to yours.

>> But I note that even if unbind works fine to shift state of sound devices
>> into disconnected, poll(2) call to ALSA control character devices does not
>> return (e.g. run 'amixer events'). I don't know exactly the cause yet...
> 
> The disconnection doesn't close the device by itself (we can't), but
> it replaces with the dummy ops so that it never touches the driver
> except for closing.  That is, the device is in the idle state and just
> accepts closing.

You did misread. I just said that a call of poll(2) doesn't return.

1599 static unsigned int snd_ctl_poll(struct file *file, poll_table * wait)
1600 {
1601         unsigned int mask;
1602         struct snd_ctl_file *ctl;
1603
1604         ctl = file->private_data;
1605         if (!ctl->subscribed)
1606                 return 0;
1607         poll_wait(file, &ctl->change_sleep, wait);

This should be awakened by below lines:

1775 static int snd_ctl_dev_disconnect(struct snd_device *device)
1776 {
1777         struct snd_card *card = device->device_data;
1778         struct snd_ctl_file *ctl;
1779
1780         read_lock(&card->ctl_files_rwlock);
1781         list_for_each_entry(ctl, &card->ctl_files, list) {
1782                 wake_up(&ctl->change_sleep);

As long as I observed, it doesn't even if the above line is executed.
(how odd...) I suspect to hit some other bugs such as buffer-overrun
depending on my environment. But it's out of my current plan and I
didn't investigate further. That's all of what I experience.


Thanks

Takashi Sakamoto
