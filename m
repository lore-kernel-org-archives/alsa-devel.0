From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_vortex_dev_free() BUG: unable to handle kernel
	NULL pointer
Date: Fri, 16 Mar 2012 10:24:34 +0800
Message-ID: <CAN8cciazC8PdVcQ1eGfKhJSXgY3i+A5S=o_Z7-Hf-veGVG6LYw@mail.gmail.com>
References: <CAN8ccibVNfpQ4brjnU3CkXxsyJmiuzq2YA-DJ25PH6A76HP7qQ@mail.gmail.com>
	<4F61A8D9.9090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D2B7C244BD
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 03:24:34 +0100 (CET)
Received: by werg1 with SMTP id g1so3718588wer.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 19:24:34 -0700 (PDT)
In-Reply-To: <4F61A8D9.9090505@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: avagin@gmail.com, Takashi Iwai <tiwai@suse.de>
Cc: manuel.jander@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/15, Andrew Vagin <avagin@gmail.com>:
> Hello,
>
> In this case I try to reload modules and get this bug.
> # killall pulseaudio; rmmod snd_au8830 snd_hda_intel snd_seq snd_ac97_codec
> ac97_bus snd_hda_codec snd_hwdep snd_mpu401_uart snd_pcm snd_rawmidi
> snd_seq_device snd_pcm snd_timer  snd_page_alloc snd
> # modprobe snd_au8830


> [   12.657863] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> [   12.659223] snd_hda_intel 0000:00:1b.0: irq 48 for MSI/MSI-X
> [   12.660521] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
> [   12.670024] ALSA sound/pci/hda/hda_intel.c:2837 no codecs found!
> [   12.671307] snd_hda_intel 0000:00:1b.0: PCI INT A disabled

Does your hda-intel  work properly?

speaker-test -c 2 -t wav -Dhw:Intel

any error message in system log before you unload the module, your
output only show
the error after reload ?

does "aplay -l" alway show two cards for every reboot ?

if your on-board hda-intel can only be loaded randomly, pulseaudio
server may behave differently since default is on-board sound card

>>> https://bugzilla.redhat.com/show_bug.cgi?id=788978
>>
>> Sometimes my sound card hangs up (It do not produce sounds. Applications
>> which try to play something hangs).

As your au8830 have stac9708

Did you select surround40 or stereo analog output profile ?

> APLAY

> **** List of PLAYBACK Hardware Devices ****
> card 0: au8830 [Aureal Vortex au8830], device 0: Aureal Vortex 2 ADB [au8830 adb]
>  Subdevices: 32/32


http://git.alsa-project.org/?p=alsa-kernel.git&a=search&h=HEAD&st=commit&s=au88x0

since you still have 32 playback subdevices

did you have commit 	fb65c2dfe60d38be6b9193d0b85e66e780cd4373

without this patch, the front and rear can be played correct once and
swapped afterwards
on my au8830

speaker-test -c 4 -t wav -Dsurround40:au8830

Are you sure that pulseaudio server is still running ?

if pulseaudio server crash but you still have an application using hw:au8830

it won't respwan because is_card_busy() in commit
d6fb8d10819bebc1cee203de7330cceeafde9fed

udev: check busy status of alsa cards before loading alsa modules and
hence initiating profile probing

Try

speaker-test -c 2 -t wav -D hw:au8830

speaker-test -c 4 -t wav -D hw:au8830

Does you enable power saving or the computer enter suspend/resume cycle ?

https://bugzilla.redhat.com/show_bug.cgi?id=789156

Sound au8830 does not work after standby mode

