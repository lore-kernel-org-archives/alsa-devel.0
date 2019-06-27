From: Colin Ian King <colin.king@canonical.com>
Subject: static analysis bug report: ALSA: swapped client and port arguments
 in calls to snd_seq_oss_fill_addr
Date: Thu, 27 Jun 2019 15:01:40 +0100
Message-ID: <28c3fc44-0d4c-25e2-c9f4-d240c6d239f0@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi there,

Static analysis with Coverity has picked up two potential issues with
the call to function snd_seq_oss_fill_addr. The prototype of
snd_seq_oss_fill_addr is as follows:

static inline void
snd_seq_oss_fill_addr(struct seq_oss_devinfo *dp, struct snd_seq_event
*ev,int dest_client, int dest_port)


However, in sound/core/seq/oss/seq_oss_ioctl.c in function
snd_seq_oss_oob_user it is being called as follows:

	 snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.port, dp->addr.client);

and also in sound/core/seq/oss/seq_oss_rw.c in function is it also being
called as follows:

	snd_seq_oss_fill_addr(dp, &event, dp->addr.port, dp->addr.client);

..as one can see, in both cases the port and client arguments are
swapped compared to the function prototype.  I doubt this is intentional
but you never know. Are these bugs?

Colin
