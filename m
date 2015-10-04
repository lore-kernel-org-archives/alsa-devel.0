From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: USB audio device startup question
Date: Sun, 4 Oct 2015 06:45:33 +0200
Message-ID: <alpine.DEB.2.02.1510040630150.25833@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 73E1F2606F8
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 18A901806C
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:38 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DsF+CBZIXChi for <alsa-devel@alsa-project.org>;
 Sun,  4 Oct 2015 06:45:37 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 150F718068
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:36 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id B79BC13EB
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:36 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 7AF01814
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:36 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 7910C34009
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 06:45:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


(This is in reference to getting the Zoom R16 to work, but the main query =

in this post is of a more general nature).

In trying to get a Zoom R16 in audio interface mode to work in Linux I'm =

trying to understand how the USB-audio (snd-usb-audio module) subsystem =

works in Linux. I've looked in the USB audio version 1 and 2 documents, as =

well as the USB 2.0 standard, but there are some things that don't seem to =

be well defined there, like exactly how the audio data is packaged in the =

isochronous transfer packets.

I've been using Wireshark to visualize the USB communication, and also =

comparing with the corresponding transfers on a Windows box by dumping the =

traffic with USBPcap.

The only other USB audio interface I have access to here is an Edirol =

UA-5. I've noted that when plugging in the UA-5, there's period of about =

15 seconds during which capture and playback are set up and audio data =

transferred, after which the interface is shut down again. When enabling =

the R16, during the corresponding initial period I see playback data but =

no capture data during this phase. I don't know if that is significant or =

not, for instance, if the lack of capture data during this phase is =

because the playback is not working as it should.

My question is: what governs this startup phase, can someone point to a =

specific part of the code or some documentation describing what is =

supposed to go on here? Is it some sort of device test period to determine =

that the device actually works?

The problem with the R16 is that although capture works fine, playback =

doesn't result in any audio. With the correct quirk set up (most =

importantly, using a 24 bit format), aplay appears to work fine with no =

errors, neither are there any complaints from dmesg, and looking at the =

communication I can see outgoing isochronous data from the host being =

transferred fine.

More work needs to be done, but I've looked at the startup of the Windows =

driver which is deceptively simple: it basically just sets the =

appropriate capture and playback interfaces, together with sending off =

some sample rate USB control commands, the isochronous link comes up and =

that seems to be it. I've tried to emulate the specific USB control =

commands in Linux, as well as add some delays that there appear to be in =

the Windows driver, but so far it hasn't made a difference.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
