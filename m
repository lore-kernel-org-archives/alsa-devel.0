From: "xinyun liu" <xinyunliu.osc@gmail.com>
Subject: Re: Can't record sound on Aser Aspire 5100. ATI SB450,
	RelTek ALC 883
Date: Sun, 29 Apr 2007 22:29:17 +0800
Message-ID: <afc365e50704290729n7d35c112uc363f7ebe4b9415@mail.gmail.com>
References: <afc365e50704290722s1867f059h3759d078607ed3ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 645FD24532
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2007 16:29:19 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so984617anc
	for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2007 07:29:18 -0700 (PDT)
In-Reply-To: <afc365e50704290722s1867f059h3759d078607ed3ad@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I know it's the system bios does not set the pin configuration right.
But I don't know how to try out a correct model.

Can anyone help to give some hints to fix it?


Regards,
Xinyun


2007/4/29, xinyun liu <xinyunliu.osc@gmail.com>:
> hi,
> I have an Acer Aspire 5100. I can play sound but with the build in
> mic, I can't record sound. The driver is the latest HG code.
> http://pastebin.ca/464406
>
> [root@localhost ~]# lspci -nnv -d1002:437b
> 00:14.2 0403: 1002:437b (rev 01)
>        Subsystem: 1025:009f
>        Flags: bus master, slow devsel, latency 64, IRQ 19
>        Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
>        Capabilities: [50] Power Management version 2
>        Capabilities: [60] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>
>
> [root@localhost ~]# dmesg | fgrep ALSA > /tmp/1
> [root@localhost ~]# vi /tmp/1
> ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
> codec_mask = 0xb
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:1820: hda_codec: model 'acer'
> is selected for config 1025:0 (Acer laptop)
> ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
> codec_mask = 0xb
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:1820: hda_codec: model 'acer'
> is selected for config 1025:0 (Acer laptop)
> ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x2, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x4, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x3, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x5, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x2, stream=0x0, channel=0, format=0x0
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x4, stream=0x0, channel=0, format=0x0
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x3, stream=0x0, channel=0, format=0x0
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x5, stream=0x0, channel=0, format=0x0
> ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x8, stream=0x1, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x8, stream=0x0, channel=0, format=0x0
> ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x2, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x4, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x3, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x5, stream=0x5, channel=0, format=0x11
> ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> NID=0x2, stream=0x0, channel=0, format=0x0
>
