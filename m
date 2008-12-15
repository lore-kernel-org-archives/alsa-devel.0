From: "Alexander Chemeris" <Alexander.Chemeris@sipez.com>
Subject: Re: "No codecs found" on Intel HDA + AD1988A
Date: Tue, 16 Dec 2008 00:25:42 +0300
Message-ID: <3d032e5d0812151325o22945f7dy34ba87e6e9c955de@mail.gmail.com>
References: <3d032e5d0812131057g71773bcam4b8a5832ea3bbba8@mail.gmail.com>
	<s5hskor15fj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 010B51037EF
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 22:25:43 +0100 (CET)
Received: by bwz13 with SMTP id 13so9486406bwz.8
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 13:25:43 -0800 (PST)
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

On Sun, Dec 14, 2008 at 12:17 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 13 Dec 2008 21:57:04 +0300,
> Alexander Chemeris wrote:
>> I have Asus P5B-V motherboard with integrated Intel HDA
>> audio and AD1988A codec (I see the chip on the board).
>> About half a year ago or so it used to work, but now when
>> snd-hda-intel module is loaded it claims it can't find a codec:
>>
>> $ dmesg | grep -i hda
>> [   13.648205] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
>> low) -> IRQ 22
>> [   13.648236] HDA Intel 0000:00:1b.0: setting latency timer to 64
>> [   13.680537] hda-intel: no codecs found!
>> [   13.680589] HDA Intel 0000:00:1b.0: PCI INT A disabled
>>
>> I tried different recent versions of ALSA to no avail.
>> So far I've tried:
>>
>> * 1.0.17 with Ubuntu patches
>> * 1.0.18 with Ubuntu patches
>> * 1.0.18a downloaded half an hour ago from here:
>>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>>
>> I also tried to compile 1.0.16, but seems it is not compatible
>> with the kernel:
>>
>> $ uname -a
>> Linux nidus 2.6.27-10-generic #1 SMP Fri Nov 21 19:19:18 UTC 2008
>> x86_64 GNU/Linux
>>
>> When I tried 1.0.18a, I also manually loaded snd-hda-codec_analog before
>> loading snd-hda-intel without any success.
>
> Note that it's not 1.0.18a but a shapshot version.

*nod* Got it.

> Anyway, try to build with --debug=verbose configure option.  Usually
> you'll have a bit more messages.
> At least, you'll get a message like "codec_mask = 0xxxx" at probing.
> If the value is zero, it means that your hardware doesn't set the
> codec slot bit, usually a BIOS issue.

You were right:

[166020.570348] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[166020.570375] HDA Intel 0000:00:1b.0: setting latency timer to 64
[166020.570380] ALSA alsa-kernel/pci/hda/hda_intel.c:2205: chipset
global capabilities = 0x4401
[166020.600518] ALSA alsa-kernel/pci/hda/hda_intel.c:782: codec_mask = 0x0
[166020.600530] ALSA alsa-kernel/pci/hda/hda_intel.c:2279: hda-intel:
no codecs found!
[166020.600584] HDA Intel 0000:00:1b.0: PCI INT A disabled

>From googling I found that this is a common problem with
ASUS P5B mobo. How this can be solved or workarounded?

-- 
Regards,
Alexander Chemeris.

SIPez LLC.
SIP VoIP, IM and Presence Consulting
http://www.SIPez.com
tel: +1 (617) 273-4000
