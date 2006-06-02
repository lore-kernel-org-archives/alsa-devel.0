From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel
	82801FB/.../ = No sound (Benq 52-101)
Date: Fri, 2 Jun 2006 17:37:32 +0200
Message-ID: <8cbc3eb0a1fc3ac341bfdebdb42350e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 895DB15A
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 17:37:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134> 
======================================================================
Reported By:                liangalei
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1134
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14
======================================================================
Date Submitted:             05-28-2005 08:49 CEST
Last Modified:              06-02-2006 17:37 CEST
======================================================================
Summary:                    alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq
52-101)
Description: 
My notebook is Benq 52-101, update FC3 to kernel 2.6.11-1.14_FC3

alsamixer report: Card=intel ICH6, chip=Conexant id 3 (Question, Conexant
just support modem's AC-97 or else provide whole sound ? )

alsaconf: can find "Intel Corp 82801FB/.../ ICH6 family AC'97 Audio", and
will contine to "Have a lot fun".

I have ever, update linux kernel from 2.6.9 to 2.6.11(yum update, no
recompiling), and alsa driver from 0.9.0/1.0.8/1.0.9rc3/4.

Recomipling ALsa driver/lib/oss/tools/util.., with drive, ever try 
----- ./configure --with-cards=azx (error: no this card)
----- ./configure ; make; make install (no error report), not run
./snddevices

No sound ! So much days, so much test..... (if i915GM chipset + Conexant
chip...(see below lspci), will be powered by alsa-1.0.9rc4 ? --- if still
not, I will just wait for new alsa-driver.)

thanks
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001931 Unknown AC97 codec, digital sound works
======================================================================

----------------------------------------------------------------------
 thoroughfare - 05-25-06 23:03 
----------------------------------------------------------------------
I tried calling Conexant's US documentation line from the UK - they seemed
confused by:

1) That I'm from the UK
2) I was helping to make a Linux driver for their chip

