From: Lee Revell <rlrevell@joe-job.com>
Subject: Oops with emu10k1 multichannel device - possible bug
Date: Fri, 18 Feb 2005 17:15:03 -0500
Message-ID: <1108764903.5278.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Testing ALSA CVS on a new machine using the emu10k1 multichannel device
produced this Oops.  I am investigating.  Although the multichannel
patch was very well tested, until further notice the device should be
considered buggy.

Lee

BUG: Unable to handle kernel paging request at virtual address 03020108
 printing eip:
e09ad9e6
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: realtime commoncap snd_emu10k1 snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_alloc snd_util_mem snd_hwdep snd af_packet e100 mii
uhci_hcd evdev psmouse usbhid ehci_hcd usbcore
CPU:    0
EIP:    0060:[<e09ad9e6>]    Not tainted VLI
EFLAGS: 00210286   (2.6.11-rc4-RT-V0.7.39-02) 
EIP is at snd_emu10k1_pcm_init_voice+0x16/0x5e0 [snd_emu10k1]
eax: 03020100   ebx: 00001700   ecx: 00000008   edx: d41caa08
esi: 00001700   edi: d41caa08   ebp: d41ca000   esp: de725e24
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process jackd (pid: 5231, threadinfo=de724000 task=d5646550)
Stack: d41ca000 0808001a 0000003f 00000000 00200212 00000001 00000000
df52ac00 
       000000ff 00000000 0e0d000c 00000000 00001700 00001700 0000000e
de21bd80 
       e09ae386 d41ca000 00000000 00000000 d41caa08 00001680 00001700
00000080 
Call Trace:
 [<e09ae386>] snd_emu10k1_efx_playback_prepare+0xd6/0xf0 [snd_emu10k1]
(68)
 [<e0972774>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm] (52)
 [<e0971d16>] snd_pcm_action_group+0x96/0x1b0 [snd_pcm] (16)
 [<e0972045>] snd_pcm_action_nonatomic+0x65/0xa0 [snd_pcm] (32)
 [<e09727ef>] snd_pcm_prepare+0x1f/0x30 [snd_pcm] (36)
 [<e0974ee2>] snd_pcm_playback_ioctl1+0x52/0x370 [snd_pcm] (16)
 [<c02a224e>] lock_kernel+0x2e/0x50 (44)
 [<e0975f38>] snd_pcm_playback_ioctl_old+0x28/0x40 [snd_pcm] (20)
 [<c0162a6f>] do_ioctl+0x6f/0xa0 (20)
 [<c0162ce5>] vfs_ioctl+0x65/0x1e0 (36)
 [<c0162ec7>] sys_ioctl+0x67/0xa0 (36)
 [<c010270b>] syscall_call+0x7/0xb (40)
Code: 00 00 06 89 f6 c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55
57 56 53 83 ec 30 8b 54 24 50 8b 7c 24 50 8b 6c 24 44 8b 42 10 <8b> 50
08 8b 4a 60 89 4c 24 1c 83 78 04 01 8b 77 04 0f 84 93 05



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
