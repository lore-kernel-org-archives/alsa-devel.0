From: Jon Smirl <jonsmirl@gmail.com>
Subject: Setting the AC97 private data
Date: Tue, 28 Apr 2009 12:51:31 -0400
Message-ID: <9e4733910904280951t3f03f8c4p44e4a7025ebb7ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 88AAA10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 18:51:33 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so463302wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 09:51:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My AC97 CPU read/write routines need private data set so that they
know which port to use. The mpc5200 has multiple PSCs that can
function in AC97 mode.

static int psc_dma_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
			   struct snd_pcm *pcm)
{
...
	if (rtd->socdev->card->codec->ac97)
		rtd->socdev->card->codec->ac97->private_data = psc_dma;
..
}

Is there some easier way to set this data?

-- 
Jon Smirl
jonsmirl@gmail.com
