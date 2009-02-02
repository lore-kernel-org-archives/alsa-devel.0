From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Confusion about whether
	snd_pcm_poll_descriptors_revents()'s	revents field is a
	single integer or an array
Date: Mon, 2 Feb 2009 03:50:22 +0100
Message-ID: <20090202025021.GA20642@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C752124399
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 03:50:24 +0100 (CET)
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

If we look into the pcm example how snd_pcm_poll_descriptors_revents()
is used then we can see that the revents parameter apparently is
supposed to be a single integer. (which makes a lot of sense to me)

http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a33

However, snd_pcm_wait_nocheck() calls the same function and assumes it
is a complete array!

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm.c;h=74d1d1a4bd6083cd461b6d793c0ae41cca912f16;hb=HEAD#l2368

So what's it now? It makes more sense to me if it would be a single
fd. 

The problem becomnes visible if someone writes a plugin that wants
wakeups from more than one fd because either snd_pcm_wait() using
applications start to act weirdly because the revents are not fully
initialized or snd_pcm_poll_descriptors_revents() using applications
get invalid memory accesses.

This has become visible in the Bluetooth plugin.

I guess nobody has written a plugin that has more than one fd to sleep
on yet, right?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
