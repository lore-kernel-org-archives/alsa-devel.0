From: Eliot Blennerhassett <linux@audioscience.com>
Subject: export pcm_debug_name?
Date: Thu, 31 Mar 2011 11:08:24 +1300
Message-ID: <4D93A9D8.2090104@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 1883A10381B
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 00:08:32 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LIW00M995I1F920@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 31 Mar 2011 11:08:26 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Currently defined locally in pcm_lib.c, this function would be useful
for debug output from drivers too?

Any objection to exporting this function?


> static void pcm_debug_name(struct snd_pcm_substream *substream,
> 			   char *name, size_t len)
> {
> 	snprintf(name, len, "pcmC%dD%d%c:%d",
> 		 substream->pcm->card->number,
> 		 substream->pcm->device,
> 		 substream->stream ? 'c' : 'p',
> 		 substream->number);
> }

-- 
Eliot Blennerhassett
AudioScience Inc.
