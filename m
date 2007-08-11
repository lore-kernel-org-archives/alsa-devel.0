From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Writing a new sound driver
Date: Sat, 11 Aug 2007 16:46:07 -0600
Message-ID: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 599701038B1
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Aug 2007 00:46:09 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1152576fka
	for <alsa-devel@alsa-project.org>; Sat, 11 Aug 2007 15:46:08 -0700 (PDT)
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

I am the developer of the work-in-progress MyHD/TL880 Linux driver.
The TL880 chip can act as a sound input and output device, but it
doesn't seem to support DMA for sound.  Is it possible to write a
sound driver for ALSA that uses a polling mechanism?  Also, how would
I integrate this driver with my core driver for accessing the TL880?
The chip's features span four separate kernel subsystems: v4l, dvb,
sound, and fb.

I guess my main question is this: what is the bare minimum of code and
hardware functionality required to write a sound driver?

Thanks,
Mike Bourgeous
http://myhd.sourceforge.net/