>> Can you try Taskashi 's patch and reply back to alsa-developer mailing
>> list
>
> The kernel doesn't panic with this patches, but a sound card doesn't work.
>
> The origin problem is that sometimes my sound card stops to play
> anything. I try to reload the module to fix that, but it doesn't help. I
> can provide any info which you need to investigate this problem.
>
> [root@dhcp-10-30-19-46 avagin]# rmmod snd_au8830
> [root@dhcp-10-30-19-46 avagin]# modprobe snd_au8830
> [root@dhcp-10-30-19-46 avagin]# dmesg
> [ 3669.934145] snd_au8830 0000:06:00.0: PCI INT A -> GSI 21 (level, low)
> -> IRQ 21
> [ 3669.934310] Vortex: init....
> [ 3670.251191] bad adb fifo reset!
> [ 3670.251221] bad adb fifo reset!
> [ 3670.251239] bad adb fifo reset!
> [ 3670.251257] bad adb fifo reset!
> [ 3670.251276] bad adb fifo reset!
> [ 3670.251294] bad adb fifo reset!
> [ 3670.251313] bad adb fifo reset!
> [ 3670.251330] bad adb fifo reset!
> [ 3670.251348] bad adb fifo reset!
> [ 3670.251366] bad adb fifo reset!
> [ 3670.251383] bad adb fifo reset!
> [ 3670.251401] bad adb fifo reset!
> [ 3670.251419] bad adb fifo reset!
> [ 3670.251437] bad adb fifo reset!
> [ 3670.251456] bad adb fifo reset!
> [ 3670.251473] bad adb fifo reset!
> [ 3670.251491] bad adb fifo reset!
> [ 3670.251509] bad adb fifo reset!
> [ 3670.251527] bad adb fifo reset!
> [ 3670.251545] bad adb fifo reset!
> [ 3670.251563] bad adb fifo reset!
> [ 3670.251581] bad adb fifo reset!
> [ 3670.251599] bad adb fifo reset!
> [ 3670.251617] bad adb fifo reset!
> [ 3670.251634] bad adb fifo reset!
> [ 3670.251653] bad adb fifo reset!
> [ 3670.251670] bad adb fifo reset!
> [ 3670.251688] bad adb fifo reset!
> [ 3670.251706] bad adb fifo reset!
> [ 3670.251723] bad adb fifo reset!
> [ 3670.251741] bad adb fifo reset!
> [ 3670.251758] bad adb fifo reset!
> [ 3670.251777] bad wt fifo reset (0x000160fc, 0xffffffff)!
> [ 3670.251797] bad wt fifo reset (0x000160f8, 0xffffffff)!
> [ 3670.251814] bad wt fifo reset (0x000160f4, 0xffffffff)!
> [ 3670.251832] bad wt fifo reset (0x000160f0, 0xffffffff)!
> [ 3670.251850] bad wt fifo reset (0x000160ec, 0xffffffff)!
> [ 3670.251868] bad wt fifo reset (0x000160e8, 0xffffffff)!
> [ 3670.251886] bad wt fifo reset (0x000160e4, 0xffffffff)!
> [ 3670.251904] bad wt fifo reset (0x000160e0, 0xffffffff)!
> [ 3670.251922] bad wt fifo reset (0x000160dc, 0xffffffff)!
> [ 3670.251941] bad wt fifo reset (0x000160d8, 0xffffffff)!
> [ 3670.251959] bad wt fifo reset (0x000160d4, 0xffffffff)!
> [ 3670.251977] bad wt fifo reset (0x000160d0, 0xffffffff)!
> [ 3670.251995] bad wt fifo reset (0x000160cc, 0xffffffff)!
> [ 3670.252024] bad wt fifo reset (0x000160c8, 0xffffffff)!
> [ 3670.252043] bad wt fifo reset (0x000160c4, 0xffffffff)!
> [ 3670.252062] bad wt fifo reset (0x000160c0, 0xffffffff)!
> [ 3670.252081] bad wt fifo reset (0x000160bc, 0xffffffff)!
> [ 3670.252100] bad wt fifo reset (0x000160b8, 0xffffffff)!
> [ 3670.252120] bad wt fifo reset (0x000160b4, 0xffffffff)!
> [ 3670.252139] bad wt fifo reset (0x000160b0, 0xffffffff)!
> [ 3670.252157] bad wt fifo reset (0x000160ac, 0xffffffff)!
> [ 3670.252175] bad wt fifo reset (0x000160a8, 0xffffffff)!
> [ 3670.252194] bad wt fifo reset (0x000160a4, 0xffffffff)!
> [ 3670.252212] bad wt fifo reset (0x000160a0, 0xffffffff)!
> [ 3670.252231] bad wt fifo reset (0x0001609c, 0xffffffff)!
> [ 3670.252249] bad wt fifo reset (0x00016098, 0xffffffff)!
> [ 3670.252267] bad wt fifo reset (0x00016094, 0xffffffff)!
> [ 3670.252285] bad wt fifo reset (0x00016090, 0xffffffff)!
> [ 3670.252303] bad wt fifo reset (0x0001608c, 0xffffffff)!
> [ 3670.252322] bad wt fifo reset (0x00016088, 0xffffffff)!
> [ 3670.252342] bad wt fifo reset (0x00016084, 0xffffffff)!
> [ 3670.252361] bad wt fifo reset (0x00016080, 0xffffffff)!
> [ 3670.252380] bad wt fifo reset (0x0001607c, 0xffffffff)!
> [ 3670.252398] bad wt fifo reset (0x00016078, 0xffffffff)!
> [ 3670.252416] bad wt fifo reset (0x00016074, 0xffffffff)!
> [ 3670.252434] bad wt fifo reset (0x00016070, 0xffffffff)!
> [ 3670.252452] bad wt fifo reset (0x0001606c, 0xffffffff)!
> [ 3670.252470] bad wt fifo reset (0x00016068, 0xffffffff)!
> [ 3670.252488] bad wt fifo reset (0x00016064, 0xffffffff)!
> [ 3670.252506] bad wt fifo reset (0x00016060, 0xffffffff)!
> [ 3670.252524] bad wt fifo reset (0x0001605c, 0xffffffff)!
> [ 3670.252542] bad wt fifo reset (0x00016058, 0xffffffff)!
> [ 3670.252560] bad wt fifo reset (0x00016054, 0xffffffff)!
> [ 3670.252578] bad wt fifo reset (0x00016050, 0xffffffff)!
> [ 3670.252596] bad wt fifo reset (0x0001604c, 0xffffffff)!
> [ 3670.252614] bad wt fifo reset (0x00016048, 0xffffffff)!
> [ 3670.252631] bad wt fifo reset (0x00016044, 0xffffffff)!
> [ 3670.252649] bad wt fifo reset (0x00016040, 0xffffffff)!
> [ 3670.252667] bad wt fifo reset (0x0001603c, 0xffffffff)!
> [ 3670.252686] bad wt fifo reset (0x00016038, 0xffffffff)!
> [ 3670.252704] bad wt fifo reset (0x00016034, 0xffffffff)!
> [ 3670.252722] bad wt fifo reset (0x00016030, 0xffffffff)!
> [ 3670.252740] bad wt fifo reset (0x0001602c, 0xffffffff)!
> [ 3670.252758] bad wt fifo reset (0x00016028, 0xffffffff)!
> [ 3670.252776] bad wt fifo reset (0x00016024, 0xffffffff)!
> [ 3670.252794] bad wt fifo reset (0x00016020, 0xffffffff)!
> [ 3670.252813] bad wt fifo reset (0x0001601c, 0xffffffff)!
> [ 3670.252831] bad wt fifo reset (0x00016018, 0xffffffff)!
> [ 3670.252851] bad wt fifo reset (0x00016014, 0xffffffff)!
> [ 3670.252868] bad wt fifo reset (0x00016010, 0xffffffff)!
> [ 3670.252886] bad wt fifo reset (0x0001600c, 0xffffffff)!
> [ 3670.252904] bad wt fifo reset (0x00016008, 0xffffffff)!
> [ 3670.252922] bad wt fifo reset (0x00016004, 0xffffffff)!
> [ 3670.252940] bad wt fifo reset (0x00016000, 0xffffffff)!
> [ 3670.254466] ALSA sound/core/control.c:344 control 3:0:0:Playback PCM
> advanced processing:0 is already present
> [ 3670.254580] done.
> [ 3670.356981] vortex: ac97 address never arrived
> [ 3670.457979] vortex: ac97 address never arrived
> [ 3670.559026] vortex: ac97 address never arrived
> [ 3670.660022] vortex: ac97 address never arrived
> [ 3670.761005] vortex: ac97 address never arrived
> [ 3670.861991] vortex: ac97 address never arrived
> [ 3670.962974] vortex: ac97 address never arrived
> [ 3671.063931] vortex: ac97 address never arrived
> [ 3671.164882] vortex: ac97 address never arrived
> [ 3671.265897] vortex: ac97 address never arrived
> [ 3671.367023] vortex: ac97 address never arrived
> [ 3671.468052] vortex: ac97 address never arrived
> [ 3671.569092] vortex: ac97 address never arrived
> [ 3671.670173] vortex: ac97 address never arrived
> [ 3671.771195] vortex: ac97 address never arrived
> [ 3671.772029] ALSA sound/pci/ac97/ac97_codec.c:2089 AC'97 0 does not
> respond - RESET
> [ 3671.872965] vortex: ac97 address never arrived
> [ 3671.973942] vortex: ac97 address never arrived
> [ 3671.973948] ALSA sound/pci/ac97/ac97_codec.c:2098 AC'97 0 access is
> not valid [0xffffffff], removing mixer.
> [ 3671.974774] vortex: IRQ fatal error
> [ 3671.974780] vortex: IRQ parity error
> [ 3671.974783] vortex: IRQ reg error
> [ 3671.974785] vortex: IRQ fifo error
> [ 3671.974787] vortex: IRQ dma error
> [ 3671.974792] Vortex: shutdown...
> [ 3671.974828] vortex: FATAL: ResManager: resource type 3 exhausted.
> [ 3671.974832] vortex: FATAL: ResManager: resource type 3 exhausted.
> [ 3671.974838] vortex_adb_delroutes: route not found! 0x24a0
> [ 3671.974854] vortex: srcdelWTD: error, lifeboat overflow
> [ 3671.974859] vortex_adb_delroutes: route not found! 0x24a1
> [ 3671.974874] vortex: srcdelWTD: error, lifeboat overflow
> [ 3671.974881] vortex_adb_delroutes: route not found! 0x7e88
> [ 3671.974885] vortex_adb_delroutes: route not found! 0x7f89
> [ 3671.974888] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974891] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974895] vortex_adb_delroutes: route not found! 0x7044
> [ 3671.974899] vortex_adb_delroutes: route not found! 0x7144
> [ 3671.974902] vortex: FATAL: ResManager: resource type 3 exhausted.
> [ 3671.974905] vortex: FATAL: ResManager: resource type 3 exhausted.
> [ 3671.974909] vortex_adb_delroutes: route not found! 0x2492
> [ 3671.974924] vortex: srcdelWTD: error, lifeboat overflow
> [ 3671.974930] vortex_adb_delroutes: route not found! 0x2493
> [ 3671.974945] vortex: srcdelWTD: error, lifeboat overflow
> [ 3671.974949] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974954] vortex_adb_delroutes: route not found! 0x6044
> [ 3671.974959] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974963] vortex_adb_delroutes: route not found! 0x6144
> [ 3671.974968] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974972] vortex_adb_delroutes: route not found! 0x6244
> [ 3671.974977] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974981] vortex_adb_delroutes: route not found! 0x6344
> [ 3671.974985] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974990] vortex_adb_delroutes: route not found! 0x6444
> [ 3671.974994] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.974999] vortex_adb_delroutes: route not found! 0x6544
> [ 3671.975001] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975001] vortex_adb_delroutes: route not found! 0xa044
> [ 3671.975024] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975030] vortex_adb_delroutes: route not found! 0xa144
> [ 3671.975035] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975039] vortex_adb_delroutes: route not found! 0xa244
> [ 3671.975044] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975050] vortex_adb_delroutes: route not found! 0xa344
> [ 3671.975055] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975060] vortex_adb_delroutes: route not found! 0xa444
> [ 3671.975066] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975071] vortex_adb_delroutes: route not found! 0xa544
> [ 3671.975090] vortex: FATAL: ResManager: resource type 2 exhausted.
> [ 3671.975094] vortex: vortex_Vort3D: ERROR: not enough free mixer
> resources.
> [ 3671.975099] bad adb fifo reset!
> [ 3671.975117] bad adb fifo reset!
> [ 3671.975135] bad adb fifo reset!
> [ 3671.975153] bad adb fifo reset!
> [ 3671.975172] bad adb fifo reset!
> [ 3671.975190] bad adb fifo reset!
> [ 3671.975207] bad adb fifo reset!
> [ 3671.975226] bad adb fifo reset!
> [ 3671.975246] bad adb fifo reset!
> [ 3671.975264] bad adb fifo reset!
> [ 3671.975283] bad adb fifo reset!
> [ 3671.975301] bad adb fifo reset!
> [ 3671.975319] bad adb fifo reset!
> [ 3671.975337] bad adb fifo reset!
> [ 3671.975355] bad adb fifo reset!
> [ 3671.975373] bad adb fifo reset!
> [ 3671.975390] bad adb fifo reset!
> [ 3671.975408] bad adb fifo reset!
> [ 3671.975428] bad adb fifo reset!
> [ 3671.975446] bad adb fifo reset!
> [ 3671.975464] bad adb fifo reset!
> [ 3671.975482] bad adb fifo reset!
> [ 3671.975500] bad adb fifo reset!
> [ 3671.975518] bad adb fifo reset!
> [ 3671.975536] bad adb fifo reset!
> [ 3671.975554] bad adb fifo reset!
> [ 3671.975571] bad adb fifo reset!
> [ 3671.975588] bad adb fifo reset!
> [ 3671.975607] bad adb fifo reset!
> [ 3671.975625] bad adb fifo reset!
> [ 3671.975643] bad adb fifo reset!
> [ 3671.975662] bad adb fifo reset!
> [ 3671.975681] bad wt fifo reset (0x000160fc, 0xffffffff)!
> [ 3671.975700] bad wt fifo reset (0x000160f8, 0xffffffff)!
> [ 3671.975718] bad wt fifo reset (0x000160f4, 0xffffffff)!
> [ 3671.975736] bad wt fifo reset (0x000160f0, 0xffffffff)!
> [ 3671.975754] bad wt fifo reset (0x000160ec, 0xffffffff)!
> [ 3671.975772] bad wt fifo reset (0x000160e8, 0xffffffff)!
> [ 3671.975790] bad wt fifo reset (0x000160e4, 0xffffffff)!
> [ 3671.975808] bad wt fifo reset (0x000160e0, 0xffffffff)!
> [ 3671.975826] bad wt fifo reset (0x000160dc, 0xffffffff)!
> [ 3671.975844] bad wt fifo reset (0x000160d8, 0xffffffff)!
> [ 3671.975861] bad wt fifo reset (0x000160d4, 0xffffffff)!
> [ 3671.975879] bad wt fifo reset (0x000160d0, 0xffffffff)!
> [ 3671.975897] bad wt fifo reset (0x000160cc, 0xffffffff)!
> [ 3671.975915] bad wt fifo reset (0x000160c8, 0xffffffff)!
> [ 3671.975933] bad wt fifo reset (0x000160c4, 0xffffffff)!
> [ 3671.975950] bad wt fifo reset (0x000160c0, 0xffffffff)!
> [ 3671.975968] bad wt fifo reset (0x000160bc, 0xffffffff)!
> [ 3671.975987] bad wt fifo reset (0x000160b8, 0xffffffff)!
> [ 3671.976012] bad wt fifo reset (0x000160b4, 0xffffffff)!
> [ 3671.976032] bad wt fifo reset (0x000160b0, 0xffffffff)!
> [ 3671.976051] bad wt fifo reset (0x000160ac, 0xffffffff)!
> [ 3671.976070] bad wt fifo reset (0x000160a8, 0xffffffff)!
> [ 3671.976089] bad wt fifo reset (0x000160a4, 0xffffffff)!
> [ 3671.976107] bad wt fifo reset (0x000160a0, 0xffffffff)!
> [ 3671.976127] bad wt fifo reset (0x0001609c, 0xffffffff)!
> [ 3671.976144] bad wt fifo reset (0x00016098, 0xffffffff)!
> [ 3671.976163] bad wt fifo reset (0x00016094, 0xffffffff)!
> [ 3671.976181] bad wt fifo reset (0x00016090, 0xffffffff)!
> [ 3671.976199] bad wt fifo reset (0x0001608c, 0xffffffff)!
> [ 3671.976217] bad wt fifo reset (0x00016088, 0xffffffff)!
> [ 3671.976236] bad wt fifo reset (0x00016084, 0xffffffff)!
> [ 3671.976255] bad wt fifo reset (0x00016080, 0xffffffff)!
> [ 3671.976274] bad wt fifo reset (0x0001607c, 0xffffffff)!
> [ 3671.976292] bad wt fifo reset (0x00016078, 0xffffffff)!
> [ 3671.976310] bad wt fifo reset (0x00016074, 0xffffffff)!
> [ 3671.976328] bad wt fifo reset (0x00016070, 0xffffffff)!
> [ 3671.976346] bad wt fifo reset (0x0001606c, 0xffffffff)!
> [ 3671.976364] bad wt fifo reset (0x00016068, 0xffffffff)!
> [ 3671.976382] bad wt fifo reset (0x00016064, 0xffffffff)!
> [ 3671.976400] bad wt fifo reset (0x00016060, 0xffffffff)!
> [ 3671.976418] bad wt fifo reset (0x0001605c, 0xffffffff)!
> [ 3671.976436] bad wt fifo reset (0x00016058, 0xffffffff)!
> [ 3671.976454] bad wt fifo reset (0x00016054, 0xffffffff)!
> [ 3671.976472] bad wt fifo reset (0x00016050, 0xffffffff)!
> [ 3671.976490] bad wt fifo reset (0x0001604c, 0xffffffff)!
> [ 3671.976508] bad wt fifo reset (0x00016048, 0xffffffff)!
> [ 3671.976526] bad wt fifo reset (0x00016044, 0xffffffff)!
> [ 3671.976546] bad wt fifo reset (0x00016040, 0xffffffff)!
> [ 3671.976564] bad wt fifo reset (0x0001603c, 0xffffffff)!
> [ 3671.976582] bad wt fifo reset (0x00016038, 0xffffffff)!
> [ 3671.976600] bad wt fifo reset (0x00016034, 0xffffffff)!
> [ 3671.976618] bad wt fifo reset (0x00016030, 0xffffffff)!
> [ 3671.976636] bad wt fifo reset (0x0001602c, 0xffffffff)!
> [ 3671.976654] bad wt fifo reset (0x00016028, 0xffffffff)!
> [ 3671.976672] bad wt fifo reset (0x00016024, 0xffffffff)!
> [ 3671.976690] bad wt fifo reset (0x00016020, 0xffffffff)!
> [ 3671.976708] bad wt fifo reset (0x0001601c, 0xffffffff)!
> [ 3671.976727] bad wt fifo reset (0x00016018, 0xffffffff)!
> [ 3671.976745] bad wt fifo reset (0x00016014, 0xffffffff)!
> [ 3671.976763] bad wt fifo reset (0x00016010, 0xffffffff)!
> [ 3671.976781] bad wt fifo reset (0x0001600c, 0xffffffff)!
> [ 3671.976799] bad wt fifo reset (0x00016008, 0xffffffff)!
> [ 3671.976817] bad wt fifo reset (0x00016004, 0xffffffff)!
> [ 3671.976835] bad wt fifo reset (0x00016000, 0xffffffff)!
> [ 3671.983010] done.
> [ 3671.983097] snd_au8830 0000:06:00.0: PCI INT A disabled
> [ 3671.983110] snd_au8830: probe of 0000:06:00.0 failed with error -5
>
>
> On 02/28/2012 12:36 PM, Raymond Yau wrote:
>>
>>
>> At Tue, 28 Feb 2012 11:04:07 +0800,
>> Raymond Yau wrote:
>>> 2012/1/16, Takashi Iwai<tiwai@suse.de>:
>>>> At Fri, 13 Jan 2012 18:47:45 +0800,
>>>> Raymond Yau wrote:
>>>>> [PATCH - ALSA 1/2] Au88x0 - Support 4 channels playback when AC97
>>>>> codecs has SDAC bit
>>>>>
>>>>> - Check SDAC bit of AC97 codec for supporting 4 channels playback.
>>>>>
>>>>>
>>>>> [PATCH - ALSA 2/2] Au88x0 - Reduce the number of playback subdevices
>>>>> of au8830 from 32 to 16
>>>>>
>>>>> - The maximum number of playback streams depend on the number of sample
>>>>>    rate conveters (16) and the number of DMA channels (32).
>>>> Applied both patches.  Thanks.
>>>>
>>>>
>>> Does alsa require the driver to provide private_free for ac97_bus and
>>> ac97 ?
>> No, and it must be irrelevant.
>>
>>> There is a bug report
>>>
>>> snd_vortex_dev_free() BUG: unable to handle kernel NULL pointer
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=788978
>>>
>>> It seem that snd_ac97_bus() fail
>> Or something else.  au88x0 is built in a strange way, sourcing all
>> *.c files into one, so we can't see the exact point.
>>
>> In anyway, the Oops isn't because the probing fails but due to
>> concurrent accesses while removing irq, etc.
>> Maybe a patch like below can help.
>>

