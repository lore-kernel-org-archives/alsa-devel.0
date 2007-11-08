From: "Sonic Zhang" <sonic.adi@gmail.com>
Subject: When command SNDRV_PCM_TRIGGER_STOP is asked in
	snd_pcm_ops trigger(),
	which buffer in the buffer list should be the last one to output by
	the DMA?
Date: Thu, 8 Nov 2007 13:43:13 +0800
Message-ID: <4e5ebad50711072143t230c737fv7af600fe172ccd34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DB35247AE
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 06:43:15 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so46158fka
	for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2007 21:43:14 -0800 (PST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

In our blackfin ad1981 linux driver, there is an output ring with
"periods" buffers. Each buffer is of the size of "period_size".

After ALSA starts playing, several buffers ahead of current one
running by the DMA controller are usually filled in advance by the
ALSA layer. When command SNDRV_PCM_TRIGGER_STOP is asked in
snd_pcm_ops trigger(), which buffer should be the last one to output
by the DMA?

1. Current buffer, which is running by the DMA controller
2. The last buffer, which the DMA controller just finished outputting
and snd_pcm_ops pointer() is notifiyed to ALSA layer. Does this mean
current buffer in DMA should be abandoned in the middle?
3. The last buffer, which the ALSA layer has just filled in snd_pcm_ops copy()?


Thanks
