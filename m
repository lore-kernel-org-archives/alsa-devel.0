Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4ECCA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:55:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0417C206B9
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ddr9CUN9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pr6Oisbs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2VMtpSwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0417C206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AFC416BD;
	Tue, 12 May 2020 18:54:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AFC416BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589302503;
	bh=/8ly33Evp4/EJF23ZWG6y3umA1CwgFhXWcJXjkFc83M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddr9CUN9g3y8q+cGqKq419kXMQcuq5qr6b6rdo4xlR9YT0YqisLk/IC8I/eC6dAly
	 k/bkvxEMeN6FyCTFxHQVh8doQKb2S7L0t9NSw86NKLViYUsWbqL+yl/FGO8PfrDnjo
	 tYfsxTaqXdVKgmOP3djWdIoknwnq1j36ltc0rcnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 888E4F800E3;
	Tue, 12 May 2020 18:54:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A282F8014C; Tue, 12 May 2020 18:54:11 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81E9BF800AA
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 18:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81E9BF800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com
 header.b="pr6Oisbs"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="2VMtpSwv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id D0ADF5C019F;
 Tue, 12 May 2020 12:54:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 12 May 2020 12:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=4/tfq2igpNuxv4aA+nGHYw22FQD
 X91w+d5HmJd7P4yY=; b=pr6OisbsjLrafXSJjIFsCqzm6M4bSSkNq1GFb/shoIi
 I39/9DDoEmUbaOoBSp6dWU+2ysB3sNvwthZqBF7GMJB4PBcZylWkb+pyvTkFKNRG
 RFhGg5G6BrnYydK2ZmRTSkQ0aqvsstAQrebW2WW3TBqWLwcJjjjQZSYUFnx8d0LR
 BWsl1JVZpHUbi3lfli0xna+kgdJ14URDLpH8ropBEAGghc5svn3kFOdHFXSd6Gtd
 9vX3em9br1TArrbw8uoFtaJ0dhtk80If9VQY9R6GUv5cP2RYH4QWLowdoxItx7i6
 RXwDpF46bpE1XMCJcTAX8dI7ItkKIGBalNQWkc93plg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4/tfq2
 igpNuxv4aA+nGHYw22FQDX91w+d5HmJd7P4yY=; b=2VMtpSwvhgd0V2Fm8szaXO
 IrsuvVrSNAjEef/5hdxkJz9SRijfsO/dluBW/gs7mNgvg3kH5ZScSadJv40uJ1JV
 6dvBb9cnlGuMEzuZgulSGgshPdR12On6PjwAQ0WsObEch2ZF5ThiYoM1UVd1J062
 dDRquyBVK+ygDYGLmajlBNEQ5hGhFAZ/N+sfcc2Zf4NBGVDHrnFNtcufoge6Qnlb
 qe6XpYcovxWxRbUObQxQNAdruTG6GR9jbo2ovbR809otYy7UfyOnK/0J40U/vcE1
 0YFOM78XoiWYeGJDRS7s0XBAy9wTw8odvuOlDBZPlmBeRJXS8ZmbDdF/2/kggVdQ
 ==
X-ME-Sender: <xms:qdS6XmNhKN5cYz-Mz5c5i_LqBthO0UD_8LFX9dY8ESLzIsr3F--EpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrledvgddutdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
 mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
 fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
 rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:qdS6Xk-F6scWqGnbgZtNJKLZi5gxyZwrDi9Jp6g7Od_chYomSnPukw>
 <xmx:qdS6XtQU1DAuyBmdaAl33Qx12vjeOnd1mqTVJ4KkbMCsflJDM_iOFw>
 <xmx:qdS6XmvCVqWbr44hj0JnWMFAnMO69gZl8-er3qMhskptqh-pfj9b4Q>
 <xmx:qdS6Xml4N9tLozPCz_quaHcMszOrkOgh0GhYlSlXXi7bQQdCFDRd6A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id DD5B530662D6;
 Tue, 12 May 2020 12:54:00 -0400 (EDT)
Date: Tue, 12 May 2020 18:53:59 +0200
From: Greg KH <greg@kroah.com>
To: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Subject: Re: sound over USB
Message-ID: <20200512165359.GA702234@kroah.com>
References: <CAPY=qRRFV4SpNO5pb9vF=U95dbA_gN2ngP+vm34884NMk5q8gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY=qRRFV4SpNO5pb9vF=U95dbA_gN2ngP+vm34884NMk5q8gQ@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, May 12, 2020 at 10:13:10PM +0530, Subhashini Rao Beerisetty wrote:
>  Hi all,
> 
> In my Linux machine, I connected the plantronics usb headset with mic
> and I see(with the help of dmesg) that this device detected.
> 
> 
> 
> [116676.507868] usb 2-2: new full-speed USB device number 5 using xhci_hcd
> [116676.923445] usb 2-2: New USB device found, idVendor=047f, idProduct=c012
>  [116676.927091] usb 2-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
>  [116676.934252] usb 2-2: Product: Plantronics .Audio 628 USB
>  [116676.941445] usb 2-2: Manufacturer: Plantronics
>  [116676.945731] usb 2-2: ep 0x84 - rounding interval to 64
> microframes, ep desc says 80 microframes
>  [116677.078071] hidraw: raw HID events driver (C) Jiri Kosina
>  [116677.159669] usbcore: registered new interface driver usbhid
>  [116677.161686] usbhid: USB HID core driver
>  [116677.175458] input: Plantronics Plantronics .Audio 628 USB as
> /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.3/0003:047F:C012.0001/input/input4
>  [116677.234588] plantronics 0003:047F:C012.0001:
> input,hiddev0,hidraw0: USB HID v1.00 Device [Plantronics Plantronics
> .Audio 628 USB] on usb-0000:00:14.0-2/input3
>  [116677.281756] usbcore: registered new interface driver snd-usb-audio
> 
>  The following nodes are present in the /dev/snd
> 
> $ ls -l /dev/snd/
> 
> total 0
> 
> drwxr-xr-x 2 root root       60 May 12 11:32 by-id
> 
> drwxr-xr-x 2 root root       60 May 12 11:32 by-path
> 
> crw-rw---- 1 root audio 116,  2 May 12 11:32 controlC1
> 
> crw-rw---- 1 root audio 116,  4 May 12 11:32 pcmC1D0c
> 
> crw-rw---- 1 root audio 116,  3 May 12 11:32 pcmC1D0p
> 
> crw-rw---- 1 root audio 116,  1 May 12 11:32 seq
> 
> crw-rw---- 1 root audio 116, 33 May 12 11:32 timer
> 
> 
> 
> What are all these devices present in /dev/snd
> 
> How do I use it for playing and recording an audio?
> 
> Basically first I want to gain knowledge on set of test cases I can
> run on ALSA and then learn ALSA kernel modules stuff including
> snd_usb_audio mdule.
> 
> So please guide me by providing related documentation/Steps.

ALSA should "just work" with this device, no need to do anything to the
kernel driver.  Does it not work properly for you as-is?

thanks,

greg k-h
