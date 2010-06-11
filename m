From: Daniel Mack <daniel@caiaq.de>
Subject: usb-audio: some UAC2 fixes
Date: Fri, 11 Jun 2010 15:33:07 +0200
Message-ID: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 400701039BC
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 15:33:40 +0200 (CEST)
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

here are four small patches that fix some minor bugs in the UAC2
implementation. Thanks to Alex Lee for reporting them.

Don't know if it's possible to get them into 2.6.35 as they're no
regressions in respect to 2.6.34 (I followed the recent discussions on
LKML). However, they fix real bugs and I would also label them
stable@kernel.org if 2.6.35 would have already been released.
So .. I don't know :)

I have a number of more patches that do cleanups and implement more
functions, but they can certainly go into 2.6.36 and they're not
finished yet, so I'm cooking them for some more time.

Thanks,
Daniel

[PATCH 1/4] ALSA: usb-audio: add check for faulty clock in parse_audio_format_rates_v2()
[PATCH 2/4] ALSA: usb-audio: fix control messages for USB_RECIP_INTERFACE
[PATCH 3/4] ALSA: usb-audio: parse UAC2 sample rate ranges correctly
[PATCH 4/4] ALSA: usb-audio: fix UAC2 control value queries
