From: Georg Sauthoff <gsauthof@TechFak.Uni-Bielefeld.DE>
Subject: PROBLEM: alsamixer - scheduling while atomic
Date: Sat, 9 Sep 2006 12:52:35 +0200
Message-ID: <20060909105234.GA25969@antipasto.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.TechFak.Uni-Bielefeld.DE
	(mailout.TechFak.Uni-Bielefeld.DE [129.70.136.245])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DF8A21B
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Sep 2006 12:52:38 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

with 2.6.17.11 from kernel.org I get 'sometimes' an oops/bug messages in
the kernel log, if I disconnect an usb sound device, while the
'alsamixer' application is running. I.e. until now I am unable to reproduce
it by purpose.

The alsamixer process then blocks forever, after displaying this
message:
alsamixer: function snd_mixer_poll_descriptors (POLLNVAL) failed:
Success

With 2.6.16.1 I see this message, too - but get no oops/bug message (and
alsamixer exits).

I am using alsamixer 1.0.8.

The message from the kernel log:
Sep  9 12:03:35 tp [17194975.256000] BUG: unable to handle kernel paging request at virtual address 7665652f
Sep  9 12:03:35 tp [17194975.256000]  printing eip:
Sep  9 12:03:35 tp [17194975.256000] c015f905
Sep  9 12:03:35 tp [17194975.256000] *pde = 00000000
Sep  9 12:03:35 tp [17194975.256000] Oops: 0002 [#1]
Sep  9 12:03:35 tp [17194975.256000] PREEMPT 
Sep  9 12:03:35 tp [17194975.256000] Modules linked in: nfs lockd sunrpc loop sd_mod usb_storage scsi_mod radeon drm uhci_hcd ehci_hcd psmouse ipw2100 snd_usb_audio snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep e100 mii usblp usbhid irtty_sir sir_dev irda crc_ccitt parport_pc parport 8250_pnp rtc ieee80211 ieee80211_crypt firmware_class yenta_socket rsrc_nonstatic pcmcia_core 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc intel_agp agpgart sha256 dm_crypt dm_mod aes_i586 nvram tun crc32 speedstep_centrino freq_table
Sep  9 12:03:35 tp [17194975.256000] CPU:    0
Sep  9 12:03:35 tp [17194975.256000] EIP:    0060:[<c015f905>]    Not tainted VLI
Sep  9 12:03:35 tp [17194975.256000] EFLAGS: 00010202   (2.6.17.11 #10) 
Sep  9 12:03:35 tp [17194975.256000] EIP is at __fput+0xc5/0x1a0
Sep  9 12:03:35 tp [17194975.256000] eax: 7665642f   ebx: cca40000   ecx: c020dba0   edx: 00000000
Sep  9 12:03:35 tp [17194975.256000] esi: f6f873c0   edi: f3f8dcdc   ebp: cca41f10   esp: cca41eec
Sep  9 12:03:35 tp [17194975.256000] ds: 007b   es: 007b   ss: 0068
Sep  9 12:03:35 tp [17194975.256000] Process alsamixer (pid: 21681, threadinfo=cca40000 task=dc66eab0)
Sep  9 12:03:35 tp [17194975.256000] Stack: f70207c0 f6f873c0 00000000 00000000 c17d30c0 ebe9ac38 f6f873c0 da971a40 
Sep  9 12:03:35 tp [17194975.256000]        00000000 cca41f18 c015f838 cca41f34 c015df6b f6f873c0 da971a40 00000001 
Sep  9 12:03:35 tp [17194975.256000]        00000003 d515b8c0 cca41f54 c011beb7 f6f873c0 da971a40 00000001 da971a40 
Sep  9 12:03:35 tp [17194975.256000] Call Trace:
Sep  9 12:03:35 tp [17194975.256000]  <c01036ea> show_stack_log_lvl+0x9a/0xc0  <c010391a> show_registers+0x19a/0x200
Sep  9 12:03:35 tp [17194975.256000]  <c0103b3c> die+0x10c/0x240  <c031ae14> do_page_fault+0x2e4/0x6b0
Sep  9 12:03:35 tp [17194975.256000]  <c01032fb> error_code+0x4f/0x54  <c015f838> fput+0x18/0x20
Sep  9 12:03:35 tp [17194975.256000]  <c015df6b> filp_close+0x4b/0x80  <c011beb7> close_files+0x67/0x80
Sep  9 12:03:35 tp [17194975.256000]  <c011bf39> put_files_struct+0x29/0x60  <c011c9f6> do_exit+0x116/0x480
Sep  9 12:03:35 tp [17194975.256000]  <c011cdc4> do_group_exit+0x34/0x90  <c011ce35> sys_exit_group+0x15/0x20
Sep  9 12:03:35 tp [17194975.256000]  <c010306b> sysenter_past_esp+0x54/0x75 
Sep  9 12:03:35 tp [17194975.256000] Code: 0f 85 e0 00 00 00 8b 87 0c 01 00 00 85 c0 0f 85 c5 00 00 00 8b 46 10 85 c0 74 29 8b 00 85 c0 74 23 bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 88 00 01 00 00 83 38 02 0f 84 8f 00 00 00 ff 4b 14 8b 43 08 
Sep  9 12:03:35 tp [17194975.256000] EIP: [<c015f905>] __fput+0xc5/0x1a0 SS:ESP 0068:cca41eec
Sep  9 12:03:35 tp [17194975.256000]  <1>Fixing recursive fault but reboot is needed!
Sep  9 12:03:35 tp [17194975.256000] BUG: scheduling while atomic: alsamixer/0x00000001/21681
Sep  9 12:03:35 tp [17194975.256000]  <c0103641> show_trace+0x21/0x30  <c010376e> dump_stack+0x1e/0x30
Sep  9 12:03:35 tp [17194975.256000]  <c0317e52> schedule+0x632/0x640  <c011cce0> do_exit+0x400/0x480
Sep  9 12:03:35 tp [17194975.256000]  <c0103c6e> die+0x23e/0x240  <c031ae14> do_page_fault+0x2e4/0x6b0
Sep  9 12:03:35 tp [17194975.256000]  <c01032fb> error_code+0x4f/0x54  <c015f838> fput+0x18/0x20
Sep  9 12:03:35 tp [17194975.256000]  <c015df6b> filp_close+0x4b/0x80  <c011beb7> close_files+0x67/0x80
Sep  9 12:03:35 tp [17194975.256000]  <c011bf39> put_files_struct+0x29/0x60  <c011c9f6> do_exit+0x116/0x480
Sep  9 12:03:35 tp [17194975.256000]  <c011cdc4> do_group_exit+0x34/0x90  <c011ce35> sys_exit_group+0x15/0x20
Sep  9 12:03:35 tp [17194975.256000]  <c010306b> sysenter_past_esp+0x54/0x75

It is a Thinkpad R40 2722 (Pentium M). Please let me now, if you need
additional information.

Best regards
Georg Sauthoff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
