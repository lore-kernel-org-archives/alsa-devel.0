From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Oops in snd_emu10k1_efx_playback_prepare
Date: Fri, 18 Mar 2005 22:37:12 -0500
Message-ID: <1111203432.12740.13.camel@mindpipe>
References: <1110347780.7123.21.camel@mindpipe>
	 <s5hbr9t5efx.wl@alsa2.suse.de> <s5h8y4x5btl.wl@alsa2.suse.de>
	 <s5his40wx9t.wl@alsa2.suse.de> <1110490545.14297.9.camel@mindpipe>
	 <s5hll8uup1p.wl@alsa2.suse.de>  <1111203050.12740.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111203050.12740.7.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-18 at 22:30 -0500, Lee Revell wrote:
> Unable to handle kernel paging request at virtual address 936e4158

Sorry, ksymoops is really useless.  The oops from dmesg is a lot better:

Unable to handle kernel paging request at virtual address 936e4158
 printing eip:
c01d3d63
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: snd_usb_audio snd_usb_lib snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss
snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_alloc snd_util_mem snd_hwdep snd realtime commoncap
af_packet e100 mii uhci_hcd agpgart evdev psmouse usbhid ehci_hcd
usbcore
CPU:    0
EIP:    0060:[<c01d3d63>]    Not tainted VLI
EFLAGS: 00210012   (2.6.12-rc1) 
EIP is at memcpy+0x23/0x60
eax: 00000008   ebx: 936e4170   ecx: 00000002   edx: d0b9fe3c
esi: 936e4158   edi: d0b9fe3c   ebp: d0b9fe0c   esp: d0b9fdf8
ds: 007b   es: 007b   ss: 0068
Process jackd (pid: 13176, threadinfo=d0b9e000 task=d2d4f580)
Stack: 00200046 def60000 0779dfff 03020100 00000001 d0b9fe50 e08e2178
d0b9fe3c 
       936e4158 00000008 00000000 00200216 00000001 00000000 de61e000
00000005 
       00000000 00000002 00000005 00001780 00001780 0000000f d0b9fe88
e08e2597 
Call Trace:
 [<c01031cf>] show_stack+0x7f/0xa0
 [<c010336a>] show_registers+0x15a/0x1c0
 [<c0103560>] die+0xf0/0x190
 [<c010e34b>] do_page_fault+0x31b/0x670
 [<c0102e23>] error_code+0x2b/0x30
 [<e08e2178>] snd_emu10k1_pcm_init_voice+0x5c8/0x610 [snd_emu10k1]
 [<e08e2597>] snd_emu10k1_efx_playback_prepare+0xd7/0xf0 [snd_emu10k1]
 [<e08987f5>] snd_pcm_do_prepare+0x15/0x40 [snd_pcm]
 [<e0897eb4>] snd_pcm_action_single+0x34/0x70 [snd_pcm]
 [<e08980f3>] snd_pcm_action_nonatomic+0x73/0x80 [snd_pcm]
 [<e0898871>] snd_pcm_prepare+0x21/0x30 [snd_pcm]
 [<e089af67>] snd_pcm_playback_ioctl1+0x47/0x2d0 [snd_pcm]
 [<e089be97>] snd_pcm_playback_ioctl_old+0x27/0x40 [snd_pcm]
 [<c01631a3>] do_ioctl+0x63/0x90
 [<c0163362>] vfs_ioctl+0x62/0x1c0
 [<c0163521>] sys_ioctl+0x61/0x80
 [<c0102c75>] syscall_call+0x7/0xb
Code: 90 90 90 90 90 90 90 90 55 89 e5 83 ec 14 8b 45 10 89 75 f8 89 7d
fc 8b 55 08 8b 75 0c 3d ff 01 00 00 77 24 89 c1 89 d7 c1 e9 02 <f3> a5
a8 02 74 02 66 a5 a8 01 74 01 a4 89 d0 8b 75 f8 8b 7d fc 
 <6>note: jackd[13176] exited with preempt_count 1

Now, the only memcpy's in snd_emu10k1_pcm_init_voice are these:

311         /* volume parameters */
312         if (extra) {
313                 attn = 0;
314                 memset(send_routing, 0, sizeof(send_routing));
315                 send_routing[0] = 0;
316                 send_routing[1] = 1;
317                 send_routing[2] = 2;
318                 send_routing[3] = 3;
319                 memset(send_amount, 0, sizeof(send_amount));
320         } else {
321                 /* mono, left, right (master voice = left) */
322                 tmp = stereo ? (master ? 1 : 2) : 0;
323                 memcpy(send_routing, &mix->send_routing[tmp][0], 8);
324                 memcpy(send_amount, &mix->send_volume[tmp][0], 8);
325         }
326 

It looks like this is related to the change I made to the send routing
controls for the multichannel device.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
