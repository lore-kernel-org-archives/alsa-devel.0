From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_seq_deliver_single_event
Date: Mon, 1 Feb 2016 12:22:18 +0100
Message-ID: <CACT4Y+YXXYWUGSZ5y=ZHPJXVAKXeEXLn8vjkpm+xx98yfo4dxw@mail.gmail.com>
References: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
 <20160201111625.GB4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201111625.GB4455@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 1, 2016 at 12:16 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 01, 2016 at 11:26:57AM +0100, Dmitry Vyukov wrote:
>
>> The following program triggers use-after-free in
>> snd_seq_deliver_single_event (run in a tight parallel loop):
>
> I'm not sure how you're working out who to send these to but all these
> reports you've been sending have been for ALSA core which I rarely look
> at closely, I mostly look at ASoC.  Might be worth looking into so
> people don't start zoning out things that look like misdirected stuff
> (I just noticed myself doing that with this).


I am using scripts/get_maintainer.pl -f  the involved files. If it
produces wrong results, please update MAINTAINERS.
