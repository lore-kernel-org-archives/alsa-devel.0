From: Daniel Kasak <dkasak@nusconsulting.com.au>
Subject: Oops when unloading modules
Date: Mon, 10 Apr 2006 14:42:13 +1000
Message-ID: <4439E225.1070908@nusconsulting.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all.

I've been getting kernel oopses when unloading alsa modules, starting
from alsa-driver-1.0.10-rc3.

I've tried a number of kernels, and the alsa-driver version has ranged
from 1.0.10-rc3 to 1.0.11-rc3 to 1.0.11-rc4 ( which is the one I'm
currently testing ).

I was advised previously to test with a vanilla kernel, but
unfortunately I can't because I'm using a reiser4 root filesystem ...
but I swear that reiser4 is the only option I've added over a vanilla
kernel ... oh yeah ... other than the et131x module, for my ethernet
card ... and also the ipw2200 module for my wireless card. What can I
say? I need them all.

The Oops:

---

Unable to handle kernel paging request at 000000000044d087 RIP:
<ffffffff80224d30>{strlen+0}
PGD 3923c067 PUD 39e45067 PMD 3b49d067 PTE 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: et131x snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device ide_cd cdrom usbhid
snd_hda_intel snd_hda_codec snd_pcm snd_timer snd soundcore
snd_page_alloc ohci_hcd ohci1394 ieee1394 ipw2200 ieee80211
ieee80211_crypt ehci_hcd usbcore yenta_socket rsrc_nonstatic
Pid: 8400, comm: rmmod Tainted: P      2.6.16-beyond1 #1
RIP: 0010:[<ffffffff80224d30>] <ffffffff80224d30>{strlen+0}
RSP: 0018:ffff81003ed13e40  EFLAGS: 00010282
RAX: ffff81003e83e180 RBX: ffff81003e83e180 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffff81003e83e180 RDI: 000000000044d087
RBP: ffff81003e83e1e0 R08: ffff81003eb84090 R09: 0000000000036c8d
R10: 0000000000000000 R11: 0000000000000001 R12: 000000000044d087
R13: 0000000000000000 R14: 0000000000000880 R15: 00007ffffffa01e8
FS:  00002b4308b5fae0(0000) GS:ffffffff804f7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000044d087 CR3: 000000003bfd6000 CR4: 00000000000006e0
Process rmmod (pid: 8400, threadinfo ffff81003ed12000, task
ffff81003dc20f00)
Stack: ffffffff801b8eac 0000000000000046 ffff81003e83e180 000000000044d087
       ffff81003ece7540 ffff81003e83e180 ffff81003ed13f18 0000000000000000
       ffffffff880e3644 ffff81003e0a0eb8
Call Trace: <ffffffff801b8eac>{remove_proc_entry+76}
       <ffffffff880e3644>{:snd:snd_info_unregister+68}
<ffffffff88193294>{:snd_pcm_oss:snd_pcm_oss_unregister_minor+100}
       <ffffffff880fac3b>{:snd_pcm:snd_pcm_notify+91}
<ffffffff80147c74>{sys_delete_module+484}
       <ffffffff80224b63>{__up_write+307} <ffffffff8016f59a>{sys_munmap+90}
       <ffffffff8010ac36>{system_call+126}

Code: 80 3f 00 48 89 f8 74 08 48 ff c0 80 38 00 eb f6 48 29 f8 c3
RIP <ffffffff80224d30>{strlen+0} RSP <ffff81003ed13e40>
CR2: 000000000044d087

---

After this happens, whatever terminal was in use hangs. 'ps ax' shows a
process still trying to remove the snd_pcm_oss module.

Dan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
