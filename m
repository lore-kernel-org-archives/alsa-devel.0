From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Error with custom driver: playback drain error (DMA or
	IRQ trouble?)
Date: Mon, 07 Sep 2009 16:25:07 +0200
Message-ID: <4AA517C3.5030409@gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>	<s5hljkrrl3s.wl%tiwai@suse.de>
	<1252330155.3283.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 19B022435D
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:25:33 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 5FABC4BE06
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:25:42 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qT8huVgDaBMN for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:25:42 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id F384B4BE04
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:25:41 +0200 (CEST)
In-Reply-To: <1252330155.3283.5.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

at the moment I'm trying to implement a custom driver which will use SPI
 to transfer the PCM samples to a speech codec chip.

Since I guess that I will also have some problems with getting the SPI
timing right for the speech codec chip, I'm planning to bitbang the data.
For this reason in the driver I'm using non-dma transfers and the
copy/silence callbacks.

However, with my current code the content of the PCM buffer is only
copied a few times.
After that it seems to get stuck followed by the error:
	
	ALSA sound/core/pcm_native.c:1499: playback drain error (DMA or IRQ
trouble?)

The code for the driver is available on pastebin here:
http://pastebin.com/m110336f0

Why do I get the drain error, why does the PCM sample transfer get stuck ?


cheers,
stefan
