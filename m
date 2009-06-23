From: Dmitri Seletski <drjoms@gmail.com>
Subject: Nmode issues
Date: Tue, 23 Jun 2009 01:14:00 +0100
Message-ID: <4A401E48.6070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id C7A0324364
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 02:14:14 +0200 (CEST)
Received: by ewy21 with SMTP id 21so4429149ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 17:14:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Guys.

I got upgraded my kernel to

uname -a
Linux dimko 2.6.30 #3 SMP PREEMPT Mon Jun 22 23:58:16 IST 2009 x86_64
AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ AuthenticAMD GNU/Linux

i was able to make files now!(previously i couldnt)

make
make install
modprobe ath9k


[  941.365887] f71882fg: Not a Fintek device
[  941.365932] f71882fg: Found f71882fg chip at 0xa00, revision 32
[  941.366116] f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode
[  941.366118] f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode
[  941.366119] f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode
[  941.366121] f71882fg f71882fg.2560: Fan: 4 is in duty-cycle mode
[  941.377478] k8temp 0000:00:18.3: Temperature readouts might be wrong
- check erratum #141
[  956.642074] IRQ 19/nvidia: IRQF_DISABLED is not guaranteed on shared IRQs
[  957.433234] IRQ 19/nvidia: IRQF_DISABLED is not guaranteed on shared IRQs
[ 1415.180230] AV200 0000:09:04.0: PCI INT A -> Link[LN4A] -> GSI 16
(level, low) -> IRQ 16
[ 1509.674361] cfg80211: Calling CRDA to update world regulatory domain
[ 1509.674399] general protection fault: 0000 [#1] PREEMPT SMP
[ 1509.674411] last sysfs file:
/sys/devices/pci0000:00/0000:00:04.1/usb2/2-1/2-1:1.0/host8/target8:0:0/8:0:0:0/block/sdd/sdd1/stat
[ 1509.674418] CPU 1
[ 1509.674422] Modules linked in: cfg80211 rfkill_backport snd_seq
snd_virtuoso snd_oxygen_lib snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore k8temp f71882fg
hwmon i2c_dev nvidia(P) i2c_core
[ 1509.674464] Pid: 29571, comm: modprobe Tainted: P           2.6.30 #3
MS-7375
[ 1509.674470] RIP: 0010:[<ffffffff810710f1>]  [<ffffffff810710f1>]
module_put+0x31/0x80
[ 1509.674488] RSP: 0018:ffff880119cebf38  EFLAGS: 00010287
[ 1509.674493] RAX: 0000000000000001 RBX: ffffffffa0886d00 RCX:
0000000000000000
[ 1509.674498] RDX: ffff10013a92b6c0 RSI: 0000000000000000 RDI:
0000000000000001
[ 1509.674503] RBP: ffff880119cebf48 R08: 0000000000000000 R09:
0000000000000000
[ 1509.674508] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[ 1509.674513] R13: 00007f4dae114010 R14: 00000000006da7f0 R15:
00000000006da808
[ 1509.674519] FS:  00007f4dae1766f0(0000) GS:ffff88002803b000(0000)
knlGS:0000000000000000
[ 1509.674524] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1509.674529] CR2: 00007fb3a126d098 CR3: 000000010f527000 CR4:
00000000000006e0
[ 1509.674534] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1509.674539] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[ 1509.674545] Process modprobe (pid: 29571, threadinfo
ffff880119cea000, task ffff880119d0c380)
[ 1509.674549] Stack:
[ 1509.674552]  ffffffffa0886d00 ffffffffa0886d00 ffff880119cebf78
ffffffff810730ce
[ 1509.674560]  0000000000000000 00000000006da680 0000000000000000
00000000006da6e0
[ 1509.674569]  00000000006da680 ffffffff8100beeb 0000000000000246
00000000006da6c0
[ 1509.674578] Call Trace:
[ 1509.674583]  [<ffffffff810730ce>] sys_init_module+0x10e/0x200
[ 1509.674592]  [<ffffffff8100beeb>] system_call_fastpath+0x16/0x1b
[ 1509.674604] Code: 89 fb 48 83 ec 08 48 85 ff 74 44 bf 01 00 00 00 e8
25 d5 fc ff e8 d0 48 15 00 48 98 48 8b 93 f0 01 00 00 48 03 14 c5 20 70
67 81 <48> ff 0a 83 3b 02 74 23 bf 01 00 00 00 e8 6d d4 fc ff 65 48 8b
[ 1509.674680] RIP  [<ffffffff810710f1>] module_put+0x31/0x80
[ 1509.674689]  RSP <ffff880119cebf38>
[ 1509.674695] ---[ end trace 6aaa73f49bc73faf ]---
[ 1509.674701] note: modprobe[29571] exited with preempt_count 1


