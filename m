From: "Andrei Tanas" <andrei@tanas.ca>
Subject: Re: digital audio on ASUS P5QL-EM motherboard
Date: Sun, 16 Nov 2008 01:39:21 -0500
Message-ID: <004c01c947b6$0ea0f7e0$2be2e7a0$@ca>
References: <6d799ca1be9af898f664f82ade06d669@localhost>	<20081115002724.GA5073@mail.ustc.edu.cn>	<002f01c94770$adeba2a0$09c2e7e0$@ca>	<20081116021525.GA7795@localhost>
	<003801c947b4$b857ffb0$2907ff10$@ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 69474103817
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 07:39:09 +0100 (CET)
In-Reply-To: <003801c947b4$b857ffb0$2907ff10$@ca>
Content-Language: en-ca
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Wu Fengguang' <fengguang.wu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Model autodetection:
> lspci -nn -vvv shows:
> 00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family)
> HD
> Audio Controller [8086:3a3e]
>         Subsystem: ASUSTeK Computer Inc. Device [1043:82fe]
> 
> So this SND_PCI_QUIRK fixes it (except that it's currently relying on
> the
> temporary hack)
> 
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -8206,6 +8206,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
>         SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
>         SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
>         SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
> +       SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q", ALC883_6ST_DIG),
>         SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
>         SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI",
> ALC883_3ST_6ch_DIG),
>         SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601",
> ALC888_ASUS_EEE1601),

And here's dmesg for this (with the hda-intel.c patch reversed):

[    8.439326] ALSA sound/pci/hda/hda_intel.c:2187: chipset global
capabilities = 0x4401
[    8.463340] ALSA sound/pci/hda/hda_intel.c:779: codec_mask = 0x3
[    8.463452] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #0
probed OK
[    8.463580] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #1
probed OK
[    8.465558] ALSA sound/pci/hda/hda_codec.c:2612: hda_codec: model
'6stack-dig' is selected for config 1043:82fe (Asus P5Q)
