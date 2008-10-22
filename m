From: "John Kacur" <jkacur@gmail.com>
Subject: quick question, BT codec???
Date: Wed, 22 Oct 2008 10:36:40 +0200
Message-ID: <520f0cf10810220136h7d9d1877tbbaa7f4f956be97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BCE5244C7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 10:36:58 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so1489656waf.16
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 01:36:40 -0700 (PDT)
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

Hello, quick question, both s3c24xx-pcm.c and pxa2xx-pcm.c contain the
following comment and code segment, what does the "BT codec" refer to?

/* return if this is a bufferless transfer e.g.
	 * codec <--> BT codec or GSM modem -- lg FIXME */
if (!dma)
	return 0;
