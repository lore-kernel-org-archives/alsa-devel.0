From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Fri, 15 Jan 2016 16:28:33 +0100
Message-ID: <CACT4Y+Z22tC11KEad8DeFFQ0a6Rq-iyRryew02nYivz7WCR7nA@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de> <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de> <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
 <CACT4Y+anWgMKQmNByifCs+-jizRQL9twxvRQzW3XzNJ8+a6fDw@mail.gmail.com>
 <s5hegdlmdd6.wl-tiwai@suse.de> <CACT4Y+Y62DTncEAb_S6JykY7Ps7SHo2QyCopMObBxJt2fB_NKA@mail.gmail.com>
 <s5h60yxmc99.wl-tiwai@suse.de> <s5ha8o8uoqb.wl-tiwai@suse.de>
 <CACT4Y+a-=mrGALS+yf4GwGmJGLWXVJ0mbucPAkZ7WSGFaSR0Kw@mail.gmail.com>
 <s5hwprbt8ei.wl-tiwai@suse.de> <CACT4Y+ZfAc1JZQHHbA-k_ZVN3vm9djojvmL+e=D8WO2J8FR0=A@mail.gmail.com>
 <s5hk2nbt0gp.wl-tiwai@suse.de> <CACT4Y+aOEHHEVp1YLLMr2PD_iyESMP64T-EQX18=EfvRtgOLOQ@mail.gmail.com>
 <s5hr3hivpgd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr3hivpgd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 4:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
> So you're running this in parallel?  Or a tight sequential loop?
> I did the latter, and I tried even this on a bare metal, but couldn't
> trigger the Oops, so far.

Yes, I run it in parallel using:

$ go get golang.org/x/tools/cmd/stress
$ ./stress -p 8 ./a.out

But it just keeps 8 parallel processes running.


> Meanwhile, I pushed the tree including all fixes at for-linus branch:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus
>
> It'd be appreciated if you can test this one.

Is it different from the patches you mailed? I keep several dozens
fixes for bugs that are not yet merged into Linus tree + own kcov
patch. It is not easy to rebase...
Here is what I now have for sound/
https://gist.githubusercontent.com/dvyukov/dc29dbfd320126285fd8/raw/e2ca7b59c0dc118045f9fb4e3d052cbc751e787e/gistfile1.txt
