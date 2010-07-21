From: Valdis.Kletnieks@vt.edu
Subject: mmotm 2010-07-19 - more pm_qos woes - audio this time
Date: Wed, 21 Jul 2010 08:54:52 -0400
Message-ID: <62037.1279716892@localhost>
References: <201007200007.o6K07Xbg028863@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8486303581884575219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
	by alsa0.perex.cz (Postfix) with ESMTP id D4022103935
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:54:54 +0200 (CEST)
In-Reply-To: Your message of "Mon, 19 Jul 2010 16:38:09 PDT."
	<201007200007.o6K07Xbg028863@imap1.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: akpm@linux-foundation.org, Takashi Iwai <tiwai@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--===============8486303581884575219==
Content-Type: multipart/signed; boundary="==_Exmh_1279716892_4552P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1279716892_4552P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Jul 2010 16:38:09 PDT, akpm@linux-foundation.org said:
> The mm-of-the-moment snapshot 2010-07-19-16-37 has been uploaded to
> 
>    http://userweb.kernel.org/~akpm/mmotm/

I've accumulated about 1,000 of these overnight. Seems to be consistently landing in
pairs based on the timestamps.

[42875.544006] WARNING: at lib/plist.c:57 plist_check_head+0x47/0x114()
[42875.544006] Hardware name: Latitude E6500
[42875.544006] Modules linked in: ppp_async sunrpc microcode usb_storage [last unloaded: scsi_wait_scan]
[42875.544006] Pid: 58070, comm: pulseaudio Tainted: G        W   2.6.35-rc5-mmotm0719 #2
[42875.544006] Call Trace:
[42875.544006]  [<ffffffff81037335>] warn_slowpath_common+0x80/0x98
[42875.544006]  [<ffffffff81037362>] warn_slowpath_null+0x15/0x17
[42875.544006]  [<ffffffff812051df>] plist_check_head+0x47/0x114
[42875.544006]  [<ffffffff812052c7>] plist_add+0x1b/0xb1
[42875.544006]  [<ffffffff81057b2e>] update_target+0x94/0xd0
[42875.544006]  [<ffffffff81057d54>] pm_qos_add_request+0x79/0x7b
[42875.544006]  [<ffffffff8141d199>] snd_pcm_hw_params+0x25a/0x28a
[42875.544006]  [<ffffffff8141da29>] snd_pcm_common_ioctl1+0x23b/0x980
[42875.544006]  [<ffffffff811c63db>] ? inode_has_perm.clone.18+0x92/0xa2
[42875.544006]  [<ffffffff8141e613>] snd_pcm_playback_ioctl1+0x231/0x246
[42875.544006]  [<ffffffff810d9178>] ? fd_install+0x36/0xd5
[42875.544006]  [<ffffffff8141e652>] snd_pcm_playback_ioctl+0x2a/0x2e
[42875.544006]  [<ffffffff810e91a0>] vfs_ioctl+0x31/0xa2
[42875.544006]  [<ffffffff810e9b1f>] do_vfs_ioctl+0x496/0x4c9
[42875.544006]  [<ffffffff810e9ba9>] sys_ioctl+0x57/0x96
[42875.544006]  [<ffffffff8100272b>] system_call_fastpath+0x16/0x1b
[42875.544006] ---[ end trace 23d666d936caf587 ]---
[42875.544006] ------------[ cut here ]------------
[42875.544006] WARNING: at lib/plist.c:57 plist_check_head+0x47/0x114()
[42875.544006] Hardware name: Latitude E6500
[42875.544006] Modules linked in: ppp_async sunrpc microcode usb_storage [last unloaded: scsi_wait_scan]
[42875.544006] Pid: 58070, comm: pulseaudio Tainted: G        W   2.6.35-rc5-mmotm0719 #2
[42875.544006] Call Trace:
[42875.544006]  [<ffffffff81037335>] warn_slowpath_common+0x80/0x98
[42875.544006]  [<ffffffff81037362>] warn_slowpath_null+0x15/0x17
[42875.544006]  [<ffffffff812051df>] plist_check_head+0x47/0x114
[42875.544006]  [<ffffffff81205354>] plist_add+0xa8/0xb1
[42875.544006]  [<ffffffff81057b2e>] update_target+0x94/0xd0
[42875.544006]  [<ffffffff81057d54>] pm_qos_add_request+0x79/0x7b
[42875.544006]  [<ffffffff8141d199>] snd_pcm_hw_params+0x25a/0x28a
[42875.544006]  [<ffffffff8141da29>] snd_pcm_common_ioctl1+0x23b/0x980
[42875.544006]  [<ffffffff811c63db>] ? inode_has_perm.clone.18+0x92/0xa2
[42875.544006]  [<ffffffff8141e613>] snd_pcm_playback_ioctl1+0x231/0x246
[42875.544006]  [<ffffffff810d9178>] ? fd_install+0x36/0xd5
[42875.544006]  [<ffffffff8141e652>] snd_pcm_playback_ioctl+0x2a/0x2e
[42875.544006]  [<ffffffff810e91a0>] vfs_ioctl+0x31/0xa2
[42875.544006]  [<ffffffff810e9b1f>] do_vfs_ioctl+0x496/0x4c9
[42875.544006]  [<ffffffff810e9ba9>] sys_ioctl+0x57/0x96
[42875.544006]  [<ffffffff8100272b>] system_call_fastpath+0x16/0x1b
[42875.544006] ---[ end trace 23d666d936caf588 ]---
[42882.427310] ------------[ cut here ]------------
[42882.428016] WARNING: at lib/plist.c:57 plist_check_head+0x47/0x114()
[42882.428016] Hardware name: Latitude E6500
[42882.428016] Modules linked in: ppp_async sunrpc microcode usb_storage [last unloaded: scsi_wait_scan]
[42882.428016] Pid: 58070, comm: pulseaudio Tainted: G        W   2.6.35-rc5-mmotm0719 #2
[42882.428016] Call Trace:
[42882.428016]  [<ffffffff81037335>] warn_slowpath_common+0x80/0x98
[42882.428016]  [<ffffffff81037362>] warn_slowpath_null+0x15/0x17
[42882.428016]  [<ffffffff812051df>] plist_check_head+0x47/0x114
[42882.428016]  [<ffffffff8120537c>] plist_del+0x1f/0x8b
[42882.428016]  [<ffffffff81057b21>] update_target+0x87/0xd0
[42882.428016]  [<ffffffff81057bb6>] pm_qos_remove_request+0x4c/0x5c
[42882.428016]  [<ffffffff8141dad9>] snd_pcm_common_ioctl1+0x2eb/0x980
[42882.428016]  [<ffffffff811c63db>] ? inode_has_perm.clone.18+0x92/0xa2
[42882.428016]  [<ffffffff8141e613>] snd_pcm_playback_ioctl1+0x231/0x246
[42882.428016]  [<ffffffff8109589d>] ? trace_preempt_on+0x15/0x28
[42882.428016]  [<ffffffff810c727e>] ? unmap_region+0xbd/0xcc
[42882.428016]  [<ffffffff8141e652>] snd_pcm_playback_ioctl+0x2a/0x2e
[42882.428016]  [<ffffffff810e91a0>] vfs_ioctl+0x31/0xa2
[42882.428016]  [<ffffffff810e9b1f>] do_vfs_ioctl+0x496/0x4c9
[42882.428016]  [<ffffffff810e9ba9>] sys_ioctl+0x57/0x96
[42882.428016]  [<ffffffff810c746a>] ? unlink_file_vma+0x2d/0x4d
[42882.428016]  [<ffffffff8100272b>] system_call_fastpath+0x16/0x1b
[42882.428016] ---[ end trace 23d666d936caf589 ]---
[42882.428016] ------------[ cut here ]------------
[42882.428016] WARNING: at lib/plist.c:57 plist_check_head+0x47/0x114()
[42882.428016] Hardware name: Latitude E6500
[42882.428016] Modules linked in: ppp_async sunrpc microcode usb_storage [last unloaded: scsi_wait_scan]
[42882.428016] Pid: 58070, comm: pulseaudio Tainted: G        W   2.6.35-rc5-mmotm0719 #2
[42882.428016] Call Trace:
[42882.428016]  [<ffffffff81037335>] warn_slowpath_common+0x80/0x98
[42882.428016]  [<ffffffff81037362>] warn_slowpath_null+0x15/0x17
[42882.428016]  [<ffffffff812051df>] plist_check_head+0x47/0x114
[42882.428016]  [<ffffffff812053df>] plist_del+0x82/0x8b
[42882.428016]  [<ffffffff81057b21>] update_target+0x87/0xd0
[42882.428016]  [<ffffffff81057bb6>] pm_qos_remove_request+0x4c/0x5c
[42882.428016]  [<ffffffff8141dad9>] snd_pcm_common_ioctl1+0x2eb/0x980
[42882.428016]  [<ffffffff811c63db>] ? inode_has_perm.clone.18+0x92/0xa2
[42882.428016]  [<ffffffff8141e613>] snd_pcm_playback_ioctl1+0x231/0x246
[42882.428016]  [<ffffffff8109589d>] ? trace_preempt_on+0x15/0x28
[42882.428016]  [<ffffffff810c727e>] ? unmap_region+0xbd/0xcc
[42882.428016]  [<ffffffff8141e652>] snd_pcm_playback_ioctl+0x2a/0x2e
[42882.428016]  [<ffffffff810e91a0>] vfs_ioctl+0x31/0xa2
[42882.428016]  [<ffffffff810e9b1f>] do_vfs_ioctl+0x496/0x4c9
[42882.428016]  [<ffffffff810e9ba9>] sys_ioctl+0x57/0x96
[42882.428016]  [<ffffffff810c746a>] ? unlink_file_vma+0x2d/0x4d
[42882.428016]  [<ffffffff8100272b>] system_call_fastpath+0x16/0x1b
[42882.428016] ---[ end trace 23d666d936caf58a ]---


--==_Exmh_1279716892_4552P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMRu4ccC3lWbTT17ARAnjTAKDKxuKTjRKI3+j6+f146FMApp8e9gCdEyTk
GUt+XWGDv7bdusy22eiWRdk=
=yo3Q
-----END PGP SIGNATURE-----

--==_Exmh_1279716892_4552P--


--===============8486303581884575219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8486303581884575219==--
