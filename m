From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in hrtimer_cancel
Date: Sat, 4 Jun 2016 20:27:50 +0200
Message-ID: <CACT4Y+b1YEr5suLfUQVd_U+AU1fJ38DmGWbrLxaNay42-nAxYQ@mail.gmail.com>
References: <CACT4Y+Z-iJ6QyzyaJZk_oWmBKCjYecSynfsW3OdH5_bfarH=DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+Z-iJ6QyzyaJZk_oWmBKCjYecSynfsW3OdH5_bfarH=DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Sasha Levin <sasha.levin@oracle.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 4, 2016 at 8:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> The following program triggers use-after-free:

Forget to mention that you need to run it in a tight parallel loop. It
takes around 5 minutes to reproduce for me.
