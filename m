From: maillist@superlative.org
Subject: Re: Boss GT-001
Date: Mon, 05 Oct 2015 14:43:06 +0100
Message-ID: <2448573.QHGoo2Q6JJ@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <90207636.43oDPcFcXs@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A61626059A
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 15:43:11 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so115078443wic.0
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 06:43:08 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id jv5sm26137776wjb.16.2015.10.05.06.43.07
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 05 Oct 2015 06:43:07 -0700 (PDT)
In-Reply-To: <90207636.43oDPcFcXs@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 21 Sep 2015 11:22:18 maillist@superlative.org wrote:
> On Friday 18 Sep 2015 21:03:15 maillist@superlative.org wrote:
> > I recently got access to a Boss GT-001. This is a small USB audio
> > Interface
> > for guitar with onboard FX which doesn't work with ALSA under Linux Mint
> > 17
> > (running kernel 3.16.0-38-generic).
> 
 
<SNIP>

More follow up. I've upgraded the kernel to 4.0.0-040000-generic with no 
improvement. I've recompiled the usb sound modules with debug support and am 
getting the following. Note that I'm getting a probe failure with error code 
-5. Is there any reference anywhere for what these errors are?

Oct  5 13:51:47 KAMDesktop kernel: [  910.443578] usb 3-1: new high-speed USB 
device number 6 using ehci-pci
Oct  5 13:51:47 KAMDesktop kernel: [  910.586067] usb 3-1: New USB device 
found, idVendor=0582, idProduct=0187
Oct  5 13:51:47 KAMDesktop kernel: [  910.586071] usb 3-1: New USB device 
strings: Mfr=1, Product=2, SerialNumber=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.586073] usb 3-1: Product: GT-001
Oct  5 13:51:47 KAMDesktop kernel: [  910.586075] usb 3-1: Manufacturer: BOSS
Oct  5 13:51:47 KAMDesktop kernel: [  910.586812] snd-usb-audio: probe of 
3-1:1.0 failed with error -5
Oct  5 13:51:47 KAMDesktop kernel: [  910.587438] ALSA stream.c:711 6:1:1: add 
audio endpoint 0xd
Oct  5 13:51:47 KAMDesktop kernel: [  910.587688] ALSA stream.c:711 6:2:1: add 
audio endpoint 0x8e
Oct  5 13:51:47 KAMDesktop mtp-probe: checking bus 3, device 6: 
"/sys/devices/pci0000:00/0000:00:1a.7/usb3/3-1"
Oct  5 13:51:47 KAMDesktop mtp-probe: bus: 3, device: 6 was not an MTP device
Oct  5 13:51:47 KAMDesktop kernel: [  910.588115] snd-usb-audio: probe of 
3-1:1.3 failed with error -5
Oct  5 13:51:47 KAMDesktop kernel: [  910.603135] ALSA pcm.c:376 setting usb 
interface 2:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.603138] ALSA endpoint.c:442 Creating 
new capture data endpoint #8e
Oct  5 13:51:47 KAMDesktop kernel: [  910.603160] ALSA endpoint.c:821 Setting 
params for ep #8e (type 0, 8 urbs), ret=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.606512] ALSA pcm.c:376 setting usb 
interface 1:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.606514] ALSA endpoint.c:442 Creating 
new playback data endpoint #d
Oct  5 13:51:47 KAMDesktop kernel: [  910.606517] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.606533] ALSA endpoint.c:821 Setting 
params for ep #d (type 0, 8 urbs), ret=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.606535] ALSA pcm.c:541 
match_endpoint_audioformats: (fmt @ffff8804a98e9ca8) score 2
Oct  5 13:51:47 KAMDesktop kernel: [  910.606538] ALSA endpoint.c:821 Setting 
params for ep #8e (type 0, 8 urbs), ret=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.606539] ALSA pcm.c:229 Starting data 
EP @ffff8803d6f54028
Oct  5 13:51:47 KAMDesktop kernel: [  910.606595] ALSA pcm.c:258 Starting sync 
EP @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.615766] ALSA pcm.c:376 setting usb 
interface 2:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.615779] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.615792] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.615821] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.615824] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.615842] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.615845] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.615980] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.615983] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616078] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616081] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616490] ALSA pcm.c:376 setting usb 
interface 2:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.616492] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616497] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616512] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616514] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616530] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616533] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616629] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616632] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.616754] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.616758] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617110] ALSA pcm.c:376 setting usb 
interface 2:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.617112] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617127] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617155] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617158] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617203] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617207] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617358] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617361] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617488] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617492] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617895] ALSA pcm.c:376 setting usb 
interface 2:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.617897] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617910] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.617943] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.617949] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.618005] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.618012] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.618192] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.618199] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.618354] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.618363] ALSA endpoint.c:786 Unable 
to change format on ep #8e: already in use
Oct  5 13:51:47 KAMDesktop kernel: [  910.623280] ALSA pcm.c:376 setting usb 
interface 1:1
Oct  5 13:51:47 KAMDesktop kernel: [  910.623284] ALSA endpoint.c:434 Re-using 
EP d in iface 1,1 @ffff8803d6f54028
Oct  5 13:51:47 KAMDesktop kernel: [  910.623285] ALSA endpoint.c:434 Re-using 
EP 8e in iface 2,1 @ffff88041cb74028
Oct  5 13:51:47 KAMDesktop kernel: [  910.623308] ALSA endpoint.c:821 Setting 
params for ep #d (type 0, 8 urbs), ret=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.623310] ALSA pcm.c:541 
match_endpoint_audioformats: (fmt @ffff8804a98e9ca8) score 2
Oct  5 13:51:47 KAMDesktop kernel: [  910.623315] ALSA endpoint.c:821 Setting 
params for ep #8e (type 0, 8 urbs), ret=0
Oct  5 13:51:47 KAMDesktop kernel: [  910.623316] ALSA pcm.c:229 Starting data 
EP @ffff8803d6f54028
Oct  5 13:51:47 KAMDesktop kernel: [  910.623398] ALSA pcm.c:258 Starting sync 
EP @ffff88041cb74028
