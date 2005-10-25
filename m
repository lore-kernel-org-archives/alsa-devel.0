From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Tue, 25 Oct 2005 13:55:59 +0200
Message-ID: <7f2c7449dac94557e6b27e57508bc6f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6782812E
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 13:55:59 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023> 
======================================================================
Reported By:                yafrank
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1023
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.8_FC3
======================================================================
Date Submitted:             03-30-2005 14:25 CEST
Last Modified:              10-25-2005 13:55 CEST
======================================================================
Summary:                    ens1371 pcm not work in 2.6.11 kernel
Description: 
I'm using FC3 and my Creative SB AudioPCI 64V sound card works fine in 
2.6.10-1.770_FC3 kernel. After I replaced the kernel to 2.6.11 from
kernel.org or 2.6.11-1.8_FC3 from redhat, there is no sound anymore. I
noticed that the 2.6.11 kernel uses alsa 1.0.8 driver, yet userspace
alsa-lib and utility in fc3 are 1.0.6. So I upgrade them to 1.0.8 too.
Still, there is no sound and alsamixer doesn't show any pcm option.
Fortunately, the 1.0.8 lib and utility backward compatible with 1.0.6
driver in 2.6.10 kernel, so they were kept. The sound card uses ens1371
kernel module. And my /etc/modprobe.conf is this:

alias snd-card-0 snd-ens1371
alias sound-slot-0 snd-ens1371
install snd-ens1371 /sbin/modprobe --ignore-install snd-ens1371 &&
/usr/sbin/alsactlrestore >/dev/null 2>&1 || :
remove snd-ens1371 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-ens1371
alias usb-controller uhci-hcd
alias net-pf-10 off
alias ipv6 off
alias eth0 8139too


======================================================================

----------------------------------------------------------------------
 bobcat98 - 09-04-05 02:09 
----------------------------------------------------------------------
Hello--

Reading with interest because I just started using FC4 and cannot get
sound to
work either.  My experience level:  Compiled some programs, never rolled
my own
kernel, infrequent unix user since '92, avid computer enthusiast and
professional, but not a software engineer.

I pasted in some of the info from my system.  

I don't have a problem with alsamixer not showing the PCM controls, in
fact I
have a "PCM Out" control and some 3D controls too.  It must be *very*
close to
working, because I can hear background hiss that is affected by the master
and
PCM sliders.  I cannot use the gnome desktop preferences->sound to play 
anything, nor does aplay.  I haven't tried any other multimedia apps.

This setup works in Winduhs 98SE, and I've noticed some possible
differences in
how anaconda set up this card--
Winduhs identifies it as a SB AudioPCI 128 Legacy
at port 220
using irq 7
dma 1, 7

Some system info:


[bob@micron grub]$ cat /proc/asound/cards
0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0xe800, irq 9
[bob@micron grub]$ su
Password:
su: incorrect password
[bob@micron grub]$ su
Password:
[root@micron grub]#  lspci -vvv | grep "audio" -A8
bash: lspci: command not found
[root@micron grub]# /sbin/lspci -vvv | grep "audio" -A8
00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
08)
        Subsystem: Micron Tazer
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)


[bob@micron grub]$ rpm -qa | grep alsa
alsa-utils-1.0.9rc2-2
alsa-lib-1.0.9rc4-2
alsa-lib-devel-1.0.9rc4-2
[bob@micron grub]$ uname -r
2.6.11-1.1369_FC4
[bob@micron grub]$

[bob@micron grub]$ cat /proc/asound/cards
0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0xe800, irq 9
[bob@micron grub]$ cat /proc/irq/7
cat: /proc/irq/7: Is a directory

