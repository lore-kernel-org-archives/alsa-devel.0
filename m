From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix double-free in
 snd_usb_add_audio_stream()
Date: Thu, 31 Mar 2016 10:03:55 -0400 (EDT)
Message-ID: <805340847.43676741.1459433035733.JavaMail.zimbra@redhat.com>
References: <1459364602-28997-1-git-send-email-vdronov@redhat.com> <1459364602-28997-2-git-send-email-vdronov@redhat.com> <s5hbn5v7lnw.wl-tiwai@suse.de> <s5h8u0zgen2.wl-tiwai@suse.de> <882494379.43642280.1459427790768.JavaMail.zimbra@redhat.com> <s5hegaqg5zj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <s5hegaqg5zj.wl-tiwai@suse.de>
Sender: linux-sound-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello, Takashi, all,

> No, it has nothing to do with the double-free bug itself.  Such an
> optimization shouldn't be put in a fix patch

This piece of code move alone fixes the double-free bug in
create_fixed_stream_quirk(), so I believe it is related. Besides, a lot of stuff
is created and initialized in snd_usb_add_audio_stream() and while I do not see
another use-after-free bug, it could be there. By moving this code we avoid
these potential bugs we have not hit yet.

But anyway. If you still believe this code should not be moved, please, confirm,
I'll suggest the next patch version without it.

> Vladis, if you take someone's patch as the base, you have to carry the
> original authorship somewhere...

Yes, I was thinking about it, I was just not sure how should I do it. Will the
following form be fine? Or somehow else?

Based on a patch by Takashi Iwai" <tiwai@suse.de>

> > + * if not, create a new pcm stream. the caller must remove fp from
> > + * the substream fmt_list in the error path to avoid double-free.
>
> This comment isn't true.  The caller may leave it as is, too, like my
> first version.  It just depends on the code.

Yes. Is the following rewrite acceptable for the next patch version?

 * if not, create a new pcm stream. Note, fp is added to the substream fmt_list
 * and will be freed on the chip instance release. Do not free fp or do remove
 * it from the substream fmt_list to avoid double-free.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
