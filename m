From: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix gpf in
	snd_usb_pipe_sanity_check
Date: Tue, 30 Jul 2019 19:28:56 +0800
Message-ID: <20190730112856.876-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn
 [202.108.3.165]) by alsa1.perex.cz (Postfix) with SMTP id B177AF800BF
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 13:29:13 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrey Konovalov <andreyknvl@google.com>, syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 30 Jul 2019 18:08:02 +0800 Takashi Iwai wrote:
>
> You don't have to copy the whole these texts at all.
> In general, it'd suffice to point out the dashboard URL, and if the
> stack trace is mandatory, drop the useless hex numbers and just show
> the significant part of the stack trace.
>
I am used to give readers as much info as appropriate, and learning that
an URL is enough in cases like this one. I will send you the pruned
version next time.

> > It was introduced in commit 801ebf1043ae for checking pipe and endpoint
> > types. It is fixed by adding a check of the ep pointer in question.
> >
> > Reported-by: syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>
> > Fixes: commit 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types")
>
> Drop "commit" word.
>
Yes, Sir.

> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Hillf Danton <dhanton@sina.com>
> > ---
There is a typo, s/dhanton/hdanton/, as you pointed out in another mail.

> > This is to make syzbot happy for now and in long run we can make
> > snd_usb_pipe_sanity_check() available outside sound/usb by making
> > usb_urb_ep_type_check() a wrapper of the former. We will revisit
> > sound/usb once when things in the usb/core get in place.
>
> Actually I expected to apply the "long-term" fix now.

There is change in usb/core included in that fix as you see, and
according to the rule, one fix a patch, it is better and simpler
IMO to fix the sound part first.

> The same kind
> of fix was already submitted from me (<s5hlfwn376e.wl-tiwai@suse.de>),
> but I didn't merge it because working on the usb core helper would be
> a saner solution.
>
Feel free to merge that, Sir.

Thanks
Hillf
