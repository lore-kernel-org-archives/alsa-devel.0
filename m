From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: mmap support in saa7134-alsa (was: Sample format
 coversion bug?)
Date: Tue, 30 Oct 2007 21:24:44 +0500
Message-ID: <47275ACC.5080801@ums.usu.ru>
References: <4721E932.5090603@ums.usu.ru> <s5hpryyny19.wl%tiwai@suse.de>
	<4725BD78.6040709@ums.usu.ru> <s5hk5p6nveb.wl%tiwai@suse.de>
	<4725F66F.10805@ums.usu.ru>
	<Pine.LNX.4.58.0710291141280.16052@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 2057C24523
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 17:24:54 +0100 (CET)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 6377917EAC
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Oct 2007 21:27:34 +0500 (YEKT)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 8566517EAC
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Oct 2007 21:27:31 +0500 (YEKT)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id C93B0A7ECA
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Oct 2007 21:24:47 +0500 (YEKT)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 749C9A7EAC
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Oct 2007 21:24:47 +0500 (YEKT)
In-Reply-To: <Pine.LNX.4.58.0710291141280.16052@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, video4linux-list@redhat.com
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> On Mon, 29 Oct 2007, Alexander E. Patrakov wrote:
>   
>> Even though mmap seems to be supported in the driver source (judging
>> from .info = SNDRV_PCM_INFO_MMAP | other flags), I could not figure out
>> the parameters that work. Moreover, the driver seems to accept the same
>> hardware parameters without the mmap, and I could not find parameters
>> that the driver accepts for mmap.
>>     
>
> I do not think the saa7134-alsa driver supports mmap.  The cx88-alsa driver
> also claimed to support mmap, but it never worked until I fixed it.  It's
> pretty clear that the code in saa7134-alsa was based on the same code as
> cx88-alsa, so it's likely it has the same bug.
>   

You are right. The patch below (based on your cx88 patch, but I don't 
really understand it) fixes mmap support in saa7134-alsa for me. 
Recording via mmap (arecord -M -f S16_LE -c 2 -r 32000 -D hw:1) didn't 
work at all before, works now, tested for at least 20 minutes (but, 
unfortunately, with one overrun at least 0.719 ms long).

Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>

--- saa7134-alsa.c	2007-10-12 22:43:44.000000000 +0600
+++ saa7134-alsa.c	2007-10-30 21:01:10.000000000 +0500
@@ -544,8 +544,10 @@
 	   V4L functions, and force ALSA to use that as the DMA area */
 
 	substream->runtime->dma_area = dev->dmasound.dma.vmalloc;
+	substream->runtime->dma_bytes = dev->dmasound.bufsize;
+	substream->runtime->dma_addr = 0;
 
-	return 1;
+	return 0;
 
 }
 
@@ -653,6 +655,17 @@
 }
 
 /*
+ * page callback (needed for mmap)
+ */
+
+static struct page *snd_card_saa7134_page(struct snd_pcm_substream *substream,
+					unsigned long offset)
+{
+	void *pageptr = substream->runtime->dma_area + offset;
+	return vmalloc_to_page(pageptr);
+}
+
+/*
  * ALSA capture callbacks definition
  */
 
@@ -665,6 +678,7 @@
 	.prepare =		snd_card_saa7134_capture_prepare,
 	.trigger =		snd_card_saa7134_capture_trigger,
 	.pointer =		snd_card_saa7134_capture_pointer,
+	.page =			snd_card_saa7134_page,
 };
 
 /*



-- 
Alexander E. Patrakov