when there is more than one sound card and I need to specify index to
all sound cards
in order to let them loaded in the specified order especially when I
have my usb webcam plugged

just specify index=0 in one sound card is not enough and
some of them may failed at snd_card_create() without any error mesasge
in system log



>>
>>> However  I cannot reproduce the bug in 2.6 kernel,
>>>
>>> Do 3.x kernel require mixer created after pcm devices ?
>> No.
>>
>>
>> Takashi
>>
>>> :Call Trace:
>>> : [<ffffffff810dec3d>] __free_irq+0x17d/0x220
>>> : [<ffffffff810dee65>] free_irq+0x55/0xd0
>>> : [<ffffffffa04e2d64>] snd_vortex_dev_free+0x44/0x80 [snd_au8830]
>>> : [<ffffffffa01c0aa1>] snd_device_free+0x71/0x170 [snd]
>>> : [<ffffffffa01c0f51>] snd_device_free_all+0x61/0xb0 [snd]
>>> : [<ffffffffa01b9908>] snd_card_do_free+0x58/0x140 [snd]
>>> : [<ffffffffa01badf3>] snd_card_free+0xa3/0xc0 [snd]
>>> : [<ffffffffa0261b8f>] ? snd_ac97_bus+0xaf/0x130 [snd_ac97_codec]
>>> : [<ffffffffa04e6a9f>] snd_vortex_probe+0x1c40/0x1d09 [snd_au8830]
>>> : [<ffffffff812db37c>] local_pci_probe+0x5c/0xd0
>>> : [<ffffffff812dcc19>] pci_device_probe+0x109/0x130
>>> : [<ffffffff813932cc>] driver_probe_device+0x9c/0x300
>>> : [<ffffffff813935db>] __driver_attach+0xab/0xb0
>>> : [<ffffffff81393530>] ? driver_probe_device+0x300/0x300
>>> : [<ffffffff81393530>] ? driver_probe_device+0x300/0x300
>>> : [<ffffffff8139214c>] bus_for_each_dev+0x5c/0x90
>>> : [<ffffffff81392ede>] driver_attach+0x1e/0x20
>>> : [<ffffffff81392ae0>] bus_add_driver+0x1b0/0x2a0
>>> : [<ffffffffa04ed000>] ? 0xffffffffa04ecfff
>>> : [<ffffffff81393b36>] driver_register+0x76/0x140
>>> : [<ffffffff815e554d>] ? notifier_call_chain+0x4d/0x70
>>> : [<ffffffffa04ed000>] ? 0xffffffffa04ecfff
>>> : [<ffffffff812dc8f6>] __pci_register_driver+0x56/0xd0
>>> : [<ffffffff81041673>] ? set_memory_nx+0x43/0x50
>>> : [<ffffffffa04ed01e>] alsa_card_vortex_init+0x1e/0x1000 [snd_au8830]
>>> : [<ffffffff81002042>] do_one_initcall+0x42/0x180
>>> : [<ffffffff810ac970>] sys_init_module+0xc0/0x230
>>> : [<ffffffff815e9782>] system_call_fastpath+0x16/0x1b
>> ---
>> diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
>> index f13ad53..506d2fc 100644
>> --- a/sound/pci/au88x0/au88x0.c
>> +++ b/sound/pci/au88x0/au88x0.c
>> @@ -123,10 +123,10 @@ static int snd_vortex_dev_free(struct snd_device
>> *device)
>>   {
>>   	vortex_t *vortex = device->device_data;
>>
>> +	free_irq(vortex->irq, vortex);
>>   	vortex_gameport_unregister(vortex);
>>   	vortex_core_shutdown(vortex);
>>   	// Take down PCI interface.
>> -	free_irq(vortex->irq, vortex);
>>   	iounmap(vortex->mmio);
>>   	pci_release_regions(vortex->pci_dev);
>>   	pci_disable_device(vortex->pci_dev);
>> diff --git a/sound/pci/au88x0/au88x0_core.c
>> b/sound/pci/au88x0/au88x0_core.c
>> index 1181c5e..525f881 100644
>> --- a/sound/pci/au88x0/au88x0_core.c
>> +++ b/sound/pci/au88x0/au88x0_core.c
>> @@ -2477,7 +2477,7 @@ static irqreturn_t vortex_interrupt(int irq, void
>> *dev_id)
>>   		hwread(vortex->mmio, VORTEX_IRQ_STAT);
>>   		handled = 1;
>>   	}
>> -	if (source&  IRQ_MIDI) {
>> +	if ((source&  IRQ_MIDI)&&  vortex->rmidi) {
>>   		snd_mpu401_uart_interrupt(vortex->irq,
>>   					  vortex->rmidi->private_data);
>>   		handled = 1;
>
>
