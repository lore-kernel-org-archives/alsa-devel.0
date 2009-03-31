From: Daniel Mack <daniel@caiaq.de>
Subject: device underruns
Date: Tue, 31 Mar 2009 16:46:03 +0200
Message-ID: <20090331144603.GJ16811@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A57881037ED
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 16:46:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id E53027F4023
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 16:46:06 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHC1m9q--nTX for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 16:46:04 +0200 (CEST)
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

Hello,

I'm currently stress-testing my snd-usb-caiaq driver under several
environments and happen to see a number of such messages echoed once in
a while at the start of aplay (1.0.16):

underrun!!! (at least 1558380812.470 ms long)
underrun!!! (at least 1558380818.673 ms long)
underrun!!! (at least 1558380812.465 ms long)

Also, pulseaudio (0.9.14) keeps complaining with the following message
all over the place:

E: module-alsa-sink.c: ALSA woke us up to write new data to the device,                                                                                                                                   
   but there was actually nothing to write! Most likely this is an ALSA                                                                                                                                   
   driver bug. Please report this issue to the PulseAudio developers.

What puzzles me a bit is that I don't really know where and how the
driver could confuse the core so badly. All it reports is a valid
pointer to the current head in each substream. Is there anything else it
could provide for tighter syncing? Any hint how to debug this? Or maybe
it's not a bug in this specific driver but in the core somewhere?

Thanks,
Daniel
