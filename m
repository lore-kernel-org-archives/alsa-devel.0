From: Lennart Poettering <mznyfn@0pointer.de>
Subject: If /dev/snd/controlCx EACCES vs. ENODEV mixup
Date: Sun, 25 Nov 2007 22:03:59 +0100
Message-ID: <20071125210359.GB17108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6268724610
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:04:00 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

If /dev/snd/controlC0 is not accessible due to a permission problem
(EACCES), then alsa-libs will lie and return ENODEV. This is quite a
bit confusing:

<snip>
$ sudo chmod 000 /dev/snd/controlC0
$ aplay -D hw:0
ALSA lib pcm_hw.c:1207:(_snd_pcm_hw_open) Invalid value for card
aplay: main:546: audio open error: No such device
</snip>

(and strace shows that the actual problem is EACESS, as one would
assume.

I also filed this as bug on the BTS:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3600

BTW, what's the status of the BTS? Takashi asked me to post all my
issues on the ML instead of on the BTS. So why have the BTS at all?
It's even linked on the alsa-project.org front page under "I found a
bug!", which is a bit misleading. If this Mantis thing is not liked at
all, would it be possible to make some replacement available? Maybe
just use the kernel bugzilla on bugzilla.kernel.org? It's very fast,
and certainly more fun to work with than with Mantis.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
