From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: BUG_ON warning
Date: Wed, 13 Aug 2008 13:35:43 -0400
Message-ID: <48A31B6F.5000405@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 32AAF24561
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 19:35:56 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

I'm getting this warning with the latest snapshot from the git repo.
Any ideas on what is causing this?

-Matt Ranostay


WARNING: at /home/mranostay/git/alsa-driver/acore/timer.c:311 snd_timer_close()
BUG? (!timer)
Pid: 2461, comm: aplay Not tainted 2.6.25.9 #0
 [<e08f5ddf>] snd_timer_close+0x30/0x37 [snd_timer]
 [<e08f5e12>] snd_timer_user_release+0x2c/0x4a [snd_timer]
 [<c047e0d2>] __fput+0xad/0x15b
 [<c047e359>] fput+0x17/0x19
 [<c047ba44>] filp_close+0x50/0x5a
 [<c047cb86>] sys_close+0x69/0x9f
 [<c0405a76>] syscall_call+0x7/0xb
 [<c0620000>] ? schedule+0x61b/0x668
 =======================
