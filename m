From: Dave Jones <davej@redhat.com>
Subject: ac97 oops in ali modem driver
Date: Sun, 2 Oct 2005 21:01:09 -0400
Message-ID: <20051003010109.GA27888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A0D11B9
	for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2005 03:01:12 +0200 (MEST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j9311CLR008540
	for <alsa-devel@alsa-project.org>; Sun, 2 Oct 2005 21:01:12 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j9311BV12153
	for <alsa-devel@alsa-project.org>; Sun, 2 Oct 2005 21:01:12 -0400
Received: from nwo.kernelslacker.org (vpn83-128.boston.redhat.com [172.16.83.128])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j9311BF5030449
	for <alsa-devel@alsa-project.org>; Sun, 2 Oct 2005 21:01:11 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id j9311Auv032404
	for <alsa-devel@alsa-project.org>; Sun, 2 Oct 2005 21:01:10 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id j9311Ajm032403
	for alsa-devel@alsa-project.org; Sun, 2 Oct 2005 21:01:10 -0400
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just had a user file a Fedora bug with the following oops.

Unable to handle kernel NULL pointer dereference at virtual address 000001a4
 printing eip:
df969005
*pde = 12620067
Oops: 0000 [#1]
Modules linked in: nfs radeon drm nfsd exportfs lockd nfs_acl autofs4 sunrpc pcmcia dm_mod vid
eo button battery ac yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd shpchp i2c_ali1535 i2c_c
ore snd_ali5451 snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_de
vice snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc prism54 8139cp m
ii floppy joydev ext3 jbd
CPU:    0
EIP:    0060:[<df969005>]    Not tainted VLI
EFLAGS: 00010202   (2.6.13-1.1526_FC4)
EIP is at snd_ac97_valid_reg+0x5/0x135 [snd_ac97_codec]
eax: 00000000   ebx: 00000040   ecx: 00000000   edx: 00000040
esi: 00000000   edi: 00000040   ebp: 00001f40   esp: ca515edc
ds: 007b   es: 007b   ss: 0068
Process gstreamer-prope (pid: 10503, threadinfo=ca515000 task=da809aa0)
Stack: 00000040 df969149 de2ac800 00000001 d4fb1000 de3bf560 df9207ca 00000000
       fffffff4 de3bf560 db6b9000 df92d6b2 00000000 00000001 00000246 00000000
       00000000 00000000 0000025c 0000025c d4fb1000 d4fb1000 fffffff4 de3bf560
Call Trace:
 [<df969149>] snd_ac97_write+0x14/0x5a [snd_ac97_codec]
 [<df9207ca>] snd_ali_modem_hw_params+0x2c/0x4c [snd_ali5451]
 [<df92d6b2>] snd_pcm_hw_params+0x290/0x609 [snd_pcm]
 [<df92da7b>] snd_pcm_hw_params_user+0x50/0x6a [snd_pcm]
 [<df9349b5>] snd_pcm_capture_ioctl1+0x2e/0x1ce [snd_pcm]
 [<df934b70>] snd_pcm_capture_ioctl+0x0/0x1b [snd_pcm]
 [<c01bf0e9>] do_ioctl+0x19/0x55
 [<c01bf217>] vfs_ioctl+0x50/0x1aa
 [<c01bf3ce>] sys_ioctl+0x5d/0x6b
 [<c0104409>] sysenter_past_esp+0x56/0x79
Code:  Bad EIP value.


It looks like we're somehow ending up with card->ac97 == NULL.
This kernel is based on 2.6.13.2, with no ALSA patches other than
an unrelated emu10k1 diff.  From eyeballing a quick diff of
the ali driver between 2.6.13.2 and current upstream 2.6.14rc3,
it doesn't look like this has been addressed already.

		Dave



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
