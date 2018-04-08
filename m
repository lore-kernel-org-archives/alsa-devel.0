From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: INFO: rcu detected stall in io_playback_transfer
Date: Sun, 8 Apr 2018 22:26:21 +0900
Message-ID: <201804082226.AGF09317.OtLQHOFMJFSFVO@I-love.SAKURA.ne.jp>
References: <00000000000014ed1e056928bb60@google.com>
        <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
        <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dvyukov@google.com
Cc: tiwai@suse.com, viro@zeniv.linux.org.uk, syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, linux-kernel@vger.kernel.org, mingo@kernel.org, o-takashi@sakamocchi.jp, perex@perex.cz, syzkaller-bugs@googlegroups.com
List-Id: alsa-devel@alsa-project.org

Dmitry Vyukov wrote:
> Takashi has already fixed this. See this thread:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22INFO$3A$20rcu$20detected$20stall$20in$20snd_pcm_oss_write3$20(2)%22%7Csort:date/syzkaller-bugs/D2xWV7WTRDk/sCw_gImmCAAJ

Yes, I noticed it just before I post this. But the reason I posted this anyway
is that I feel that there is some other bug revealed by this reproducer.
How can Takashi' patch explain my observation (with linux-next-20180406) ?

/* Hits the stall */
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

/* Does not hit the stall */
int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	return 0;
}

/* Does not hit the stall */
int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	unshare(CLONE_NEWNS);
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	close(fd);
	return 0;
}
