From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: snd-serial-u16550: oops on midi output
Date: Wed, 15 May 2002 15:09:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205152209.PAA21509@cmn29.stanford.edu>
References: <000801c1fc5b$209f2a50$ac1f830a@ico>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000801c1fc5b$209f2a50$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Using this morning's alsa cvs, 2.4.19-pre7 + low latency
patch. Loading snd-serial-u16550 works, midi input works
(through a Midiator interface), driver oops soon after sending
the first midi command out (the note-on reaches the external
synth). I have included the output of ksymoops. Let me know if
there is anything else I can do (this is on a co-worker's
laptop).

-- Fernando

May 15 14:31:54 verplankpc kernel: c89d6948
May 15 14:31:54 verplankpc kernel: *pde = 00000000
May 15 14:31:54 verplankpc kernel: Oops: 0002
May 15 14:31:54 verplankpc kernel: CPU:    0
May 15 14:31:54 verplankpc kernel: EIP:     
0010:[usbcore:usb_devfs_handle_Re9c5f87f+1568148/229126680]    Tainted: P
May 15 14:31:54 verplankpc kernel: EIP:    0010:[<c89d6948>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May 15 14:31:54 verplankpc kernel: EFLAGS: 00010086
May 15 14:31:54 verplankpc kernel: eax: 9100006f   ebx: c67a5418   ecx:  
c67a5418   edx: 00000090
May 15 14:31:54 verplankpc kernel: esi: c5957254   edi: c67a5420   ebp:  
00000246   esp: c1efbeec
May 15 14:31:54 verplankpc kernel: ds: 0018   es: 0018   ss: 0018
May 15 14:31:54 verplankpc kernel: Process pd (pid: 3697, stackpage=c1efb000)
May 15 14:31:54 verplankpc kernel: Stack: 90000246 c5957254 00000001 00000000  
c59783d4 c89d69e0 c5957254 00000001
May 15 14:31:54 verplankpc kernel:        c89afafb c5957254 00000001 00000001  
00000286 00000000 00000001 c1efa000
May 15 14:31:54 verplankpc kernel:        c59783d4 c89afc69 c5957254 bffff770  
00000000 00000000 c5957254 00000000
May 15 14:31:54 verplankpc kernel: Call Trace:  
[usbcore:usb_devfs_handle_Re9c5f87f+1568300/229126528]  
[usbcore:usb_devfs_handle_Re9c5f87f+1408839/229285989]  
[usbcore:usb_devfs_handle_Re9c5f87f+1409205/229285623] [sys_write+150/240]  
[sys_gettimeofday+27/144]
May 15 14:31:54 verplankpc kernel: Call Trace: [<c89d69e0>] [<c89afafb>]  
[<c89afc69>] [<c0134606>] [<c011aa0b>]
May 15 14:31:54 verplankpc kernel:    [<c010891b>]
May 15 14:31:54 verplankpc kernel: Code: 88 14 38 c6 44 24 02 01 81 bb 88 02  
00 00 ff 01 00 00 7f 17

>>EIP; c89d6948 <[snd-serial-u16550]snd_uart16550_output_write+138/170>    
<=====Trace; c89d69e0 <[snd-serial-u16550]snd_uart16550_output_trigger+60/70>
Trace; c89afafb <[snd-rawmidi]snd_rawmidi_kernel_write1+17b/190>
Trace; c89afc69 <[snd-rawmidi]snd_rawmidi_write+139/270>
Trace; c0134606 <sys_write+96/f0>
Trace; c011aa0b <sys_gettimeofday+1b/90>
Trace; c010891b <system_call+33/38>
Code;  c89d6948 <[snd-serial-u16550]snd_uart16550_output_write+138/170>
00000000 <_EIP>:
Code;  c89d6948 <[snd-serial-u16550]snd_uart16550_output_write+138/170>    
<=====   0:   88 14 38                  mov    %dl,(%eax,%edi,1)   <=====
Code;  c89d694b <[snd-serial-u16550]snd_uart16550_output_write+13b/170>
   3:   c6 44 24 02 01            movb   $0x1,0x2(%esp,1)
Code;  c89d6950 <[snd-serial-u16550]snd_uart16550_output_write+140/170>
   8:   81 bb 88 02 00 00 ff      cmpl   $0x1ff,0x288(%ebx)
Code;  c89d6957 <[snd-serial-u16550]snd_uart16550_output_write+147/170>
   f:   01 00 00
Code;  c89d695a <[snd-serial-u16550]snd_uart16550_output_write+14a/170>
  12:   7f 17                     jg     2b <_EIP+0x2b> c89d6973  
<[snd-serial-u16550]snd_uart16550_output_write+163/170>

This is the relevant modules.conf:

alias parport_lowlevel parport_pc
alias eth0 eepro100
alias sound-slot-0 snd-card-0
alias usb-controller usb-uhci

# --- ALSA configuration
alias char-major-116 snd
alias char-major-14 soundcore
alias snd-card-0 snd-es1968
alias snd-card-1 snd-serial-u16550
# --- OSS compatibility
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
# --- Options
options snd snd_device_gid=0 snd_device_uid=0 snd_device_mode=0666  
snd_cards_limit=2 snd_major=116
options snd-es1968 snd_id=ES1978 snd_index=0
options snd-serial-u16550 snd_index=1 snd_id="MidiatorMS124w" \
        snd_port=0x03f8 snd_irq=4 snd_adaptor=2 #snd_divisor=1 snd_ports=1
pre-install snd-serial-u16550 /bin/setserial /dev/ttyS1 uart none
# --- Keep modules from being autocleaned
add options -k snd-card-0
# --- ALSA configuration END

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
