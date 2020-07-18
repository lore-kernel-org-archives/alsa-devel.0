Return-Path: <SRS0=PkW8=A5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C6C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2020 02:20:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8956C2073E
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2020 02:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oZhVmefT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cHUxdmoy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGJV2Vu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956C2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 134AB1669;
	Sat, 18 Jul 2020 04:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 134AB1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595038824;
	bh=Qz6f/IoW3TOUVU/QT++dWzRozd2pBNUZ0BL+l4LWR3M=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oZhVmefTLx4VS9mHb61wvdMECtQICwsof9Q+qeAdHZ3J84XPez6/5vG48wMH5g7tv
	 fmpwsbjGWqigLyVnb7wmt6BLa/HM77iQGAOQzyebrM8zwHmkQifd7VGmoUwOSgbK/5
	 2qhnEttC+69DaWVsWyLs5tN5vNwmr0EdBT2v35ss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83574F800E4;
	Sat, 18 Jul 2020 04:19:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAF0AF8016F; Sat, 18 Jul 2020 04:18:44 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DA69F80141
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2020 04:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DA69F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="cHUxdmoy"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kGJV2Vu3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id EB85B5C0058;
 Fri, 17 Jul 2020 22:18:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 17 Jul 2020 22:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm2; bh=2hgc/Xfa8g/li6Y2TjTHanxlG8RJaHByN8exfQgJJo0=; b=cHUxd
 moy3hFaaae9yshDXyVIUeuuuRJAEZjW53GxQwJIHZ85UbubJ1w+GE78M9eQEkBlJ
 bNZCGLeyCgvZCqPBLifCq0Pf9IGYac8ZS5k1RfJgF9kVwXbJWvWTeiy4sUWcHWWM
 bT9zrAxAWoWvjg771/YmonDNdAf+xzu6GiIIucqP3Qlj7Bsi0XF1wduKuMY9Fv8J
 OpH3DyJgL7DsaidlwCHgkPjd2iFLl+70kkVSrQSezDxSyJlffj1wCvQbVRqxA+2Y
 xcDIjanPrGOQYKKh0aS6c1MSOLEiy9gxSgE2XN1zUwGOz2i0AeEwjkXdZcjMOafE
 PClCPJG4KBKfvQxQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=2hgc/Xfa8g/li6Y2TjTHanxlG8RJa
 HByN8exfQgJJo0=; b=kGJV2Vu31UPkawpjg9hN6cPDZd30ipzoH8yDf1P3dHp4p
 fpyz7uvrVtXq+9oR+uKHWTnR5mumSJTu7AGkprWGsPtIqOZZYZe6BGWBMW9F8MW/
 BrGlg2gH/jsMp2Vq2+djWn6jj9vakpia8ZJMK4r+UQNvSZUI923edLwTI3nwHNA6
 FuN7BwMF8ZnyPwsMIufuNbV6L63L6JStP3AXrA0AwwyuiX0Ljm2BC8B3MgkwMioE
 Bu5saarMaj0UUnj76e+bLnbrtTVVly20Wea2nZERH5VNI6s5MG4xF9K8c/mFZw4S
 kP33fhjAIWzzvZaqAA4EJMHyxnsK0uvn48QMmYpOQ==
