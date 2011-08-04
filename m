From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: snd soc spi read/write
Date: Thu, 4 Aug 2011 18:24:04 +0800
Message-ID: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 30AD624566
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 12:24:08 +0200 (CEST)
Received: by qwf7 with SMTP id 7so991686qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 03:24:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

My version is linux 3.0, I found snd_soc_spi_read/write didn't work at
16-8 bit mode.
The addr is 16bit, the function compares reg with reg_cache_size. This
certainly causes failure.
In the former version, reg &= 0xff seems right. So how to use
snd_soc_16_8_write now?

Regards,
Scott
