From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 12:01:39 +0800
Message-ID: <CAN8cciZprp7FNQ539fDdV+A8o-dMiiwuCsrUk6ZPZtQ9RTz59g@mail.gmail.com>
References: <4E817010.7030607@ezono.com>
	<4E81CD2E.2010009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4F6EE24464
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 06:01:56 +0200 (CEST)
Received: by fxe22 with SMTP id 22so220860fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2011 21:01:54 -0700 (PDT)
In-Reply-To: <4E81CD2E.2010009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/27 Clemens Ladisch <clemens@ladisch.de>:
> This looks like a patch, not like a crash report.
>

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5451


[ 95.366164] HDA Intel 0000:00:1b.0: PCI INT A -> Link[LNKA] -> GSI 10
(level, low) -> IRQ 10
[ 95.366209] HDA Intel 0000:00:1b.0: setting latency timer to 64
[ 95.398391] hda_codec: Cannot set up configuration from BIOS. Using genenic
mode...
[ 95.398470] BUG: unable to handle kernel NULL pointer dereference at
(null)
[ 95.398477] IP: [<f83740ac>] via_build_pcms+0x60/0xdc [snd_hda_codec_via]
[ 95.398494] *pde = 3173f067 *pte = 00000000
[ 95.398501] Oops: 0000 [#1] PREEMPT
[ 95.398509] Modules linked in: snd_hda_codec_via snd_hda_intel(+)
snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore
snd_page_alloc ipv6 fakephp cgosdrv(P) joydev mcs7830 usbnet mii usbtouchscreen
iTCO_wdt i2c_i801 pciehp iTCO_vendor_support serio_raw xfs i915 drm_kms_helper
drm i2c_algo_bit i2c_core video [last unloaded: scsi_wait_scan]
[ 95.398558]
[ 95.398564] Pid: 4208, comm: modprobe Tainted: P
2.6.40.3-0.119.delos.i686 #1
[ 95.398572] EIP: 0060:[<f83740ac>] EFLAGS: 00010246 CPU: 0
[ 95.398581] EIP is at via_build_pcms+0x60/0xdc [snd_hda_codec_via]
[ 95.398587] EAX: f174f000 EBX: 00000000 ECX: 00000000 EDX: dd58f400
[ 95.398592] ESI: f837c760 EDI: f174f120 EBP: f17afd28 ESP: f17afd20
[ 95.398597] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[ 95.398603] Process modprobe (pid: 4208, ti=f17ae000 task=f0e5be30
task.ti=f17ae000)
[ 95.398607] Stack:
[ 95.398610] dd58f400 00000001 f17afd68 f81ef28a 00000050 f81f6511 f16aa960
f16aa968
[ 95.398622] 00000001 11061708 2d646e73 2d616468 65646f63 64692d63 3031313a
dd58f400
[ 95.398634] f578642c 00000001 f17afd78 f81f5aaf f171da00 f5786424 f17afde4
f816e6fd
[ 95.398645] Call Trace:
[ 95.398665] [<f81ef28a>] snd_hda_codec_build_pcms+0x25/0x230
[snd_hda_codec]