after i tried to unload drivers(dont remember nvidia ones or ath9k ones)
machine became unresponsive, i had to raise elephants. after which new
kernel did not reboot properly. recompiled, it from working kernel,
relaoded machine, everything seesm to be working now
however, i still get same issue.
pwd
/home/dimko/compat-wireless-2009-06-20

tcp  dump -i wlan0 [start]

ip link set wlan0 start
iwconfig wlan0 essid dlink

dmesg
  761.433090] wlan0: authenticated
[  761.433094] wlan0: associate with AP 00:1e:58:b4:f6:83
[  761.633264] wlan0: associate with AP 00:1e:58:b4:f6:83
[  761.640078] wlan0: deauthenticated (Reason: 9)
[  762.640264] wlan0: direct probe to AP 00:1e:58:b4:f6:83 try 1
[  762.643782] wlan0 direct probe responded
[  762.643787] wlan0: authenticate with AP 00:1e:58:b4:f6:83
[  762.648350] wlan0: authenticated
[  762.648354] wlan0: associate with AP 00:1e:58:b4:f6:83
[  762.848263] wlan0: associate with AP 00:1e:58:b4:f6:83
[  762.855024] wlan0: deauthenticated (Reason: 9)

i

tcpdum [stop]

tcpdump -i wlan0
tcpdump: WARNING: wlan0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on wlan0, link-type EN10MB (Ethernet), capture size 96 bytes
^C
0 packets captured
0 packets received by filter
0 packets dropped by kernel

Same problem persist...

pstree -p
init(1)-+-acpid(4077)
        |-agetty(4579)
        |-agetty(4580)
        |-agetty(4581)
        |-agetty(4582)
        |-bonobo-activati(5073)---{bonobo-activati}(5074)
        |-console-kit-dae(4607)-+-{console-kit-dae}(4611)
        |                       |-{console-kit-dae}(4615)
        |                       |-{console-kit-dae}(4616)
        |                       |-{console-kit-dae}(4617)
        |                       |-{console-kit-dae}(4618)
        |                       |-{console-kit-dae}(4620)
        |                       |-{console-kit-dae}(4621)
        |                       |-{console-kit-dae}(4622)
        |                       |-{console-kit-dae}(4623)
        |                       |-{console-kit-dae}(4624)
        |                       |-{console-kit-dae}(4625)
        |                       |-{console-kit-dae}(4626)
        |                       |-{console-kit-dae}(4627)
        |                       |-{console-kit-dae}(4628)
        |                       |-{console-kit-dae}(4629)
        |                       |-{console-kit-dae}(4630)
        |                       |-{console-kit-dae}(4631)
        |                       |-{console-kit-dae}(4632)
        |                       |-{console-kit-dae}(4633)
        |                       |-{console-kit-dae}(4634)
        |                       |-{console-kit-dae}(4635)
        |                       |-{console-kit-dae}(4636)
        |                       |-{console-kit-dae}(4637)
        |                       |-{console-kit-dae}(4638)
        |                       |-{console-kit-dae}(4639)
        |                       |-{console-kit-dae}(4640)
        |                       |-{console-kit-dae}(4641)
        |                       |-{console-kit-dae}(4642)
        |                       |-{console-kit-dae}(4643)
        |                       |-{console-kit-dae}(4644)
        |                       |-{console-kit-dae}(4645)
        |                       |-{console-kit-dae}(4646)
        |                       |-{console-kit-dae}(4647)
        |                       |-{console-kit-dae}(4648)
        |                       |-{console-kit-dae}(4649)
        |                       |-{console-kit-dae}(4650)
        |                       |-{console-kit-dae}(4651)
        |                       |-{console-kit-dae}(4652)
        |                       |-{console-kit-dae}(4653)
        |                       |-{console-kit-dae}(4654)
        |                       |-{console-kit-dae}(4655)
        |                       |-{console-kit-dae}(4656)
        |                       |-{console-kit-dae}(4657)
        |                       |-{console-kit-dae}(4658)
        |                       |-{console-kit-dae}(4659)
        |                       |-{console-kit-dae}(4660)
        |                       |-{console-kit-dae}(4661)
        |                       |-{console-kit-dae}(4662)
        |                       |-{console-kit-dae}(4663)
        |                       |-{console-kit-dae}(4664)
        |                       |-{console-kit-dae}(4665)
        |                       |-{console-kit-dae}(4666)
        |                       |-{console-kit-dae}(4667)
        |                       |-{console-kit-dae}(4668)
        |                       |-{console-kit-dae}(4669)
        |                       |-{console-kit-dae}(4670)
        |                       |-{console-kit-dae}(4671)
        |                       |-{console-kit-dae}(4672)
        |                       |-{console-kit-dae}(4673)
        |                       |-{console-kit-dae}(4877)
        |                       |-{console-kit-dae}(4926)
        |                       `-{console-kit-dae}(4983)
        |-dbus-daemon(4233)
        |-dbus-daemon(5021)
        |-dbus-launch(5020)
        |-dhcpcd(3192)
        |-exaile(5149)
        |-gconfd-2(5027)
        |-gdm(4979)---gdm(4980)-+-X(4982)
        |                       `-gnome-session(5005)-+-gnome-panel(5070)
        |                                             |-metacity(5066)
        |                                             |-nautilus(5077)
        |                                             |-seahorse-agent(5035)
        |                                             |-ssh-agent(5025)
        |                                             |-vino-server(5084)
        |                                            
