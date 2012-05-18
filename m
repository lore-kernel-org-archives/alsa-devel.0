From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: kmemleak findings about USB audio recording on
	3.3.2
Date: Fri, 18 May 2012 18:00:43 +0200
Message-ID: <4FB6722B.6050103@ladisch.de>
References: <1335112621.20322.8.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de
	[80.67.31.101]) by alsa0.perex.cz (Postfix) with ESMTP id 521BA24354
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 18:01:04 +0200 (CEST)
In-Reply-To: <1335112621.20322.8.camel@home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> On my home computer with linux-3.3.2, kmemleak found a lot of copies of
> this (not only from pulseaudio, but also from wine):
>
> unreferenced object 0xffff88021afaed40 (size 16):
>   comm "pulseaudio", pid 839, jiffies 4294711382 (age 31392.844s)
>   hex dump (first 16 bytes):
>     80 3e 00 00 c0 5d 00 00 00 7d 00 00 02 00 00 00  .>...]...}......
>   backtrace:
>     [<ffffffff811620d7>] create_object+0x127/0x2b0
>     [<ffffffff81636d81>] kmemleak_alloc+0x21/0x50
>     [<ffffffff81157bc3>] __kmalloc+0x103/0x1e0
>     [<ffffffffa02f650b>] snd_usb_pcm_open+0x3bb/0x4c0 [snd_usb_audio]

Please try this patch.

--8<---------------------------------------------------------------->8--
ALSA: usb-audio: fix rate_list memory leak

The array of sample rates is reallocated every time when opening
the PCM device, but was freed only once when unplugging the device.

Reported-by: "Alexander E. Patrakov" <patrakov@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -783,6 +783,9 @@ static int snd_usb_pcm_check_knot(struct snd_pcm_runtime *runtime,
 	int count = 0, needs_knot = 0;
 	int err;

+	kfree(subs->rate_list.list);
+	subs->rate_list.list = NULL;
+
 	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (fp->rates & SNDRV_PCM_RATE_CONTINUOUS)
 			return 0;
