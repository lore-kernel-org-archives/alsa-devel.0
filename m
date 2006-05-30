From: Jiri Slaby <jirislaby@gmail.com>
Subject: BUG: possible deadlock detected! (sound) [Was:
	2.6.17-rc5-mm1]
Date: Tue, 30 May 2006 12:47:19 +0159
Message-ID: <447C22CE.2060402@gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7BA3150
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 12:47:27 +0200 (MEST)
Received: by nf-out-0910.google.com with SMTP id l23so74392nfc
	for <alsa-devel@alsa-project.org>; Tue, 30 May 2006 03:47:27 -0700 (PDT)
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, James@superbug.demon.co.uk, linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/

====================================
[ BUG: possible deadlock detected! ]
- ------------------------------------
idle/1 is trying to acquire lock:
 (&ops->reg_mutex){--..}, at: [<c03ca763>] mutex_lock+0x8/0xa

but task is already holding lock:
 (&ops->reg_mutex){--..}, at: [<c03ca763>] mutex_lock+0x8/0xa

which could potentially lead to deadlocks!

other info that might help us debug this:
1 locks held by idle/1:
 #0:  (&ops->reg_mutex){--..}, at: [<c03ca763>] mutex_lock+0x8/0xa

stack backtrace:
 [<c01042ac>] show_trace+0x1b/0x1d
 [<c01049f2>] dump_stack+0x26/0x28
 [<c01422fa>] __lockdep_acquire+0xa58/0xd8e
 [<c0142b97>] lockdep_acquire+0x73/0x88
 [<c03ca378>] __mutex_lock_slowpath+0xb3/0x496
 [<c03ca763>] mutex_lock+0x8/0xa
 [<c0333aa0>] snd_seq_device_new+0x96/0x111
 [<c0358260>] snd_emux_init_seq_oss+0x35/0x9c
 [<c0353f50>] snd_emux_register+0x10d/0x13f
 [<c0352c39>] snd_emu10k1_synth_new_device+0xe7/0x14e
 [<c0333537>] init_device+0x2c/0x94
 [<c0333d04>] snd_seq_device_register_driver+0x8f/0xeb
 [<c05911e0>] alsa_emu10k1_synth_init+0x22/0x24
 [<c01003cb>] init+0x12b/0x2f5
 [<c0101005>] kernel_thread_helper+0x5/0xb

If more info needed, feel free to ask.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEfCLOMsxVwznUen4RArelAJ0WtN36nSYJ3VWB515Wik2ji8YXAACfe5jD
jiPvjBzv4udC7XJPxTUtmOM=
=vLLJ
-----END PGP SIGNATURE-----
