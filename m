From: R C <v4l@cerqueira.org>
Subject: Re: [Patch 1/1] V4L (926) Saa7134 alsa can only be
	autoloaded	after	saa7134 is active
Date: Tue, 08 Nov 2005 21:09:15 +0000
Message-ID: <1131484155.4851.10.camel@frolic>
References: <1131397121.6632.127.camel@localhost>
	<s5hd5lbnzg6.wl%tiwai@suse.de> <1131451671.2863.4.camel@frolic>
	<s5h4q6nnunn.wl%tiwai@suse.de>
Reply-To: Linux and Kernel Video <video4linux-list@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <s5h4q6nnunn.wl%tiwai@suse.de>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: akpm@osdl.org, video4linux-list@redhat.com, mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Tue, 2005-11-08 at 14:20 +0100, Takashi Iwai wrote:

> But saa7134_dma_stop() should be already called in trigger callback,
> which is called via snd_pcm_stop().

You're right. I wasn't aware pcm_stop() caused a trigger.
You may want to check the current version at
http://linuxtv.org/cgi-bin/viewcvs.cgi/v4l-kernel/linux/drivers/media/video/saa7134/saa7134-alsa.c?rev=1.21&root=v4l&view=auto

--
RC

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
