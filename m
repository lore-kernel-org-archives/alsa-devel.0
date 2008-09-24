From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Something wrong with snd_pcm_avail_update
Date: Wed, 24 Sep 2008 02:19:54 +0200
Message-ID: <20080924001954.GA5422@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D39B24149
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 02:19:55 +0200 (CEST)
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

Heya!

There seems to be something wrong with snd_pcm_update_avail() for mmap
in recent 2.6.26 kernels:

Quoting Alexander Gavrilov:

<snip>
Fedora 9 with kernel 2.6.26.3-29 exhibits a bug where
the driver decrements its hw.ptr under certain stress
conditions, or at least it appears so from debugging.

It causes alsa-lib to give absurdly huge avail numbers
to pulseaudio, which crashes it. This patch adds a
work-around to avoid such unfriendly behavior until
the bug is fixed.

As this is not a real fix, it displays a message every
time it is activated.
</snip>

https://bugzilla.redhat.com/show_bug.cgi?id=462200

(see the patch attached to that bug report)

Takashi, Jaroslav, do you know anything about this?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
