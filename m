From: Luke Ross <luke@lukeross.name>
Subject: Re: "Unable to handle kernel paging request"
	panic	in	snd-usb-audio on x86_64
Date: Wed, 4 Oct 2006 21:13:41 +0100
Message-ID: <20061004201341.GA6195@lukeross.name>
References: <20060920225128.GG19215@lukeross.name>
	<s5hvenhcb8v.wl%tiwai@suse.de>
	<20060922104850.GA20850@lukeross.name>
	<s5hodt3j4fm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodt3j4fm.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Sep 25, 2006 at 06:29:01PM +0200, Takashi Iwai wrote:
> > On Thu, Sep 21, 2006 at 08:42:24PM +0200, Takashi Iwai wrote:
> > > At Wed, 20 Sep 2006 23:51:28 +0100,
> > > Luke Ross wrote:
> > > > 
> > > > Last month I submitted a patch adding support for non-standard sample 
> > > > rates to the snd-usb-audio driver [1], which was added to the ALSA GIT 
> > > > tree.
> > > > 
> > > > This works fine with 2.6.16 on i386 on one of my machines, but causes a 
> > > > kernel panic on opening the sound device on my other machine (dual AMD 
> > > > Opterton with x86_64 kernel).
> > > 
> > > Try to build with debug option.  Maybe it comes from OSS emulation?
> > > 
> > > Or are you using dmix?
> > 
> > At the moment I'm using neither. I'm using an alsa-enabled mpg123:
> > 
> > mpg123 -a hw:1,0 sound.mp3

Here's the panic log, in the hope it makes things clearer.

Cheers,

Luke

Fedora Core release 5 (Bordeaux)
Kernel 2.6.17-1.2187_FC5 on an x86_64

hintertux login: Unable to handle kernel paging request at 0000000067f53f32 RIP: 
<ffffffff881514a8>{:snd_pcm:snd_interval_list+91}
PGD 3d184067 PUD 0 
Oops: 0000 [1] SMP 
last sysfs file: /devices/pci0000:00/0000:00:07.3/i2c-0/0-002e/fan4_min
CPU 1 
Modules linked in: ipv6 autofs4 w83627hf eeprom lm75 lm85 hwmon_vid hwmon i2c_isa hidp l2cap bluetooth ipt_REJECT xt_tcpudp xt_state ip_conntrack nfnetlink iptable_filter ip_tables x_tables dm_mirror dm_multipath dm_mod video button battery acpi_memhotplug ac lp parport_pc parport usb_storage snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq ohci1394 snd_seq_device ieee1394 snd_pcm_oss snd_mixer_oss ohci_hcd sg tg3 snd_pcm snd_timer snd soundcore snd_page_alloc hw_random i2c_amd8111 i2c_amd756 serio_raw i2c_core raid1 ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 3027, comm: mpg123 Not tainted 2.6.17-1.2187_FC5 #1
RIP: 0010:[<ffffffff881514a8>] <ffffffff881514a8>{:snd_pcm:snd_interval_list+91}
RSP: 0018:ffff810020389b50  EFLAGS: 00010206
RAX: 0000000037f8096b RBX: ffff810037f80c00 RCX: 0000000037f8096b
RDX: ffffffff88151986 RSI: 0000000037f80978 RDI: ffff810037f80d28
RBP: ffff810020389cb8 R08: 0000000000000fa0 R09: 0000000000000001
R10: ffff810020389cb3 R11: 00000000ffffffff R12: ffff810038a86450
R13: 0000000000000017 R14: 0000000000000019 R15: 0000000000000017
FS:  00002aaaaaae1380(0000) GS:ffff810037e91640(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000067f53f32 CR3: 000000002006d000 CR4: 00000000000006e0
Process mpg123 (pid: 3027, threadinfo ffff810020388000, task ffff810020353860)
Stack: ffffffff8814f43b ffff81001d15a960 0000000300000002 0000000500000004 
       0000000700000006 0000000900000008 0000000b0000000a 0000000d0000000c 
       0000000f0000000e 0000001100000010 
Call Trace: <ffffffff8814f43b>{:snd_pcm:snd_pcm_hw_refine+658}
       <ffffffff8814fb4a>{:snd_pcm:snd_pcm_common_ioctl1+447}
       <ffffffff88154338>{:snd_pcm:snd_pcm_hw_constraint_list+31}
       <ffffffff883246fe>{:snd_usb_audio:snd_usb_pcm_open+976}
       <ffffffff88151986>{:snd_pcm:snd_pcm_hw_constraint_minmax+39}
       <ffffffff80269d1c>{_read_unlock_irq+9} <ffffffff802075ed>{find_get_page+71}
       <ffffffff80213e89>{filemap_nopage+390} <ffffffff802089be>{__handle_mm_fault+1303}
       <ffffffff80269d8e>{_spin_lock_irqsave+9} <ffffffff80222cba>{__up_read+25}
       <ffffffff88150b93>{:snd_pcm:snd_pcm_playback_ioctl1+569}
       <ffffffff8020dd02>{do_mmap_pgoff+1543} <ffffffff881513e9>{:snd_pcm:snd_pcm_playback_ioctl+38}
       <ffffffff80244ada>{do_ioctl+33} <ffffffff80231e88>{vfs_ioctl+598}
       <ffffffff8024fb4d>{sys_ioctl+89} <ffffffff80262b41>{tracesys+209}

Code: 8b 04 82 39 47 04 75 08 f6 47 08 02 75 04 eb 18 77 09 ff c9 
RIP <ffffffff881514a8>{:snd_pcm:snd_interval_list+91} RSP <ffff810020389b50>
CR2: 0000000067f53f32
 <0>Kernel panic - not syncing: Oops
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
