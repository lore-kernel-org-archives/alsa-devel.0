From: "Matt Mullins" <mokomull@gmail.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Thu, 5 Jul 2007 17:13:48 -0500
Message-ID: <dfd4051f0707051513p697f22a2p4e34d9910f44f15e@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<s5hvedjaq66.wl%tiwai@suse.de>
	<dfd4051f0706201418o4d19a1f2g78081b052e8766e4@mail.gmail.com>
	<s5hd4zpa9d9.wl%tiwai@suse.de>
	<dfd4051f0706221331r681503d7h9d755bd91750a8ec@mail.gmail.com>
	<s5hejk0ibhj.wl%tiwai@suse.de>
	<dfd4051f0706251316uf265b3dw9c069dc5f75ceedf@mail.gmail.com>
	<s5hsl8deffy.wl%tiwai@suse.de>
	<dfd4051f0707041337m276d5536r6c65fd6d29463f39@mail.gmail.com>
	<s5hvecz5cz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id B16AE1038E2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 00:13:51 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so591889ugf
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2007 15:13:49 -0700 (PDT)
In-Reply-To: <s5hvecz5cz3.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After some hacking, I found that for some reason, something is calling
azx_send_cmd with nids much wider than 7 bits.  This happens exactly
twice, once with nid=0x534c, and nid=0x8845.  Both times, the verb is
0xf1c, and para=0x00.  This clobbers parts of "val" in both
azx_single_send_cmd and azx_corb_send_cmd.  I added the following code
to azx_send_cmd, and it works now:
if (!direct && (nid >> 7)) {
        snd_printd(SFX "Uh oh, too wide an NID value. codec=0x%x,
direct=0x%x, nid=0x%x, verb=0x%x, para=0x%x\n", (codec->addr)&0xf,
direct, nid, verb, para);
        return -EIO;
}

This outputs:

[136890.000388] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide an NID value. codec=0x0, direct=0x0,
nid=0x534c, verb=0xf1c, para=0x0
[136890.000393] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide an NID value. codec=0x0, direct=0x0,
nid=0x8845, verb=0xf1c, para=0x0

I do realize that the problem is not completely fixed, and we still
need to figure out what actually calls azx_send_cmd with the offending
parameters.  However, I am now lost in a sea of function pointers...

And it still doesn't work after a suspend, and I get a handful more
"uh oh"s upon resume:
[    3.942647] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x534c, verb=0x71c, para=0xff
[    3.942658] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x534c, verb=0x71d, para=0xff
[    3.942668] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x534c, verb=0x71e, para=0xff
[    3.942678] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x534c, verb=0x71f, para=0xff
[    3.942688] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x534c, verb=0xf1c, para=0x0
[    3.942697] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x8845, verb=0x71c, para=0xff
[    3.942707] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x8845, verb=0x71d, para=0xff
[    3.942717] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x8845, verb=0x71e, para=0xff
[    3.942727] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x8845, verb=0x71f, para=0xff
[    3.942736] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644:
hda-intel: Uh oh, too wide a NID value. codec=0x0, direct=0x0, nid
=0x8845, verb=0xf1c, para=0x0
----
Matt Mullins
