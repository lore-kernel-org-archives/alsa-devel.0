Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3A2CDB471
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:43:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82EFC601FD;
	Mon, 22 Jun 2026 09:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82EFC601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114204;
	bh=4deOcoLnw5/UDdVob8GOzejMXazeqQ8os2VNG68EORE=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CoA7E+225WcOAtJzL/YzC1b0Sfmuv6Y/snEvLW4oSwLjTNsj+8/uoTcuV2kfKoyqo
	 /AjAADlrf12RLTJN3WCkhMUAoZcoWn3QiXg7lnSp9Z+fOD3Uinx5cOzPelV02wvr4/
	 HdckiO5dIOEvks5yySo++lgbFGF+1z7/H3aJu7PM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13CAFF80609; Mon, 22 Jun 2026 09:42:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1132F8060D;
	Mon, 22 Jun 2026 09:42:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1849CF80301; Thu, 18 Jun 2026 00:52:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=79.148.128.221
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781736736;
	b=mW3aFD4nVDbDnPqqPzPhdm3q2z/HDmCP00l9ttMKCThza6PVLHQWVyyNs8riCDbN70YZ
	 cAn76lCLnXt7Za/i9Z8h5Ex6q1sj66/+hh0cf2NZsRcAN2qbqAqyIr8IBaRbVH7Nm1j/w
	 9oa4FQUrYUm82msTdxs3BUsOmgqbLgu6URfsMrIZ4EWs9+igrd/KkIUZdb0DeU8J4VZuF
	 qv6xWXEfH0FIks9HJlSPt+BB/ZcUSoaVP7TE7W33F1+uoS2Eq/YMRQwjl6XagHNX9cyNd
	 itr1H+hyw/NOK/dmklPYHUiEeSwveNJM9awcf2jZCdqoPjBZ5PNcmT5x22de1ZF3SMg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781736736;
	h=DKIM-Signature:Message-ID:Subject:From:To:Date:MIME-Version;
	bh=4deOcoLnw5/UDdVob8GOzejMXazeqQ8os2VNG68EORE=;
	b=gp65xFFQHcfrUAP5/iph51bi0MWEAG2WEvdzF3ht+L7hO5/N6HDP7HPkJ6tloevv5aFP
	 6bhC+ZAcOnj0aTwL37rwrxUtNIealwdv9d/54Yx8NRQDzg76tkDXHNjJqrFQBLCSmPF7B
	 FPp/C8DfqnKUgyMY46Jt5a8x9iudWBXaQwHd/cvEKe49mOFIGk3i7av7GApemrQBwGjnm
	 TIe0wkupSxxvzhtHIi7SdVxivhAYln5WqLLATtzFUSDuCIu65y21Yt5uNQRrKYYbJa81i
	 vQ0JLLzOVcmXiEgF8WPb+p5b2bO4EnMMKMv5QdkBIr34JkEf+4ox3nbAG/WVozlZqng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=fail reason="unknown key version" header.d=nylarea.com
 header.i=@nylarea.com header.a=rsa-sha256 header.s=dkim header.b=c8f9IWug;
	arc=none smtp.remote-ip=79.148.128.221
