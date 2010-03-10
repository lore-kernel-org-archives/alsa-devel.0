From: VDR User <user.vdr@gmail.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Wed, 10 Mar 2010 09:38:33 -0800
Message-ID: <a3ef07921003100938o4d94161fw559bc9b563ce55b@mail.gmail.com>
References: <s5htyswpb18.wl%tiwai@suse.de> <s5hvddcnlr6.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD558@HKMAIL01.nvidia.com>
	<a3ef07921003071121r24979a0breac27e3b0475bbcb@mail.gmail.com>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD562@HKMAIL01.nvidia.com>
	<20100308044614.GA29026@localhost>
	<a3ef07921003092142g23b93903v2b4af9c6b691bea0@mail.gmail.com>
	<alpine.LNX.2.00.1003100856420.4672@eeebox2.perex-int.cz>
	<a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>
	<20100310125456.GA18509@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f192.google.com (mail-qy0-f192.google.com
	[209.85.221.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F21D103873
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 18:38:35 +0100 (CET)
Received: by qyk30 with SMTP id 30so8343083qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 09:38:34 -0800 (PST)
In-Reply-To: <20100310125456.GA18509@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Wei Ni <wni@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <jkysela@redhat.com>, akpm <akpm@linux-foundation.org>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Ok, I'm not sure what I'm supposed to be looking for so I'll paste
some lines that include everything I see:

pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed.
[pid 22651] ioctl(21, 0x806c4120, 0xb439d230) = 0
[pid 22651] ioctl(21, 0x400c4150, 0xb439d1a4) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22652] ioctl(18, 0xc0104652 <unfinished ...>
[pid 22649] ioctl(10, 0xc0104652 <unfinished ...>
[pid 22652] <... ioctl resumed> , 0xb37b2590) = 0
[pid 22649] <... ioctl resumed> , 0xb547df00) = 0
[pid 22651] ioctl(21, 0x80044121, 0xb439d2cc) = -1 EPIPE (Broken pipe)
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed.
[pid 22651] ioctl(21, 0x806c4120, 0xb439d230) = 0
[pid 22651] ioctl(21, 0x400c4150, 0xb439d1a4) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22649] ioctl(4, 0xc020462a, 0xb547e030) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22651] ioctl(21, 0x80044121, 0xb439d2cc) = -1 EPIPE (Broken pipe)
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed.
[pid 22651] ioctl(21, 0x806c4120, 0xb439d230) = 0
[pid 22651] ioctl(21, 0x400c4150, 0xb439d1a4) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22651] ioctl(21, 0x80044121, 0xb439d2cc) = -1 EPIPE (Broken pipe)
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed.
[pid 22651] ioctl(21, 0x806c4120, 0xb439d230) = 0
[pid 22651] ioctl(21, 0x400c4150, 0xb439d1a4) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22649] ioctl(10, 0xc0104652 <unfinished ...>
[pid 22652] ioctl(18, 0xc0104652 <unfinished ...>
[pid 22649] <... ioctl resumed> , 0xb547df00) = 0
[pid 22652] <... ioctl resumed> , 0xb37b2590) = 0
[pid 22652] ioctl(18, 0xc0104652, 0xb37b2590) = 0
[pid 22649] ioctl(4, 0xc020462a, 0xb547e030) = 0
[pid 22651] ioctl(21, 0x80044121, 0xb439d2cc) = -1 EPIPE (Broken pipe)

This is with starting xine with:
strace -f -e trace=open,ioctl xine -A alsa -V vdpau --post vdr_video
--post vdr_audio vdr://tmp/vdr-xine/stream#demux:mpeg_pes --verbose=2
--fullscreen --no-gui --no-mouse --deinterlace --no-logo --no-splash &

Hopefully this helps!..(?)

Best regards,
Derek
