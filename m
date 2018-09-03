From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: KMSAN: uninit-value in snd_midi_event_encode_byte
Date: Mon, 3 Sep 2018 17:06:05 +0200
Message-ID: <CACT4Y+YMetgDkFtqOuPJzfniKBfnq4-RAYE_AJkvMVTLAUx5-Q@mail.gmail.com>
References: <s5ha7oyhg0v.wl-tiwai@suse.de> <000000000000a25ae50574f76ff0@google.com>
 <s5h7ek2hfp6.wl-tiwai@suse.de> <CACT4Y+bJM4dfx_2_qwPLOYdU_snGv7Zhhu3g_sHuzUM3sjnZQQ@mail.gmail.com>
 <s5h4lf6hfcq.wl-tiwai@suse.de> <CACT4Y+ZjXmdTb552cEOYdhz4PVOHdS39q7ynW_3uz=STvVmr5w@mail.gmail.com>
 <s5h1saahe2p.wl-tiwai@suse.de> <CACT4Y+Z9Aji1vENUc_8YbMx5dh=uXfm09DewDZZvwXbKn5O_vA@mail.gmail.com>
 <s5hwos2fybs.wl-tiwai@suse.de> <CACT4Y+a1erpZnCVAU44wF+Sve5He4gjK4+7nGHi6RWbogfs3Ag@mail.gmail.com>
 <s5ho9defwxf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho9defwxf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com>, alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 3, 2018 at 5:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Sep 2018 16:54:23 +0200,
> Dmitry Vyukov wrote:
>>
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>> is meant to be a complement to the previous generic descriptions of
>> patch testing process, which is:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>>
>> So, you always reply to the syzbot+HASH email address so that syzbot
>> understands which bug we are talking about.
>> Then you do either (omitting # so that syzbot won't consider that as
>> actual test requests):
>>
>> syz test: git://repo/address.git branch
>>
>> or:
>>
>> syz test: git://repo/address.git commit-hash
>>
>> And then you can either attach a patch that needs to be applied on
>> top, or not attach it (if it's already in the tree, or you just want
>> to get another crash report).
>
> OK, so far, so good, it's what I knew and have done a few times.
>
>
>> For KMSAN you need to issue test request against
>> "https//github.com/google/kmsan.git master" (that's the only tree that
>> has KMSAN tool in it) and you need to attach/inline the patch (because
>> your patch is obviously not there yet).
>>
>> Does this make things more clear?
>
> Sorry, the part "issue test request against https..." still isn't
> clear.
>
> Do you mean to open an issue entry on github, and attach the patch
> there?

By "issue test request" I mean sending email with "syz test" command.
So overall you send "syz test https//github.com/google/kmsan.git
master" and attach the patch.
The workflow is all the same, and no github involved. It's just that
you can't ask to test it against
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git because
it does not have KMSAN tool and so no KMSAN bugs will be detected
there.

Since I did all of this, it's hard for me to write clear docs for others. Sorry.
If you can suggest some improved wording, it would be great.