`-{gnome-session}(5047)
        |-gnome-dictionar(5098)
        |-gnome-keyring-d(5044)
        |-gnome-power-man(5103)
        |-gnome-screensav(5065)
        |-gnome-settings-(5048)---{gnome-settings-}(5052)
        |-gnome-terminal(5163)-+-bash(5166)---su(5172)---bash(5175)
        |                     
|-bash(5218)---su(5223)---bash(5226)---pstree(52+
        |                      |-gnome-pty-helpe(5165)
        |                      `-{gnome-terminal}(5168)
        |-gnome-volume-ma(5104)
        |-gvfs-hal-volume(5102)
        |-gvfsd(5037)
        |-gvfsd-burn(5119)
        |-gvfsd-trash(5107)
        |-hald(4292)---hald-runner(4293)-+-hald-addon-acpi(4307)
        |                                |-hald-addon-cpuf(4306)
        |                                |-hald-addon-inpu(4298)
        |                                `-hald-addon-stor(4317)
        |-login(4577)---bash(4878)
        |-login(4578)---bash(4921)
        |-mdadm(2738)
        |-mixer_applet2(5090)---{mixer_applet2}(5117)
       
|-mozilla-launche(5121)---thunderbird-bin(5131)-+-{thunderbird-bin}(513+
        |                                              
|-{thunderbird-bin}(513+
        |                                              
|-{thunderbird-bin}(513+
        |                                              
|-{thunderbird-bin}(513+
        |                                              
|-{thunderbird-bin}(513+
        |                                              
|-{thunderbird-bin}(514+
        |                                              
|-{thunderbird-bin}(514+
        |                                              
`-{thunderbird-bin}(514+
        |-multiload-apple(5080)
        |-smartd(4507)
        |-syslog-ng(4018)
        `-udevd(932)


lsmod
Module                  Size  Used by
ath9k                 245620  0
mac80211              188280  1 ath9k
ath                     9512  1 ath9k
cfg80211               98080  3 ath9k,mac80211,ath
rfkill_backport        21520  1 cfg80211
nvidia               8121160  36
f71882fg               28632  0
snd_seq                62016  0
output                  3432  0
ext4                  241640  1
jbd2                   63000  1 ext4
crc16                   1960  1 ext4
snd_virtuoso           14564  1
snd_oxygen_lib         34344  1 snd_virtuoso
snd_pcm                88816  1 snd_oxygen_lib
snd_timer              24536  2 snd_seq,snd_pcm
snd_page_alloc          9976  1 snd_pcm
snd_mpu401_uart         8424  1 snd_oxygen_lib
snd_rawmidi            23336  1 snd_mpu401_uart
snd_seq_device          7772  2 snd_seq,snd_rawmidi
snd                    60968  10
snd_seq,snd_virtuoso,snd_oxygen_lib,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
r8169                  37100  0
k8temp                  5608  0
hwmon                   2920  2 f71882fg,k8temp
soundcore               1648  1 snd
i2c_nforce2             8336  0
i2c_core               27328  2 nvidia,i2c_nforce2