X-ME-Sender: <xms:9VsSX8_LI27AYobFOZuWzcKLeh4KgoSteXcOD5ZqNb6x6sMcS-_WvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeekgdehlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehttdertddttd
 dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetteekudfhkeeute
 fgteffffdvheeftdeiueevtdffuefhtdffvefgudevffeutdenucffohhmrghinhepghhi
 thhhuhgsrdgtohhmpdhgnhhomhgvrdhorhhgpdhruhhsthdqlhgrnhhgrdhorhhgpdgrlh
 hsrgdqphhrohhjvggtthdrohhrghenucfkphepudektddrvdefhedrfedrheegnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrsh
 hhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:9VsSX0vdI7u2OCs4sA2JcX6VFEX9E5BCXwPapqW5iF2rDr5ovZCFmQ>
 <xmx:9VsSXyDzmukVcxP79gl1qqeEt_1P8i2bzjH_VxSzZPU0-b0w5WLkYg>
 <xmx:9VsSX8ewy9NCmiFYj8TMMC3bk5CWO4chvKWqk3JXVP0A-iqd5Law7Q>
 <xmx:9VsSXzVU54Wehq41uX0Hm9Hs05VkyKIiThu7HiDSEVkZlGamHQJX5g>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id CF565306005F;
 Fri, 17 Jul 2020 22:18:27 -0400 (EDT)
Date: Sat, 18 Jul 2020 11:18:25 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: alsa-devel@alsa-project.org
Subject: [RFT] ALSA control service programs for Fireworks board module
Message-ID: <20200718021825.GA38653@workstation>
Mail-Followup-To: alsa-devel@alsa-project.org,
 ffado-devel@lists.sourceforge.net,
 linux-audio-dev@lists.linuxaudio.org, danjp@blinkusa.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: linux-audio-dev@lists.linuxaudio.org, ffado-devel@lists.sourceforge.net,
 danjp@blinkusa.com
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

Hi,

This is request-for-test (RFT) to the ALSA control service programs for
devices with Fireworks board module. The program is available in
'topic/service-for-efw' of below repository, and the RFT is corresponding
to Pull Request #2:

* https://github.com/alsa-project/snd-firewire-ctl-services/

If you have listed devices and handle them by ALSA fireworks driver, please
test the service program according to the below instruction.

  * Mackie (Loud) Onyx 1200F
  * Mackie (Loud) Onyx 400F
  * Echo Audio Audiofire 12 (till Jul 2009)
  * Echo Audio Audiofire 8 (till Jul 2009)
  * Echo Audio Audiofire 12 (since Jul 2009)
  * Echo Audio Audiofire 8 (since Jul 2009)
  * Echo Audio Audiofire 2
  * Echo Audio Audiofire 4
  * Echo Audio Audiofire Pre8
  * Gibson Robot Interface Pack (RIP) for Robot Guitar series

Background
----------

The models with Fireworks board module are already supported by ALSA
fireworks driver for their isochronous packet stream functionality
and vendor-specific transaction. Although the driver allows userspace
applications to process PCM frames and MIDI messages in the packet
streaming, it doesn't support the other functionalities such as volume
control since it can be achieved by any usespace application which
executes ioctl(2) to ALSA hwdep character device for the transaction.

The service program is to satisfy the demand to control the models.
ALSA control applications can request the control by IPC to the service
program.

In detail of mechanism, please read README.rst in the repository[1].
You can see some illustrations.

How to build
-------------

The project depends on several libraries in below repositories:

* glib[2]
* alsa-gobject v0.1.0[3]
* libhinawa v2.0.0[4]

Before building it, please install them with gobject-introspection support.

The project is written by Rust programming language[5] and packaged by
cargo[6]. To build, just run below commands in the environment to connect
to internet:

```
$ git clone https://github.com/alsa-project/snd-firewire-ctl-services.git -b topic/service-for-efw
$ cd snd-firewire-ctl-services
$ cargo build
```

All of required crates are downloaded automatically, then start build.

Executables
-----------

After building, `snd-fireworks-ctl-service` executable is available.

When running, the program adds and maintains control elements, then enter
event loop to dispatch events. The added elements are visible and manipulable
for any userspace applications. The program dispatch any manipulation
event for transactions to control actual device.

The executable has an option for the numerical ID of sound card.

```
Usage:
  snd-fireworks-ctl-service CARD_ID

  where:
    CARD_ID: The numerical ID of sound card.
```

It's easy to run the executable by cargo, like:

```
$ cargo run --bin snd-fireworks-ctl-service 2
```

