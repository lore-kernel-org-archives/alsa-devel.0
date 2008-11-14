From: "John Kacur" <jkacur@gmail.com>
Subject: snd_pcm_ops
Date: Fri, 14 Nov 2008 10:08:01 +0100
Message-ID: <520f0cf10811140108v305639f3x11fdfcbd10c44dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A8B243C2
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 10:08:02 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1391010rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 01:08:01 -0800 (PST)
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
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

As a newcomer to alsa, I have a few more probably simple questions. I
noticed in the SOC drivers, that when the struct snd_pcm_ops is filled
in, .copy is omitted, for example in file s3c24xx-pcm.c, you see the
following initialization.

static struct snd_pcm_ops s3c24xx_pcm_ops = {
	.open		= s3c24xx_pcm_open,
	.close		= s3c24xx_pcm_close,
	.ioctl		= snd_pcm_lib_ioctl,
	.hw_params	= s3c24xx_pcm_hw_params,
	.hw_free	= s3c24xx_pcm_hw_free,
	.prepare	= s3c24xx_pcm_prepare,
	.trigger	= s3c24xx_pcm_trigger,
	.pointer	= s3c24xx_pcm_pointer,
	.mmap		= s3c24xx_pcm_mmap,
};

How is this supposed to work if somewhere down the line
substream->ops->copy is called?

Thanks in advance for any pointers.
