From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: dmix problems/kernel
Date: Sun, 20 Aug 2006 13:16:03 +0200
Message-ID: <d9def9db0608200416g66ae7d48q39e85cfeab30a8c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

When I try to use dmix with my driver I get a problem with my kernel...
This only happens if I use the entry in the .asoundrc file, if I use
hw:2,0 playback works fine without any errors.. any idea what could be
wrong here?

Syslog:
Aug 20 09:40:56 debian kernel: ************************ OPEN
**********************
Aug 20 09:40:56 debian kernel: snd_au600_playback_open
Aug 20 09:40:56 debian kernel: hwparmas format: S16_LE
Aug 20 09:40:56 debian kernel: snd_au600_hw_playback_params
Aug 20 09:40:56 debian kernel: snd_au600_prepare
Aug 20 09:40:56 debian kernel: PCM PLAYBACK TRIGGER START!
Aug 20 09:40:56 debian kernel: 1
Aug 20 09:40:56 debian kernel: 2
Aug 20 09:40:56 debian kernel: 4
Aug 20 09:40:56 debian kernel: USERS: 1, ARG: 1, STATUS: 0
Aug 20 09:40:56 debian kernel: 5
Aug 20 09:40:56 debian kernel: au600.c: initiating IRQ
Aug 20 09:40:56 debian kernel: 6
Aug 20 09:40:56 debian kernel: 7
Aug 20 09:40:56 debian kernel: 3
-- theoretically playback should start here, but I don't even hear anything,
-- when the file is done it starts with following entries:
Aug 20 09:43:10 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7fcd000
Aug 20 09:43:10 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:43:10 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:43:10 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:43:10 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:43:10 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:43:10 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:43:12 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7f9b000
Aug 20 09:43:12 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:43:12 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:43:12 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:43:12 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:43:12 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:43:12 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:43:40 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7f8e000
Aug 20 09:43:40 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:43:40 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:43:40 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:43:40 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:43:40 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:43:40 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:44:29 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7fbf000
Aug 20 09:44:29 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:44:29 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:44:29 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:44:29 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:44:29 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:44:29 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:44:43 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7f92000
Aug 20 09:44:43 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:44:43 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:44:43 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:44:43 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:44:43 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:44:43 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:45:01 debian /USR/SBIN/CRON[15344]: (root) CMD ([ -x
/usr/lib/sysstat/sa1 ] && { [ -r "$DEFAULT" ] && . "$DEFAULT" ; [
"$ENABLED" = "true" ] && exec /usr/lib/sysstat/sa1; })
Aug 20 09:45:09 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7f4f000
Aug 20 09:45:09 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:45:09 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:45:09 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:45:09 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:45:09 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:45:09 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:45:18 debian kernel: Bad pte = 1fc7b067, process = aplay,
vm_flags = 800fb, vaddr = b7fd9000
Aug 20 09:45:18 debian kernel:  [vm_normal_page+67/93] vm_normal_page+0x43/0x5d
Aug 20 09:45:18 debian kernel:  [unmap_vmas+379/1114] unmap_vmas+0x17b/0x45a
Aug 20 09:45:18 debian kernel:  [unmap_region+119/246] unmap_region+0x77/0xf6
Aug 20 09:45:18 debian kernel:  [do_munmap+347/432] do_munmap+0x15b/0x1b0
Aug 20 09:45:18 debian kernel:  [sys_munmap+52/78] sys_munmap+0x34/0x4e
Aug 20 09:45:18 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 20 09:47:33 debian kernel: PCM PLAYBACK TRIGGER STOP!
Aug 20 09:47:33 debian kernel: snd_au600_hw_playback_free
Aug 20 09:47:33 debian kernel: USERS: 1
Aug 20 09:47:33 debian kernel: 1
Aug 20 09:47:33 debian kernel: SWITCHING OFF STREAM!
Aug 20 09:47:33 debian kernel: 4
Aug 20 09:47:33 debian kernel: USERS: 0, ARG: 0, STATUS: 1
----

afterwards I'm unable to start anything on my host anymore.

----

.asoundrc
pcm.rateconvertin {
        type dmix
        ipc_key 1024
        ipc_perm 0777
        slave {
                pcm "hw:2,0"
                period_time 0
                period_size 192
                buffer_size 384
                format S16_LE
                periods 255
                rate 9600
        }
}

----

current driver sources:
http://kurzlink.de/0qUcA3gX8

thanks,
Markus

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
