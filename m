Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E98E7F140
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Sep 2023 22:15:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E800BA4A;
	Wed, 27 Sep 2023 00:14:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E800BA4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695766525;
	bh=tgul65nA1LHgQ/n7eLvoLoLsSd7pEBn54xQDxZlBtWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g+b16imbaznNFXsMus0PEtfOpjK42ohPK9XRMDPG2rno78gPVxL1pEzmQ/twLGNsP
	 0D3wo5NADqTC6EK7NYEkzJjwRDfg9+qtqKHhnjYwcMa1vLbkf0vjiqwFmSe6BNxFFD
	 0XGINxDnCGb8XtvO5hU1Z0CKjQ828l51yA/zZ6zU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4656BF8016A; Wed, 27 Sep 2023 00:14:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A138CF8016A;
	Wed, 27 Sep 2023 00:14:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02C0FF8007C; Wed, 27 Sep 2023 00:14:01 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81C20F8007C
	for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2023 00:13:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81C20F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gy710Oaj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=W9+0mXQngBmMf1pqe7YjNpjWOiwbacF2w74/QFywDXI=; b=gy710OajdKs4saq4mJiIDZf7rl
	qow3H270dpmNhxdmoheU4OLNygl2NqYiy52pqawhcoMfN99wfYhOmgcIGHKHsXWHZj/s8llr77K+v
	f54wSqrTE4frThfYnvosAHIxGR45gUM/gZPjDXXBXytPtLjSnBBidtap0qkuPpLJkO7mVcOWioWta
	ES2ZURP8/YiRkhud6RbvUkK16R1n81kFW7mrsqqhVIAmHYDYobbJKB8n3J29f2hyXLvhfAnSSQs+v
	a6Uuj9BmJ/GqLHjLk2wxoobjf3oUnmMa9ece7FEkbH/Dv2kAS99IyhIN6PYiTiP6zft5TbsgdGk5y
	Gk/9om/A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qlGJO-00H65b-1i;
	Tue, 26 Sep 2023 22:13:46 +0000
Message-ID: <40672e60-3913-4794-b84a-742b7c16d361@infradead.org>
Date: Tue, 26 Sep 2023 15:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ryzen 9 7950x sound module does not not build
Content-Language: en-US
To: sboyce@blueyonder.co.uk, Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ALSA <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
 <ZRLWIkyngsasQbQ7@debian.me>
 <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: J5SPOYUOCINGE7UT3J3VOOHALAEXEJPA
X-Message-ID-Hash: J5SPOYUOCINGE7UT3J3VOOHALAEXEJPA
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 9/26/23 12:17, Sid Boyce wrote:
> On 26/09/2023 14:01, Bagas Sanjaya wrote:
>> [also Cc'ing alsa ML and related maintainers]
>>
>> On Tue, Sep 26, 2023 at 01:23:13PM +0100, Sid Boyce wrote:
>>> I've since rebooted and did a modprobe. No idea why it isn't automatically
>>> loaded.
>>>
>>> #modinfo snd-rpl-pci-acp6x
>>> filename:       /usr/lib/modules/6.6.0-rc3-vanilla/kernel/sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko.gz
>>> license:        GPL v2
>>> description:    AMD ACP RPL PCI driver
>>> srcversion:     0F909BC61165681426ECEEB
>>> alias:          pci:v00001022d000015E2sv*sd*bc04sc80i00*
>>> depends:
>>> retpoline:      Y
>>> intree:         Y
>>> name:           snd_rpl_pci_acp6x
>>> vermagic:       6.6.0-rc3-vanilla SMP preempt mod_unload modversions
>>>
>>> # modprobe snd-rpl-pci-acp6x
>>>
>>> #lsmod|grep snd
>>> snd_rpl_pci_acp6x      16384  0
>>> snd_seq_dummy          12288  0
>>> snd_hrtimer            12288  1
>>> snd_seq               131072  7 snd_seq_dummy
>>> snd_hda_codec_realtek   192512  1
>>> snd_hda_codec_hdmi     94208  1
>>> snd_hda_codec_generic   110592  1 snd_hda_codec_realtek
>>> snd_hda_intel          65536  2
>>> snd_usb_audio         458752  2
>>> snd_intel_dspcfg       40960  1 snd_hda_intel
>>> snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
>>> snd_hda_codec         233472  4
>>> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
>>>
>>> snd_usbmidi_lib        49152  1 snd_usb_audio
>>> snd_hda_core          147456  5 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
>>>
>>> snd_ump                36864  1 snd_usb_audio
>>> snd_rawmidi            57344  2 snd_usbmidi_lib,snd_ump
>>> snd_seq_device         16384  3 snd_seq,snd_ump,snd_rawmidi
>>> mc                     94208  1 snd_usb_audio
>>> snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
>>> snd_pcm               225280  6
>>> snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
>>> snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
>>> ledtrig_audio          12288  2 snd_hda_codec_generic,asus_wmi
>>> snd                  163840  23 snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_ump,snd_pcm,snd_rawmidi
>>>
>>> soundcore              16384  1 snd
>>> usbcore               446464  6
>>> xhci_hcd,snd_usb_audio,usbhid,snd_usbmidi_lib,btusb,xhci_pci
>>>
>> Any errors on dmesg when loading snd-rpl-pci-acp6x module?
>>
> The full .config.

Your .config file also builds with no problems, so I guess that the issue
is not about building but about auto-loading and finding the device.

I think that what we are missing (first) is the output of 'lspci -vv',
at least for the PCI sound device in question.
The snd-rpl-pci-acp6x driver only supports
vendor=0x1022, device=0x15e2, and PCI revision=0x62.


-- 
~Randy
