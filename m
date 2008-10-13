From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Mon, 13 Oct 2008 16:58:05 +0400
Message-ID: <20081013165805.735bf06e.baz@irc.msk.ru>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5hod1pz1xl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 32D6D2447C
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 14:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id E93D521AD0
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 16:58:06 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMaXRWt9D9fL for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 16:58:05 +0400 (MSD)
Received: from wasp.corp.mail.ru (unknown [195.218.190.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 16:58:05 +0400 (MSD)
In-Reply-To: <s5hod1pz1xl.wl%tiwai@suse.de>
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

On Mon, 13 Oct 2008 04:03:34 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 12 Oct 2008 16:53:53 +0400,
> Alexey Bazhin wrote:
> > 
> > Hi,
> > 
> > I have just compiled driver from git and try to run it. My card is
> > pci: 1102:0005 Multimedia audio controller: Creative Labs SB X-Fi
> > 
> > I got following:
> > 
> > root@mayonaka:~# modprobe snd-sbxfi
> > root@mayonaka:~# speaker-test -c 2 -r 96000 -t sine
> > 
> > speaker-test 1.0.15
> > 
> > Playback device is default
> > Stream parameters are 96000Hz, S16_LE, 2 channels
> > Sine wave rate is 440.0000Hz
> > Rate set to 96000Hz (requested 96000Hz)
> > [  262.522739] XFi DAC reset timeout
> > 
> > Period size ran[  262.564029] XFi DAC reset timeout
> > ge from 32 to 16[  262.620275] XFi DAC reset timeout
> > 384
> > Using max b[  262.676529] XFi DAC reset timeout
> > uffer size 16384[  262.732784] XFi DAC reset timeout
> > 
> > Periods = 4
> > w[  262.789038] XFi DAC reset timeout
> > as set period_size = 4096
> > was set buffer_size = 16384
> >  0 - Front Left
> > [  327.491997] BUG: soft lockup - CPU#0 stuck for 61s! [swapper:0]
> > [  327.492001] Kernel panic - not syncing: softlockup: hung tasks
> > 
> > and i did hear the sine on the left channel. Hope it helps...
> 
> Try the very latest sound-unstable tree.  Some fixes are there...
Without debug i got the same, with debug my box freezed without
panic, i'l reset it when i get home and will try it again...

root@mayonaka:~# modprobe snd_sbxfi
root@mayonaka:~# dmesg -n 8
root@mayonaka:~# echo 3 > /sys/module/snd_sbxfi/parameters/debug 
root@mayonaka:~# speaker-test -c 2 -r 96000 -t sine

speaker-test 1.0.15

Playback device is default
Stream parameters are 96000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 96000Hz (requested 96000Hz)
Buffer size range from 32 to 16384
Period size range from 32 to 16384
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384

and on serial console:

root@mayonaka:~# [  260.267198] SBXFI: read(0) 0x1c6010 = 0x400
[  260.317211] SBXFI: IRQ = 0x400
[  260.353691] SBXFI: write(0) 0x1c6010 = 0x400
[  260.405119] SBXFI: read(0) 0x1c6010 = 0x400
[  260.455132] SBXFI: IRQ = 0x400
[  260.491612] SBXFI: write(0) 0x1c6010 = 0x400
[  260.548382] SBXFI: read(0) 0x1c6010 = 0x400
[  260.598458] SBXFI: IRQ = 0x400
[  260.634936] SBXFI: write(0) 0x1c6010 = 0x400
[  260.707256] SBXFI: Allocate SRC 0
[  260.747893] SBXFI: allocated TLB at 0 for 16 pages
[  260.805192] SBXFI: filled TLB pages starting at 0xc10000
[  260.869274] SBXFI: PLAYBACK PREPARE: rate=96000, period_size=4096,
buffer_size=16384
[  260.961916] SBXFI: read(0) 0x1c6010 = 0x400
[  261.011901] SBXFI: IRQ = 0x400
[  261.048383] SBXFI: write(0) 0x1c6010 = 0x400
[  261.099457] SBXFI: INIT DAC
[  261.132903] SBXFI: read(0) 0x1c6020 = 0x9e00
[  261.184021] SBXFI: write(0) 0x1c6020 = 0x9e00
[  261.236091] SBXFI: RESET DAC
[  261.270491] SBXFI: write(10) 0xcc = 0x8c
[  261.317366] SBXFI: write(10) 0xcc = 0xe
[  261.363203] SBXFI: read(10) 0xcc = 0x83aa
[  261.411115] SBXFI: read(10) 0xcc = 0x83aa
[  261.459022] SBXFI: write(10) 0xec = 0x5
[  261.504863] SBXFI: read(10) 0xec = 0x80800005
[  261.656093] SBXFI: read(0) 0x1c6020 = 0x9e00
[  261.707117] SBXFI: write(0) 0x1c6020 = 0x9e00
[  261.759192] SBXFI: read(0) 0x1c6020 = 0x9e00
[  261.811209] SBXFI: write(0) 0x1c6020 = 0x9e02
[  261.962494] SBXFI: read(0) 0x1c6020 = 0x9e02
[  262.013614] SBXFI: write(0) 0x1c6020 = 0x9e00
[  262.065688] SBXFI: read(0) 0x1c6020 = 0x9e00
[  262.117708] SBXFI: write(0) 0x1c6020 = 0x9e02
[  262.169826] SBXFI: write(10) 0xe0 = 0x180080
[  262.220860] SBXFI: write(10) 0xe4 = 0x8001
[  262.269812] SBXFI: read(10) 0xec = 0x80000005
[  262.321881] XFi DAC reset timeout
[  262.361479] SBXFI: write(10) 0xe0 = 0x180080
[  262.412511] SBXFI: write(10) 0xe4 = 0x1002
[  262.461466] SBXFI: read(10) 0xec = 0x80000005
[  262.513533] XFi DAC reset timeout
[  262.553132] SBXFI: write(10) 0xe0 = 0x180080
[  262.604164] SBXFI: write(10) 0xe4 = 0x2506
[  262.653117] SBXFI: read(10) 0xec = 0x80000005
[  262.705185] XFi DAC reset timeout
[  262.744783] SBXFI: write(10) 0xe0 = 0x180080
[  262.795817] SBXFI: write(10) 0xe4 = 0x2509
[  262.844772] SBXFI: read(10) 0xec = 0x80000005
[  262.896838] XFi DAC reset timeout
[  262.936436] SBXFI: write(10) 0xe0 = 0x180080
[  262.987469] SBXFI: write(10) 0xe4 = 0x250c
[  263.036422] SBXFI: read(10) 0xec = 0x80000005
[  263.088489] XFi DAC reset timeout
[  263.128091] SBXFI: write(10) 0xe0 = 0x180080
[  263.179122] SBXFI: write(10) 0xe4 = 0x250f
[  263.228076] SBXFI: read(10) 0xec = 0x80000005
[  263.280144] XFi DAC reset timeout
[  263.319744] SBXFI: read(0) 0x1c6020 = 0x9e02
[  263.370774] SBXFI: write(0) 0x1c6020 = 0x9e42
[  263.422847] SBXFI: SETUP I2S
[  263.457246] SBXFI: read(0) 0x1c5420 = 0x0
[  263.505154] SBXFI: write(0) 0x1c5420 = 0x4040406
[  263.560353] SBXFI: Pitch [0:fa6] = 0x1000000
[  263.611381] SBXFI: write(0) 0x19be98 = 0x1000000
[  263.666569] SBXFI: Pitch [80:7a6] = 0x1000000
[  263.718632] SBXFI: write(0) 0x199e98 = 0x1000000
[  263.773831] SBXFI: Pitch [1:fb6] = 0x1000000
[  263.824859] SBXFI: write(0) 0x19bed8 = 0x1000000
[  263.880048] SBXFI: Pitch [81:7b6] = 0x1000000
[  263.932118] SBXFI: write(0) 0x199ed8 = 0x1000000
[  263.987308] SBXFI: Amp [0:1] = 0xeb1
[  264.030021] SBXFI: write(0) 0x140008 = 0x3ac40011
[  264.086250] SBXFI: write(0) 0x14000c = 0x0
[  264.135203] SBXFI: write(0) 0x143d30 = 0x3ac47a61
[  264.191432] SBXFI: write(0) 0x143d34 = 0x0
[  264.240384] SBXFI: Amp [80:7a6] = 0xeb1
[  264.286217] SBXFI: Amp [1:11] = 0xeb1
[  264.329973] SBXFI: write(0) 0x140088 = 0x3ac40111
[  264.386201] SBXFI: write(0) 0x14008c = 0x0
[  264.435156] SBXFI: write(0) 0x143db0 = 0x3ac47b61
[  264.491383] SBXFI: write(0) 0x143db4 = 0x0
[  264.540334] SBXFI: Amp [81:7b6] = 0xeb1
[  264.586169] SBXFI: write(0) 0x1c5000 = 0x0
[  264.635122] SBXFI: write(0) 0x1c5004 = 0x0
[  264.684074] SBXFI: write(0) 0x1c5008 = 0x0
[  264.733026] SBXFI: write(0) 0x1c500c = 0x0
[  264.781978] SBXFI: write(0) 0x1c5010 = 0x0
[  264.830930] SBXFI: write(0) 0x1c5014 = 0x0
[  264.879885] SBXFI: write(0) 0x1c5018 = 0x0
[  264.928838] SBXFI: write(0) 0x1c501c = 0x0
[  264.977790] SBXFI: write(0) 0x1c5020 = 0x0
[  265.026743] SBXFI: write(0) 0x1c5024 = 0x0
[  265.075695] SBXFI: write(0) 0x1c5028 = 0x0
[  265.124646] SBXFI: write(0) 0x1c502c = 0x0
[  265.173599] SBXFI: write(0) 0x1c5030 = 0x0
[  265.222553] SBXFI: write(0) 0x1c5034 = 0x0
[  265.271503] SBXFI: write(0) 0x1c5038 = 0x0
[  265.320458] SBXFI: write(0) 0x1c503c = 0x0
[  265.369409] SBXFI: write(0) 0x1c5040 = 0x0
[  265.418369] SBXFI: write(0) 0x1c5044 = 0x0
[  265.467314] SBXFI: write(0) 0x1c5048 = 0x0
[  265.516267] SBXFI: write(0) 0x1c504c = 0x0
[  265.565221] SBXFI: write(0) 0x1c5050 = 0x0
[  265.614172] SBXFI: write(0) 0x1c5054 = 0x0
[  265.663124] SBXFI: write(0) 0x1c5058 = 0x0
[  265.712076] SBXFI: write(0) 0x1c505c = 0x0
[  265.761032] SBXFI: write(0) 0x1c5060 = 0x0
[  265.809982] SBXFI: write(0) 0x1c5064 = 0x0
[  265.858936] SBXFI: write(0) 0x1c5068 = 0x0
[  265.907889] SBXFI: write(0) 0x1c506c = 0x0
[  265.956840] SBXFI: write(0) 0x1c5070 = 0x0
[  266.005793] SBXFI: write(0) 0x1c5074 = 0x0
[  266.054745] SBXFI: write(0) 0x1c5078 = 0x0
[  266.103696] SBXFI: write(0) 0x1c507c = 0x0
[  266.152649] SBXFI: write(0) 0x1c5080 = 0x0
[  266.201601] SBXFI: write(0) 0x1c5084 = 0x0
[  266.250554] SBXFI: write(0) 0x1c5088 = 0x0
[  266.299509] SBXFI: write(0) 0x1c508c = 0x0
[  266.348459] SBXFI: write(0) 0x1c5090 = 0x0
[  266.397412] SBXFI: write(0) 0x1c5094 = 0x0
[  266.446366] SBXFI: write(0) 0x1c5098 = 0x0
[  266.495317] SBXFI: write(0) 0x1c509c = 0x0
[  266.544270] SBXFI: write(0) 0x1c50a0 = 0x0
[  266.593224] SBXFI: write(0) 0x1c50a4 = 0x0
[  266.642175] SBXFI: write(0) 0x1c50a8 = 0x0
[  266.691125] SBXFI: write(0) 0x1c50ac = 0x0
[  266.740081] SBXFI: write(0) 0x1c50b0 = 0x0
[  266.789032] SBXFI: write(0) 0x1c50b4 = 0x0
[  266.837985] SBXFI: write(0) 0x1c50b8 = 0x0
[  266.886938] SBXFI: write(0) 0x1c50bc = 0x0
[  266.935891] SBXFI: write(0) 0x1c50c0 = 0x0
[  266.984842] SBXFI: write(0) 0x1c50c4 = 0x0
[  267.033795] SBXFI: write(0) 0x1c50c8 = 0x0
[  267.082748] SBXFI: write(0) 0x1c50cc = 0x0
[  267.131702] SBXFI: write(0) 0x1c50d0 = 0x0
[  267.180650] SBXFI: write(0) 0x1c50d4 = 0x0
[  267.229604] SBXFI: write(0) 0x1c50d8 = 0x0
[  267.278557] SBXFI: write(0) 0x1c50dc = 0x0
[  267.327508] SBXFI: write(0) 0x1c50e0 = 0x0
[  267.376462] SBXFI: write(0) 0x1c50e4 = 0x0
[  267.425415] SBXFI: write(0) 0x1c50e8 = 0x0
[  267.474367] SBXFI: write(0) 0x1c50ec = 0x0
[  267.523322] SBXFI: write(0) 0x1c50f0 = 0x0
[  267.572273] SBXFI: write(0) 0x1c50f4 = 0x0
[  267.621225] SBXFI: write(0) 0x1c50f8 = 0x0
[  267.670179] SBXFI: write(0) 0x1c50fc = 0x0
[  267.719130] SBXFI: write(0) 0x1c5100 = 0x0
[  267.768082] SBXFI: write(0) 0x1c5104 = 0x0
[  267.817034] SBXFI: write(0) 0x1c5108 = 0x0
[  267.865989] SBXFI: write(0) 0x1c510c = 0x0
[  267.914942] SBXFI: write(0) 0x1c5110 = 0x0
[  267.963894] SBXFI: write(0) 0x1c5114 = 0x0
[  268.012846] SBXFI: write(0) 0x1c5118 = 0x0
[  268.061798] SBXFI: write(0) 0x1c511c = 0x0
[  268.110749] SBXFI: write(0) 0x1c5120 = 0x0
[  268.159704] SBXFI: write(0) 0x1c5124 = 0x0
[  268.208656] SBXFI: write(0) 0x1c5128 = 0x0
[  268.257607] SBXFI: write(0) 0x1c512c = 0x0
[  268.306561] SBXFI: write(0) 0x1c5130 = 0x0
[  268.355513] SBXFI: write(0) 0x1c5134 = 0x0
[  268.404467] SBXFI: write(0) 0x1c5138 = 0x0
[  268.453418] SBXFI: write(0) 0x1c513c = 0x0
[  268.502370] SBXFI: write(0) 0x1c5000 = 0x0
[  268.551323] SBXFI: write(0) 0x1c5004 = 0x20011
[  268.604433] SBXFI: write(0) 0x1c5008 = 0x30801
[  268.657544] SBXFI: write(0) 0x1c500c = 0x811
[  268.708573] SBXFI: write(0) 0x1c5000 = 0x10001
[  268.761993] SBXFI: read(0) 0x1c6010 = 0x400
[  268.811984] SBXFI: IRQ = 0x400
[  268.848461] SBXFI: write(0) 0x1c6010 = 0x400
[  268.948453] SBXFI: PLAT TRIGGER START
[  268.952005] SBXFI: write(0) 0x1b0010 = 0x80
[  268.952005] SBXFI: write(0) 0x1b0014 = 0x0
[  268.952005] SBXFI: write(0) 0x1b0018 = 0x0
[  268.952005] SBXFI: write(0) 0x1b001c = 0x10000
[  268.952005] SBXFI: write(0) 0x1b0004 = 0x100
[  268.952005] SBXFI: write(0) 0x1b0000 = 0x1045c
[  268.952005] SBXFI: write(0) 0x1b0110 = 0x80
[  268.952005] SBXFI: write(0) 0x1b0114 = 0x0
[  268.952005] SBXFI: write(0) 0x1b0118 = 0x0
[  268.952005] SBXFI: write(0) 0x1b011c = 0x10000
[  268.952005] SBXFI: write(0) 0x1b0104 = 0x100
[  268.952005] SBXFI: write(0) 0x1b0100 = 0x5c
[  268.952005] SBXFI: read(0) 0x1b0010 = 0xc5b4
[  268.952005] SBXFI: POINTER = 314d
[  268.952005] SBXFI: set timer ticks = 20813
[  268.952005] SBXFI: write(0) 0x1c6004 = 0xdfff
[  268.952005] SBXFI: write(0) 0x1c6014 = 0x100


-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