(See, I'm a rookie)


[bob@micron grub]$ ls /proc/irq/7
[bob@micron grub]$ ls /proc/irq/9
Ensoniq AudioPCI

[bob@micron grub]$ /sbin/lsmod | grep snd
snd_ens1371            31649  1
gameport               18633  1 snd_ens1371
snd_rawmidi            30305  1 snd_ens1371
snd_ac97_codec         75961  1 snd_ens1371
snd_seq_dummy           3653  0
snd_seq_oss            37057  0
snd_seq_midi_event      9153  1 snd_seq_oss
snd_seq                62289  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8781  4
snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            51185  0
snd_mixer_oss          17857  1 snd_pcm_oss
snd_pcm               100169  3 snd_ens1371,snd_ac97_codec,snd_pcm_oss
snd_timer              33605  2 snd_seq,snd_pcm
snd                    57157  12
snd_ens1371,snd_rawmidi,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10913  1 snd
snd_page_alloc          9669  1 snd_pcm

----------------------------------------------------------------------
 rufusplant - 10-25-05 13:55 
----------------------------------------------------------------------
Like mmadore, I am running a Creative Vibra 128 (model CT4730) that has an
EV1938 chip.

I can verify the same problem with recent Linux distributions based on
2.6.11 and later kernels.  For example, sound worked ok with FC2 and
Ubuntu 5.04, but now does not work with FC4 and Ubuntu 5.10.

I currently have a dual-boot Ubuntu 5.04 (kernel 2.6.10 alsa 1.0.8) and
Ubuntu 5.10 (kernel 2.6.12 alsa 1.0.9) system, so I can perform tests to
compare the two.  Just let me know what I can do to help.  It would be
nice to get this working again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 14:25 yafrank        New Issue                                    
03-30-05 14:25 yafrank        Distribution              => Fedora Core 3   
03-30-05 14:25 yafrank        Kernel Version            => 2.6.11-1.8_FC3  
03-30-05 18:08 tiwai          Note Added: 0004266                          
03-31-05 10:49 yafrank        Note Added: 0004277                          
03-31-05 13:14 yafrank        Note Added: 0004279                          
03-31-05 13:23 perex          Note Added: 0004280                          
03-31-05 17:08 yafrank        Note Added: 0004282                          
04-06-05 18:41 mmadore        Note Added: 0004350                          
04-07-05 16:04 tiwai          Note Added: 0004357                          
04-07-05 18:32 mmadore        Note Added: 0004362                          
04-07-05 18:33 mmadore        File Added: asound.state                     
04-07-05 18:37 mmadore        File Added: ac97#0-0                         
04-07-05 18:38 mmadore        File Added: ac97#0-0+regs                    
04-12-05 05:47 yafrank        Issue Monitored: yafrank                     
04-12-05 06:02 yafrank        Note Added: 0004445                          
04-12-05 16:29 tiwai          Note Added: 0004447                          
04-12-05 19:46 yafrank        Note Added: 0004459                          
04-12-05 20:00 yafrank        Note Added: 0004460                          
04-12-05 21:11 mmadore        Note Added: 0004463                          
04-12-05 21:12 mmadore        File Added: asound.state.new                    
04-24-05 00:15 mycroft        Issue Monitored: mycroft                     
06-17-05 09:55 yafrank        Note Added: 0005065                          
06-17-05 11:45 yafrank        Note Added: 0005067                          
06-17-05 14:44 tiwai          Note Added: 0005073                          
06-18-05 04:26 yafrank        Note Added: 0005082                          
06-18-05 04:52 yafrank        File Added: alsa-ac97-test                    
06-18-05 05:19 yafrank        Note Added: 0005083                          
06-20-05 10:59 perex          File Added: ens1371-reset.patch                   

06-20-05 10:59 perex          Category                 CORE - pcm => PCI -
ens1371
06-20-05 11:00 perex          Note Added: 0005095                          
06-20-05 11:01 perex          Status                   new => assigned     
06-20-05 11:01 perex          Assigned To               => perex           
06-23-05 16:48 yafrank        Note Added: 0005191                          
07-08-05 10:24 perex          Note Added: 0005405                          
07-08-05 10:25 perex          Note Edited: 0005405                         
07-11-05 13:45 yafrank        Note Added: 0005444                          
07-11-05 16:47 yafrank        Note Added: 0005449                          
07-11-05 22:52 gwennou        Note Added: 0005451                          
09-01-05 10:25 yafrank        File Added: config-2.6.13-snd                    
09-01-05 10:51 yafrank        Note Added: 0005995                          
09-01-05 18:15 tiwai          Note Added: 0005997                          
09-04-05 02:09 bobcat98       Note Added: 0006034                          
09-04-05 02:12 bobcat98       Issue Monitored: bobcat98                    
10-25-05 13:55 rufusplant     Note Added: 0006539                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