...so I got redirected to someone (a lady, can't remember her name), and
she was out of the office so just got her voicemail.

Can someone else give it another shot?

----------------------------------------------------------------------
 kickstart - 06-02-06 17:37 
----------------------------------------------------------------------
Hi all,

I've Packard Bell A8810 running linux Slackware current, with the same
problem.

- My lspci:

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
06:01.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
06:01.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
06:01.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
06:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

- The audio codec seems to be a Conexant 20468-31 AC'97:

http://support.packardbell.com/it/item/index.php?i=spec_sound_cnx20468-31&ppn=PB30Q01306]

- Conexant info:

http://www.conexant.com/products/entry.jsp?id=24

This laptop seems quite similar to NEC Versa s940:

http://forum.hardware.fr/hardwarefr/MiniPCPortablesPDA/Topic-Unique-NEC-Versa-S940-Packard-Bell-EasyNote-A5510-A7715-sujet-17891-1.htm
http://www.nec-online.co.nz/Products/Product_Specs.asp?CID=9&RangeID=15&CatID=30&ModID=79

Since this audio codec family seems to bee supported ( see
sound/pci/ac97/ac97_codec.c ) with id = 0x43585428 Cx20468 , I've compiled
a vanilla 2.6.16.19 kernel adding my ac97_codec_id taken from:

cat /proc/asound/card0/codec97#0/ac97#0-0+regs

<snip>
0:7c = 4358
0:7e = 5431

My ID = 0x43585431 [ 0:7c + 0:7e value ]

to sound/pci/ac97/ac97_codec.c

<snip>
{ 0x43585421, 0xffffffff, "HSD11246", NULL, NULL }, // SmartMC II
{ 0x43585428, 0xfffffff8, "Cx20468",patch_conexant, NULL }, // SmartAMC
fixme: 
{ 0x43585431, 0xffffffff, "Cx20468-31",patch_conexant, NULL }, // <--
ADDED
{ 0x44543031, 0xfffffff0, "DT0398", NULL, NULL },
<snip>


Now, cat /proc/asound/cards gives:

 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with Cx20468-31 at 0xb0040800, irq 16

but STILL NO SOUND!

I'll try to contact Packard Bell trying to get some info about the codec
...


Note: Same problem on FreeBSD 6.1 and OpenBSD 3.9 !

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 08:49 liangalei      New Issue                                    
05-28-05 08:49 liangalei      Distribution              => Fedora Core 3   
05-28-05 08:49 liangalei      Kernel Version            => 2.6.11-1.14     
05-28-05 09:17 liangalei      Note Added: 0004759                          
05-28-05 09:18 liangalei      Issue Monitored: liangalei                    
05-30-05 03:29 liangalei      Note Added: 0004795                          
06-01-05 16:58 tiwai          Note Added: 0004863                          
06-01-05 17:04 tiwai          Category                 0_compilation problem_!!!
=> PCI - intel8x0
06-02-05 10:42 liangalei      Note Added: 0004875                          
06-06-05 09:53 perex          Assigned To              perex =>            
06-23-05 12:42 tiwai          Note Added: 0005182                          
06-24-05 03:12 liangalei      File Added: asound.state                     
06-24-05 03:13 liangalei      File Added: ac97#0-0                         
06-24-05 03:14 liangalei      File Added: ac97#0-0+regs                    
06-24-05 03:18 liangalei      Note Added: 0005202                          
08-28-05 15:28 ybar           Note Added: 0005962                          
11-29-05 05:59 derek          Issue Monitored: derek                       
11-29-05 06:00 derek          Issue End Monitor: derek                     
11-29-05 06:03 derek          Note Added: 0006870                          
02-07-06 10:03 anhi1968       Issue Monitored: anhi1968                    
02-17-06 22:22 gandhi         Note Added: 0008110                          
02-17-06 23:26 gandhi         Issue Monitored: gandhi                      
02-17-06 23:28 gandhi         Note Edited: 0008110                         
02-17-06 23:43 gandhi         Note Edited: 0008110                         
02-18-06 02:05 gandhi         Note Added: 0008112                          
02-18-06 08:13 liangalei      Note Added: 0008116                          
02-18-06 15:56 gandhi         Issue Monitored: tiwai                       
02-18-06 15:56 gandhi         Note Added: 0008120                          
02-28-06 12:02 anhi1968       Issue End Monitor: anhi1968                    
03-03-06 08:29 robitech       Note Added: 0008336                          
03-15-06 05:34 JProgrammer    Note Added: 0008526                          
03-15-06 05:37 JProgrammer    Issue Monitored: JProgrammer                    
03-15-06 06:39 Kooper         Note Added: 0008527                          
03-15-06 11:40 tiwai          Note Added: 0008531                          
03-15-06 11:53 Kooper         Note Added: 0008535                          
03-15-06 12:13 JProgrammer    Note Added: 0008538                          
03-15-06 12:18 tiwai          Note Added: 0008540                          
03-15-06 23:48 JProgrammer    Note Added: 0008579                          
03-16-06 15:04 tiwai          Note Added: 0008606                          
03-16-06 15:05 tiwai          File Added: ac97-remove-modem.diff                
   
03-16-06 19:34 rlrevell       Relationship added       has duplicate 0001931
03-17-06 04:10 Kooper         Note Added: 0008633                          
03-17-06 12:07 tiwai          Note Added: 0008641                          
03-17-06 12:32 Kooper         File Added: kooper-alsa-bugreport.tgz             
      
03-17-06 12:35 Kooper         Note Added: 0008644                          
03-21-06 02:38 JProgrammer    Note Added: 0008736                          
03-25-06 10:51 alessiodf      Note Added: 0008944                          
03-26-06 20:12 alessiodf      Note Edited: 0008944                         
03-26-06 20:15 alessiodf      Note Edited: 0008944                         
03-30-06 15:47 trava          Note Added: 0009034                          
04-07-06 13:05 kesiev         Note Added: 0009137                          
04-07-06 13:06 kesiev         Note Edited: 0009137                         
04-09-06 03:23 alt_ackbar     Note Added: 0009177                          
04-11-06 11:34 kesiev         Issue Monitored: kesiev                      
04-11-06 11:39 kesiev         Issue End Monitor: kesiev                    
04-12-06 16:21 kesiev         Note Added: 0009246                          
04-12-06 16:21 kesiev         File Added: qta058Ba.inf                     
04-13-06 14:00 kesiev         Note Added: 0009259                          
04-13-06 14:00 kesiev         File Added: windows-details.txt                   

04-13-06 14:54 kesiev         Note Edited: 0009259                         
04-13-06 15:34 kesiev         Issue Monitored: kesiev                      
04-15-06 12:33 kesiev         Note Edited: 0009259                         
04-15-06 12:33 kesiev         File Added: alsasound.conf                    
04-18-06 09:35 fedukoff       Note Added: 0009326                          
05-01-06 20:24 rawsock        Issue Monitored: rawsock                     
05-03-06 15:55 fedukoff       Issue Monitored: fedukoff                    
05-09-06 14:36 drseergio      Note Added: 0009658                          
05-09-06 16:40 rlrevell       Note Added: 0009661                          
05-09-06 17:16 drseergio      Note Added: 0009662                          
05-09-06 17:19 drseergio      Note Edited: 0009662                         
05-09-06 17:28 rlrevell       Note Added: 0009664                          
05-09-06 17:31 drseergio      Note Edited: 0009662                         
05-09-06 17:32 drseergio      Note Added: 0009665                          
05-09-06 17:41 drseergio      Note Edited: 0009665                         
05-09-06 17:49 rlrevell       Note Added: 0009667                          
05-09-06 17:52 drseergio      Note Added: 0009668                          
05-09-06 17:57 rlrevell       Note Added: 0009669                          
05-09-06 18:00 drseergio      Note Added: 0009670                          
05-09-06 18:33 fedukoff       Note Added: 0009672                          
05-09-06 18:44 drseergio      Note Added: 0009673                          
05-09-06 19:11 fedukoff       Note Added: 0009674                          
05-09-06 19:12 rlrevell       Note Added: 0009675                          
05-09-06 19:21 drseergio      Note Added: 0009676                          
05-09-06 19:27 fedukoff       Note Added: 0009677                          
05-09-06 19:28 rlrevell       Note Added: 0009678                          
05-09-06 19:30 drseergio      Note Added: 0009679                          
05-09-06 19:39 fedukoff       Note Added: 0009680                          
05-09-06 19:42 rlrevell       Note Added: 0009681                          
05-09-06 19:50 drseergio      Note Added: 0009682                          
05-09-06 20:16 fedukoff       Note Added: 0009683                          
05-09-06 20:17 rlrevell       Note Added: 0009684                          
05-09-06 20:19 rlrevell       Note Added: 0009685                          
05-09-06 20:28 drseergio      Note Added: 0009686                          
05-09-06 20:29 fedukoff       Note Added: 0009687                          
05-09-06 20:34 rlrevell       Note Added: 0009688                          
05-09-06 22:07 fedukoff       Note Added: 0009691                          
05-10-06 15:58 fedukoff       Note Added: 0009719                          
05-10-06 17:10 rlrevell       Note Added: 0009735                          
05-10-06 17:19 kesiev         Note Added: 0009738                          
05-10-06 17:21 trava          Note Added: 0009740                          
05-10-06 17:25 trava          Note Added: 0009741                          
05-10-06 17:41 fedukoff       Note Added: 0009743                          
05-10-06 18:03 fedukoff       Note Added: 0009745                          
05-10-06 18:20 trava          Note Added: 0009746                          
05-10-06 18:34 fedukoff       Note Added: 0009748                          
05-11-06 08:15 fedukoff       Note Added: 0009759                          
05-11-06 08:42 JProgrammer    Note Added: 0009760                          
05-11-06 08:45 fedukoff       Note Added: 0009761                          
05-11-06 18:25 fedukoff       Note Added: 0009764                          
05-12-06 08:13 fedukoff       Note Added: 0009773                          
05-12-06 08:14 fedukoff       Note Edited: 0009773                         
05-15-06 14:15 fedukoff       Note Added: 0009822                          
05-15-06 14:49 rlrevell       Note Added: 0009824                          
05-15-06 14:57 fedukoff       Note Added: 0009825                          
05-15-06 15:25 rlrevell       Note Added: 0009826                          
05-18-06 12:45 fedukoff       Note Added: 0009866                          
05-18-06 13:37 fedukoff       Note Added: 0009867                          
05-18-06 13:48 fedukoff       Note Deleted: 0009822                        
05-19-06 08:07 fedukoff       Note Added: 0009873                          
05-25-06 23:03 thoroughfare   Note Added: 0009969                          
06-02-06 17:37 kickstart      Note Added: 0010049                          
======================================================================
