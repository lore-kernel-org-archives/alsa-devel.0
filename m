From: "Alexander Chemeris" <Alexander.Chemeris@sipez.com>
Subject: Re: "No codecs found" on Intel HDA + AD1988A
Date: Tue, 16 Dec 2008 01:28:04 +0300
Message-ID: <3d032e5d0812151428l3fe2be5cjdc8de81eb71ce5e1@mail.gmail.com>
References: <3d032e5d0812131057g71773bcam4b8a5832ea3bbba8@mail.gmail.com>
	<s5hskor15fj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 092591037EF
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 23:28:05 +0100 (CET)
Received: by bwz13 with SMTP id 13so9594336bwz.8
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 14:28:05 -0800 (PST)
In-Reply-To: <s5hskor15fj.wl%tiwai@suse.de>
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

Sorry for mail burst...

On Sun, Dec 14, 2008 at 12:17 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 13 Dec 2008 21:57:04 +0300,
> Alexander Chemeris wrote:
> Anyway, try to build with --debug=verbose configure option.  Usually
> you'll have a bit more messages.
> At least, you'll get a message like "codec_mask = 0xxxx" at probing.
> If the value is zero, it means that your hardware doesn't set the
> codec slot bit, usually a BIOS issue.

If I manually set codec_mask to 0xf I get following output:

[  634.273106] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[  634.273133] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  634.273138] ALSA alsa-kernel/pci/hda/hda_intel.c:2216: chipset
global capabilities = 0x4401
[  634.304568] ALSA alsa-kernel/pci/hda/hda_intel.c:786: Overriding
codecs probe mask
[  634.304574] ALSA alsa-kernel/pci/hda/hda_intel.c:793: codec_mask = 0xf
[  635.308511] ALSA alsa-kernel/pci/hda/hda_intel.c:633: hda_intel:
azx_get_response timeout, switching to polling mode: last
cmd=0x000f0000
[  636.313617] ALSA alsa-kernel/pci/hda/hda_intel.c:1277: hda_intel:
Codec #0 probe error; disabling it...
[  637.348012] ALSA alsa-kernel/pci/hda/hda_intel.c:1277: hda_intel:
Codec #1 probe error; disabling it...
[  638.384508] ALSA alsa-kernel/pci/hda/hda_intel.c:1277: hda_intel:
Codec #2 probe error; disabling it...
[  639.420508] ALSA alsa-kernel/pci/hda/hda_intel.c:1277: hda_intel:
Codec #3 probe error; disabling it...
[  639.452023] ALSA alsa-kernel/pci/hda/hda_intel.c:786: Overriding
codecs probe mask
[  639.452029] ALSA alsa-kernel/pci/hda/hda_intel.c:793: codec_mask = 0xf
[  640.456014] ALSA alsa-kernel/pci/hda/hda_intel.c:648: hda_intel:
azx_get_response timeout, switching to single_cmd mode: last
cmd=0x000f0000
[  640.457380] ALSA alsa-kernel/pci/hda/hda_intel.c:706: hda-intel:
get_response timeout: IRS=0x1
[  640.458587] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0xf0001
[  640.459641] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0xf0002
[  640.460709] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0xf0004
[  640.460716] ALSA
/home/ipse/packages/alsa-git/alsa-driver/pci/hda/hda_codec.c:783:
hda_codec: no AFG or MFG node found
[  640.462509] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x100f0000
[  640.463624] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x100f0000
[  640.464731] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x100f0001
[  640.465795] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x100f0002
[  640.466858] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x100f0004
[  640.466864] ALSA
/home/ipse/packages/alsa-git/alsa-driver/pci/hda/hda_codec.c:783:
hda_codec: no AFG or MFG node found
[  640.468730] ALSA alsa-kernel/pci/hda/hda_intel.c:688: hda-intel:
send_cmd timeout: IRS=0x1, val=0x200f0000
[  640.470038] ALSA
/home/ipse/packages/alsa-git/alsa-driver/pci/hda/hda_codec.c:783:
hda_codec: no AFG or MFG node found
[  640.471210] ALSA
/home/ipse/packages/alsa-git/alsa-driver/pci/hda/hda_codec.c:783:
hda_codec: no AFG or MFG node found
[  640.471217] ALSA alsa-kernel/pci/hda/hda_intel.c:1303: hda-intel:
no codecs initialized
[  640.472915] HDA Intel 0000:00:1b.0: PCI INT A disabled

So it looks  like codec is not present or is not recognized...
Is it possible, or my hardware looks like broken?

-- 
Regards,
Alexander Chemeris.

SIPez LLC.
SIP VoIP, IM and Presence Consulting
http://www.SIPez.com
tel: +1 (617) 273-4000
