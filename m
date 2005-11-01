From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Tue, 1 Nov 2005 22:23:59 +0000 (GMT)
Message-ID: <20051101222359.64797.qmail@web52906.mail.yahoo.com>
References: <s5hhdax8uu2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdax8uu2.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:
> Anyway, try the patch below.  We need a better clean up later.

The MIDI files play now, but this happened when I tried to unload the mod=
ules using the following
command:

# awk '{print \$1}' < /proc/modules | grep ^snd | xargs /sbin/rmmod

BUG: soft lockup detected on CPU#0!

Pid: 4057, comm:             asfxload
EIP: 0060:[<c029e7ee>] CPU: 0
EIP is at _spin_lock_irqsave+0x1e/0x30
 EFLAGS: 00000286    Not tainted  (2.6.14)
EAX: ddcd30ec EBX: ddcd30e4 ECX: 00000000 EDX: 00000286
ESI: ddcd30ec EDI: d96adf4c EBP: ddac8a70 DS: 007b ES: 007b
CR0: 8005003b CR2: 080df5d4 CR3: 1963d000 CR4: 000006d0
 [<c029e57c>] __down+0x3c/0xe0
 [<c0117ab0>] default_wake_function+0x0/0x10
 [<c014e3de>] unmap_region+0xfe/0x150
 [<c029cedf>] __down_failed+0x7/0xc
 [<e28e32f0>] snd_hwdep_release+0x0/0xd0 [snd_hwdep]
 [<e28e3be6>] .text.lock.hwdep+0x4b/0xf5 [snd_hwdep]
 [<c015aab6>] __fput+0x136/0x170
 [<c015906c>] filp_close+0x3c/0x80
 [<c0102e0f>] sysenter_past_esp+0x54/0x75

Cheers,
Chris



=09
=09
	=09
___________________________________________________________=20
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voic=
email http://uk.messenger.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
