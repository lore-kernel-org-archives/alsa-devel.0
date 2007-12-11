From: alsa-devel.20.pris@spamgourmet.com
Subject: Re: Sound problems in PCCHIPS A13G+
Date: Tue, 11 Dec 2007 16:57:48 -0200
Message-ID: <74eb4bb50712111057r36552f56g445b4491ffcefdca@mail.gmail.com>
References: <74eb4bb50711111839x335ba3c8u8185bf66dcedb00f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gourmet.spamgourmet.com (gourmet.spamgourmet.com
	[216.75.35.164])
	by alsa0.perex.cz (Postfix) with ESMTP id B1CCD103819
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 20:18:03 +0100 (CET)
Received: from gourmet.spamgourmet.com (localhost.localdomain [127.0.0.1])
	by gourmet.spamgourmet.com (8.13.8/8.13.7) with ESMTP id lBBJI15c015750
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 19:18:01 GMT
Received: (from jqh1@localhost)
	by gourmet.spamgourmet.com (8.13.8/8.13.8/Submit) id lBBJHxkJ015650
	for alsa-devel@alsa-project.org; Tue, 11 Dec 2007 19:17:59 GMT
In-Reply-To: <74eb4bb50711111839x335ba3c8u8185bf66dcedb00f@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok folks,

I have tried the following approaches without much success:
installing the latest ALSA driver from the repositories(this was
alsa-driver-hg20071129
at the time I did it.)

Then I uninstalled ALSA and installed the latest OSS driver. This
helped a bit and the sound was better, but still not perfect, I still
have problems with some AVI files.
So the last thing I'm trying now is installing the Realtek audio codecs:

http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=24&PFid=24&Level=4&Conn=3&DownTypeID=3&GetDown=false#High%20Definition%20Audio%20Codecs

So I downloaded it and followed the instructions. I managed to
successfully compile this driver but then when I run alsamixer I get
the following error message:

alsamixer: function snd_ctl_open failed for default: No such device

I read somewhere that this is due to some OSS modules still being
loaded and that I have to remove those OSS modules. So how do I do
that?

Thanks for any help!
If you need more information just ask.

Roland

> My motherboard: PCCHIPS A13G+
> http://www.pcchips.com.tw/PCCWebSite...uID=44&LanID=0
>
> I'm using Ubuntu 7.10 - the Gutsy Gibbon, I was using Feisty before
> and had the same problems.
>
> The interesting thing: the system sounds all work. Some example .ogg
> files that came with Ubuntu also work.
> There is one example file however "fables_01_01_aesop.spx" which only
> gives a very low sound, almost inaudible.
> The real strange thing happens with ".avi" and mp3 files. They sound
> distorted and very low, almost inaudible. Some have better/louder
> sound, but still distorted, but I can understand what is being spoken,
> others not.
>
> Thanks for any help!
> If you need more information just ask.
>
> Technical details follow(including the Alsa Audio Debug):
>
>
>
> The sound hardware of my Mobo is in the NVIDIA MCP61S Single chipset.
> This chipset consists of: GeForce(R) 6100 GPU and MCP nForce(R) 405
>
> codec(less /proc/asound/card0/codec#0):
> Codec: Realtek ALC660-VD
> Address: 0
> Vendor Id: 0x10ec0660
> Subsystem Id: 0x1019c601
> Revision Id: 0x100001
>
>
> The aplay command lists another codec: ALC861VD
>
>  aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC861VD Analog [ALC861VD Analog]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
>
> Here is the Alsa Audio Debug:
>
> ALSA Audio Debug v0.1.0 - Mon Nov 12 00:00:12 BRST 2007
> http://alsa.opensrc.org/aadebug
> http://www.gnu.org/licenses/gpl.txt
>
> Kernel ----------------------------------------------------
> Linux 2.6.22-14-generic #1 SMP Sun Oct 14 23:05:12 GMT 2007 i686 GNU/Linux
>
> Loaded Modules --------------------------------------------
> snd_hda_intel         263712  4
> snd_pcm_oss            44672  0
> snd_mixer_oss          17664  1 snd_pcm_oss
> snd_pcm                80388  3 snd_hda_intel,snd_pcm_oss
> snd_seq_dummy           4740  0
> snd_seq_oss            33152  0
> snd_seq_midi            9600  0
> snd_rawmidi            25728  1 snd_seq_midi
> snd_seq_midi_event      8448  2 snd_seq_oss,snd_seq_midi
> snd_seq                53232  6
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
> snd_timer              24324  3 snd_pcm,snd_seq
> snd_seq_device          9228  5
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
> snd                    54660  15
> snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> snd_page_alloc         11400  2 snd_hda_intel,snd_pcm
>
> Modprobe Conf ---------------------------------------------
> Warning: module config file does not exist
> This means any kernel modules will not be auto loaded
> See your linux distro docs on how to create this file
>
> Proc Asound -----------------------------------------------
> Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31
> 09:03:25 2007 UTC).
>  0 [NVidia         ]: HDA-Intel - HDA NVidia
>                       HDA NVidia at 0xfe028000 irq 16
>   2:        : timer
>   3:        : sequencer
>   4: [ 0- 0]: digital audio playback
>   5: [ 0- 0]: digital audio capture
>   6: [ 0]   : control
> cat: /proc/asound/hwdep: No such file or directory
> 00-00: ALC861VD Analog : ALC861VD Analog : playback 1 : capture 2
> Client info
>   cur  clients : 3
>   peak clients : 3
>   max  clients : 192
>
> Client   0 : "System" [Kernel]
>   Port   0 : "Timer" (Rwe-)
>   Port   1 : "Announce" (R-e-)
>     Connecting To: 15:0
> Client  14 : "Midi Through" [Kernel]
>   Port   0 : "Midi Through Port-0" (RWe-)
> Client  15 : "OSS sequencer" [Kernel]
>   Port   0 : "Receiver" (-we-)
>     Connected From: 0:1
>
> Dev Snd ---------------------------------------------------
> controlC0  pcmC0D0c  pcmC0D0p  seq  timer
>
> CPU -------------------------------------------------------
> model name      : AMD Processor model unknown
> cpu MHz         : 1900.000
>
> RAM -------------------------------------------------------
> MemTotal:       969524 kB
> SwapTotal:     1951888 kB
>
> Hardware --------------------------------------------------
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control