Received: from mail.nylarea.com (221.red-79-148-128.dynamicip.rima-tde.net
 [79.148.128.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91466F800BD
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2026 00:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91466F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="unknown key version" header.d=nylarea.com
 header.i=@nylarea.com header.a=rsa-sha256 header.s=dkim header.b=c8f9IWug
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34EE3390859C
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2026 00:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nylarea.com; s=dkim;
	t=1781736734; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=o38Ck5jCSwU7IPgJ528KBx7peFjKho8RH2/YZI3YwOg=;
	b=c8f9IWugtzXFhH1KP0er8H0V84n5KWmMU3uu8MRPVzO39AFBtGJTtzVa82R3Cgk4lSrUqv
	ZNIQDhGY9GgmB640t5tBRWtd18qClNznmpg3mgLRaxZCSlPvuROw/jB8UvemCOyVV1bWzm
	09PdtmdxbKu7rHryhZ0nRjIbcA99cFm0iQcSVhehw/srquDXKS/WHsb/0yIJ5cXG5hYBw3
	J+GcFwZsUGs4LFHCtYd+nfJ70Uqj2klQxIWpYc9SPa/7qBh79i338RTvT01CWbxqoPGhCJ
	HN1/c55EMSLsye2Bbzy+lpRE5rgk6pABYAdYE2ykX8fQwVwspmn9L8vHSJmpXA==
Message-ID: <558a2f650f0a6a40bc587db5a0889f53ed277e3a.camel@nylarea.com>
Subject: EDIROL UA-1000 driver module
From: NiLace <nilace@nylarea.com>
To: alsa-devel@alsa-project.org
Date: Thu, 18 Jun 2026 00:52:13 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: nilace@nylarea.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FUSMJ6BYGN5AQNIQONSIW5GCDXNENKWP
X-Message-ID-Hash: FUSMJ6BYGN5AQNIQONSIW5GCDXNENKWP
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:42:38 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FUSMJ6BYGN5AQNIQONSIW5GCDXNENKWP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

   First message and although I've searching for this I don't believe
this topic has been proposed. I'm writing to ask for a (I believe)
small modification on snd-ua101.

The driver handles audio on the EDIROL UA-1000 perfectly (which is
amazing, thank you), but MIDI control of the device doesn't work at
all, and I think I've found why: the UA-1000 wants its control messages
on USB-MIDI cable 1, while the driver hardcodes cable 0.

Here's what I found:

The UA-1000 (USB 0582:0044) is a 10x10 USB 2.0 interface from 2003.
Besides audio it has a built-in digital mixer, a patch bay/router and
direct monitoring, all driven by Roland SysEx (DT1) messages over its
USB-MIDI interface =E2=80=94 on Windows that's what the "UA-1000 Control Pa=
nel"
talks to. None of it is reachable from Linux today.

The device has 4 USB interfaces:
 - Interface 0: Control/mixer descriptors (no endpoints)
 - Interface 1: Audio capture (isochronous, EP 1 IN)
 - Interface 2: Audio playback (isochronous, EP 2 OUT)
 - Interface 3: MIDI control (bulk, EP 4 OUT + EP 3 IN)


The driver defines a fixed MIDI endpoint configuration:

   static const struct snd_usb_midi_endpoint_info midi_ep =3D {
       .out_cables =3D 0x0001,
       .in_cables  =3D 0x0001
   };

This configures MIDI on cable 0 (bit 0 set). However, the UA-1000
requires cable 1. I discovered this by capturing USB traffic from the
Windows XP driver using Wireshark/USBPcap while operating the official
EDIROL UA-1000 Control Panel software in a VirtualBox VM with USB
passthrough.

All SysEx messages captured from the Windows driver use USB-MIDI cable
1.
The cable number is encoded in the high nibble of each 4-byte USB-MIDI
packet's first byte (Code Index Number byte).

Here's an example, a captured Monitor Output Link On command:

   Raw USB-MIDI data (hex):
   14 f0 41 10  14 00 69 12  14 00 03 00  14 01 01 7b  15 f7 00 00

   Decoded packet-by-packet:

   Byte  Meaning
   ----  -------
   14    Cable 1 (high nibble =3D 0x1) | CIN 0x4 (SysEx start/continue)
   f0    SysEx start
   41    Roland manufacturer ID
   10    Device ID (default 0x10)

   14    Cable 1 | CIN 0x4
   00    Model ID byte 1
   69    Model ID byte 2 (0x00 0x69 =3D UA-1000)
   12    Command: DT1 (Data Set 1 =3D write)

   14    Cable 1 | CIN 0x4
   00    Address byte 1
   03    Address byte 2 (Monitor Output section)
   00    Address byte 3 (Left channel)

   14    Cable 1 | CIN 0x4
   01    Address byte 4 (Link parameter)
   01    Data (0x01 =3D on)
   7b    Roland checksum

   15    Cable 1 (high nibble =3D 0x1) | CIN 0x5 (SysEx ends with 1 byte)
   f7    SysEx end
   00    Padding
   00    Padding
  =20
If the device used cable 0, the high nibble of each packet would be
0x0_. All 18 capture files I have collected (input channel gain, pan,
solo, link, on/off, monitor output gain, monitor link, direct monitor
toggle, software control, and output volume mode) consistently show
cable 1.

I verified the fix by binary-patching the compiled snd-ua101.ko module.
At the offset where the midi_ep struct is stored, I changed:

   out_cables: 0x0001 -> 0x0002  (cable 0 -> cable 1)
   in_cables:  0x0001 -> 0x0002  (cable 0 -> cable 1)

   Before: 00 00 00 00 01 00 01 00
   After:  00 00 00 00 02 00 02 00

After loading the patched module, all SysEx commands are accepted by
the device. I have built a command-line control tool (ua1000ctl) that
successfully controls the UA-1000's mixer parameters via ALSA rawmidi,
including:

 - Monitor output volume (left, right, linked) =E2=80=94 confirmed working
 - Monitor link on/off =E2=80=94 confirmed working
 - Direct monitor on/off =E2=80=94 confirmed working
 - Input channel on/off, solo, link, pan, and gain =E2=80=94 addresses
identified

Audio capture and playback continue to work correctly with the patched
module and the MIDI port remains functional at hw:X,0,0 (subdevice 0).

I have 18 USB capture files covering all major SysEx command categories
and would be happy to share them if valuable.

To be transparent, I have relied heavily on Claude Code to help me in
several tasks I don't have the proper knowledge to do (and probably
would have not been able to implement). I have personally verified each
finding against the device but would like to be honest about it. I used
it for instance to analyze the USB captures, to inspect the device and
to modify a copy of the kernel module.=20

If it is still a possibility to ask for an update (or patch) of the
module, it would be amazing though.

Thank you.