Receiving SIGTERM signal terminates the event loop, then the program
finishes.

During runtime, any ALSA control applications can enumerate and manipulate
the added control elements. This is an example of Echo Audio AudioFire 2:

```
$ amixer -c 2 controls
numid=33,iface=MIXER,name='clock-detect'
numid=2,iface=MIXER,name='clock-rate'
numid=1,iface=MIXER,name='clock-source'
numid=36,iface=MIXER,name='input-meter'
numid=34,iface=MIXER,name='midi-in-detect'
numid=35,iface=MIXER,name='midi-out-detect'
numid=6,iface=MIXER,name='monitor-gain'
numid=7,iface=MIXER,name='monitor-gain',index=1
numid=8,iface=MIXER,name='monitor-gain',index=2
numid=9,iface=MIXER,name='monitor-gain',index=3
numid=10,iface=MIXER,name='monitor-gain',index=4
numid=11,iface=MIXER,name='monitor-gain',index=5
numid=12,iface=MIXER,name='monitor-mute'
numid=13,iface=MIXER,name='monitor-mute',index=1
numid=14,iface=MIXER,name='monitor-mute',index=2
numid=15,iface=MIXER,name='monitor-mute',index=3
numid=16,iface=MIXER,name='monitor-mute',index=4
numid=17,iface=MIXER,name='monitor-mute',index=5
numid=24,iface=MIXER,name='monitor-pan'
numid=25,iface=MIXER,name='monitor-pan',index=1
numid=26,iface=MIXER,name='monitor-pan',index=2
numid=27,iface=MIXER,name='monitor-pan',index=3
numid=28,iface=MIXER,name='monitor-pan',index=4
numid=29,iface=MIXER,name='monitor-pan',index=5
numid=18,iface=MIXER,name='monitor-solo'
numid=19,iface=MIXER,name='monitor-solo',index=1
numid=20,iface=MIXER,name='monitor-solo',index=2
numid=21,iface=MIXER,name='monitor-solo',index=3
numid=22,iface=MIXER,name='monitor-solo',index=4
numid=23,iface=MIXER,name='monitor-solo',index=5
numid=38,iface=MIXER,name='monitoring'
numid=37,iface=MIXER,name='output-meter'
numid=31,iface=MIXER,name='output-mute'
numid=30,iface=MIXER,name='output-volume'
numid=4,iface=MIXER,name='playback-mute'
numid=5,iface=MIXER,name='playback-solo'
numid=3,iface=MIXER,name='playback-volume'
numid=32,iface=MIXER,name='stream-playback-routing'
```

Access permissions for relevant character devices
--------------------------------------------------

The executable manipulates below character devices to dispatch, and emit
events from end to end. The '%u' is the numerical number of instance in
each subsystem:

 * ALSA control character device (/dev/snd/controlC%u)
 * ALSA hwdep character device (/dev/snd/hwC%uD%u)
 * Linux firewire character device (/dev/fw%u)

Feedback
--------

Any feedback is welcome. For questions, please use mailing list of alsa-devel
or alsa-users[7]. For issues, please use service of github.com[8].

Issues
------

The name of control elements are not fixed yet since the convention of
name for element set is not clear yet for recording equipment.

Users may feel inconvenience to which channel corresponds to which physical
port. Furthermore, in the case that element set includes several elements,
it's unclear that which element corresponds to which physical port as well.
ALSA control core has no feature for the above issues at present.

[1] https://github.com/alsa-project/snd-firewire-ctl-services
[2] https://gitlab.gnome.org/GNOME/glib
[3] https://github.com/alsa-project/alsa-gobject/
[4] https://github.com/alsa-project/libhinawa
[5] https://www.rust-lang.org/
[6] https://doc.rust-lang.org/cargo/
[7] https://www.alsa-project.org/wiki/Mailing-lists
[8] https://github.com/alsa-project/snd-firewire-ctl-services/issues


Regards

Takashi Sakamoto
