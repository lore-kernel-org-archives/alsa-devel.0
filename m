From: Vince <fuzzy77@free.fr>
Subject: ALSA oops (2.6.0-test8-mm1)
Date: Thu, 23 Oct 2003 23:01:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F984192.4040109@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I get the following oops when running the flash plugin of 
mozilla-firebird:

Unable to handle kernel paging request at virtual address d0ba8000
  printing eip:
d0b20a1b
*pde = 012ea067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0b20a1b>]    Not tainted VLI
EFLAGS: 00210202
EIP is at resample_expand+0x169/0x2ff [snd_pcm_oss]
eax: d0b20a1b   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: d0ba45a2   ebp: d0ba7ffe   esp: ce629e24
ds: 007b   es: 007b   ss: 0068
Process MozillaFirebird (pid: 2098, threadinfo=ce628000 task=c1e846b0)
Stack: d0b20aec d0b20a1b cd732290 cd732270 00000000 00000004 00000004
00000001
        00000000 0000023d 00001169 00000800 cd732200 c3985880 d0b20fc6
cd732200
        c39857c0 c3985880 00000800 00001169 cd732200 00000800 00001169
c4d8b4c0
Call Trace:
  [<d0b20aec>] resample_expand+0x23a/0x2ff [snd_pcm_oss]
  [<d0b20a1b>] resample_expand+0x169/0x2ff [snd_pcm_oss]
  [<d0b20fc6>] rate_transfer+0x34/0x3e [snd_pcm_oss]
  [<d0b1e962>] snd_pcm_plug_write_transfer+0x8b/0xbd [snd_pcm_oss]
  [<d0b1b069>] snd_pcm_oss_write2+0xce/0x116 [snd_pcm_oss]
  [<d0b1b58d>] snd_pcm_oss_sync1+0x4c/0x10d [snd_pcm_oss]
  [<c011b3b4>] default_wake_function+0x0/0x18
  [<d0a9bce4>] snd_pcm_format_set_silence+0x69/0x176 [snd_pcm]
  [<d0b1b750>] snd_pcm_oss_sync+0x102/0x197 [snd_pcm_oss]
  [<d0b1c755>] snd_pcm_oss_release+0x1c/0xa8 [snd_pcm_oss]
  [<c014adc4>] __fput+0x3b/0xde
  [<c0149a5b>] filp_close+0x59/0x62
  [<c0149abc>] sys_close+0x58/0x7a
  [<c025dca3>] syscall_call+0x7/0xb

Code: 22 8b 44 24 10 ff 4c 24 10 85 c0 0f 8e 91 00 00 00 8b 44 24 04 ff
e0 0f b6 45 00 eb 07 0f b6 45 00 83 f0 80 89 c6 c1 e6 08 eb 6e <8b> 75
00 eb 69 8b 75 00 eb 44 8b 75 00 eb 59 8b 75 00 66 81 f6

Kernel is 2.6.0-test8-mm1, patched with -exec-shield-nptl

modprobe.conf contains: options snd-via82xx dxs_support=1
but I get the same oops without this option...

My full config below:
diablo:/# cat /proc/asound/cards
0 [V8235          ]: VIA8233 - VIA 8235
                      VIA 8235 at 0xe400, irq 22

diablo:/# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25
19:16:36 2003 UTC).
Compiled on Oct 21 2003 for kernel 2.6.0-test8-mm1-exec-shield-nptl.

diablo:~# cat /proc/asound/modules
0 snd_via82xx



diablo:~# cat /proc/asound/devices
   0: [0- 0]: ctl
  17: [0- 1]: digital audio playback
  25: [0- 1]: digital audio capture
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
   1:       : sequencer
  33:       : timer

diablo:~# cat /proc/asound/pcm
00-00: VIA 8235 : VIA 8235 : playback 4 : capture 1
00-01: VIA 8235 : VIA 8235 : playback 1 : capture 1

