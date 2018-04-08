From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: INFO: rcu detected stall in io_playback_transfer
Date: Sun, 8 Apr 2018 21:58:44 +0900
Message-ID: <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
References: <00000000000014ed1e056928bb60@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000000000014ed1e056928bb60@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, viro@zeniv.linux.org.uk
Cc: syzbot <syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com>, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, linux-kernel@vger.kernel.org, mingo@kernel.org, o-takashi@sakamocchi.jp, perex@perex.cz, syzkaller-bugs@googlegroups.com
List-Id: alsa-devel@alsa-project.org

I manually simplified the reproducer.

It is quite strange that removing unshare() hides this lockup bug.
Also, explicitly closing by "close()" hides this lockup bug.
Triggering "fput() from do_exit()" from "different namespace"
somehow affects this lockup bug?

----------------------------------------
#define _GNU_SOURCE
#include <fcntl.h>
#include <sched.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/soundcard.h>

int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	unshare(CLONE_NEWNS);
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	return 0;
}
----------------------------------------
