From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Mon, 8 Nov 2010 15:43:15 -0600
Message-ID: <AANLkTikCQ_2S8FCVJOVA7Dop22kcsso6+M3+cACTdbz2@mail.gmail.com>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
	<s5h4oc016eq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
	<s5h1v7415ih.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020957590.29422@eeebox2.perex-int.cz>
	<s5hy69cytmn.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011021020550.29422@eeebox2.perex-int.cz>
	<AANLkTimCOOpV7fe1sbaWqY3ZpWQ3eZOkOi6pxyJVFo55@mail.gmail.com>
	<alpine.LNX.2.00.1011082203330.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2F48F2441B
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 22:43:17 +0100 (CET)
Received: by yws5 with SMTP id 5so4373130yws.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 13:43:16 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011082203330.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

done from the avail_update call invoked from an application.
>>
>> ok, so I re-implemented all the points found in the reviews except for
>> this thread. There's already some code to see if we go beyond the
>> buffer boundaries, so I am not sure what the 'linear position' means.
>
> Linear means that new hw_ptr must be always behind the previous hw_ptr.

I got that. But there are already some checks in pcm_lib.c,

	/* new_hw_ptr might be lower than old_hw_ptr in case when */
	/* pointer crosses the end of the ring buffer */
	if (new_hw_ptr < old_hw_ptr) {
		hw_base += runtime->buffer_size;
		if (hw_base >= runtime->boundary)
			hw_base = 0;
		new_hw_ptr = hw_base + pos;
	}

So do I need to add any additional checks? Or did I miss something in
your discussion with Takashi?
-Pierre