diablo:~# cat /proc/asound/card0/pcm0p/sub1/hw_params
/proc/asound/card0/pcm0p/sub1/info
/proc/asound/card0/pcm0p/sub1/prealloc
/proc/asound/card0/pcm0p/sub1/status /proc/asound/card0/pcm0p/sub1/sw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 4457
buffer_size: 13371
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 22050
OSS period bytes: 8192
OSS periods: 3
card: 0
device: 0
subdevice: 1
stream: PLAYBACK
id: VIA 8235
name: VIA 8235
subname: subdevice #1
class: 0
subclass: 0
subdevices_count: 4
subdevices_avail: 3
64
state: XRUN
trigger_time: 1066933262.000399244
tstamp      : 1066940539.000610996
delay       : 0
avail       : 13371
avail_max   : 13371
-----
hw_ptr      : 4457
appl_ptr    : 4457
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4457
xfer_align: 1
start_threshold: 1
stop_threshold: 13371
silence_threshold: 4473
silence_size: 4473
boundary: 1752563712

Also, it looks like /proc/modules is somewhat corrupted (but lsmod is 
ok...):
diablo:~# cat /proc/modules
loop 12104 0 - Live 0xd0bae000
sch_ingress 2692 1 - Live 0xd0a90000
cls_u32 5700 6 - Live 0xd0b91000
sch_sfq 4160 3 - Live 0xd0b8e000
sch_htb 19136 1 - Live 0xd0b95000
ip_conntrack_ftp 70708 0 - Live 0xd0b7b000
ipt_MASQUERADE 2560 2 - Live 0xd0b51000
iptable_mangle 1984 0 - Live 0xd0b4f000
iptable_nat 17004 2 ipt_MASQUERADE, Live 0xd0b65000
ipt_REJECT 4672 8 - Live 0xd0b5b000
ipt_limit 1792 29 - Live 0xd0b41000
ipt_state 1408 4 - Live 0xd0b18000
ip_conntrack 24816 4
ip_conntrack_ftp,ipt_MASQUERADE,iptable_nat,ipt_state, Live 0xd0b53000
ipt_LOG 4416 15 - Live 0xd0b47000
ipt_ULOG 5288 12 - Live 0xd0b44000
iptable_filter 2048 1 - Live 0xd0a30000
ip_tables 13888 9
ipt_MASQUERADE,iptable_mangle,iptable_nat,ipt_REJECT,ipt_limit,ipt_state,ipt_LOG,ipt_ULOG,iptable_filter, 

Live 0xd0b3c000binfmt_misc 7496 1 - Live 0xd0a4e000
speedtch 11504 1 - Live 0xd0b38000
lirc_atiusb 10752 1 - Live 0xd0b2b000
af_packet 15176 2 - Live 0xd0b26000
snd_seq_oss 27008 0 - Live 0xd0b30000
snd_seq_midi_event 5824 1 snd_seq_oss, Live 0xd0a51000
snd_seq 44432 4 snd_seq_oss,snd_seq_midi_event, Live 0xd0b0c000
snd_pcm_oss 42148 1 - Live 0xd0b1a000
snd_mixer_oss 13824 2 snd_pcm_oss, Live 0xd09ef000
snd_via82xx 18848 2 - Live 0xd0a66000
snd_pcm 74212 2 snd_pcm_oss,snd_via82xx, Live 0xd0a92000
snd_timer 19012 2 snd_seq,snd_pcm, Live 0xd0a60000
snd_ac97_codec 43396 1 snd_via82xx, Live 0xd0a6f000
snd_page_alloc 8260 2 snd_via82xx,snd_pcm, Live 0xd0a2c000
snd_mpu401_uart 5120 1 snd_via82xx, Live 0xd0a29000
snd_rawmidi 18208 1 snd_mpu401_uart, Live 0xd0a48000
snd_seq_device 6024 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xd0a1d000
snd 38436 12
snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 

Live 0xd0a55000
soundcore 6336 3 snd, Live 0xd0a00000
clip 12324 1 - Live 0xd0a18000
uhci_hcd 26064 0 - Live 0xd0a21000
ehci_hcd 18820 0 - Live 0xd09fa000
usbcore 85084 7 speedtch,lirc_atiusb,uhci_hcd,ehci_hcd, Live 0xd0a32000
isofs 28216 0 - Live 0xd0a03000
zlib_inflate 19328 1 isofs, Live 0xd09f4000
nls_cp437 5376 1 - Live 0xd0932000
vfat 11200 1 - Live 0xd08f7000
fat 35904 1 vfat, Live 0xd093d000
nls_iso8859_1 3712 2 - Live 0xd08e4000
ntfs 85420 1 - Live 0xd08fb000



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
