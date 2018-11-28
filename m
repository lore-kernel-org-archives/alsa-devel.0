From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date: Wed, 28 Nov 2018 15:26:34 +0900
Message-ID: <00d001d486e3$4f2d1600$ed874200$@lge.com>
References: <1543210597-6717-1-git-send-email-chanho.min@lge.com> <s5hin0k6xqy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@kernel.org>, 'Vinod Koul' <vkoul@kernel.org>, 'Daniel Mentz' <danielmentz@google.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 'Seungho Park' <seungho1.park@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>, 'Wonmin Jung' <wonmin.jung@lge.com>, 'Jaehyun Kim' <jehn.kim@lge.com>, 'Hyonwoo Park' <hyonwoo.park@lge.com>
List-Id: alsa-devel@alsa-project.org

> >
> > Hrm, converting unconditionally with msleep() looks too drastic.
> 
> Yes, it looks drastic. But, IMHO, I can't say busy-spin is not
non-drastic.
Fix typo in this comment:
I can't say busy-spin is not drastic.

Thanks
Chanho
