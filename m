Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DFFC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Apr 2022 13:26:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80E461A9F;
	Wed, 20 Apr 2022 15:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80E461A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650461206;
	bh=Q3G8MZbnhCZ7U7nZqwaP+5HDyPc9tOB0ufaszvUGBrQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WQ5+h/RpFq2eIitNQBM93V+JFtHZl5ayK7Kh4rC03X0us1NPv0OeU/zlX3pRHRQf7
	 s+W8if1JmriFWjnEKa/Y+c/IV1VNyGa9HTCHZxy/iGcniOGK6+mXJpISK/aFp+xNTN
	 CcVeQ0u70fEcmK2wDVSnVIk8r35Tz9/28bWYBUIw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CF7AF80116;
	Wed, 20 Apr 2022 15:25:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9501DF80125; Wed, 20 Apr 2022 15:25:54 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69498F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 15:25:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69498F800C1
Received: (Authenticated sender: lumis@xulepth.fr)
 by mail.gandi.net (Postfix) with ESMTPSA id 5D824240012
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 13:25:44 +0000 (UTC)
From: "Simon Larcher" <lumis@xulepth.fr>
To: alsa-devel@alsa-project.org
User-Agent: SOGoMail 5.5.0
MIME-Version: 1.0
Date: Wed, 20 Apr 2022 15:25:44 +0200
Subject: =?utf-8?q?Proposal=3A?= MIDI instead of input device for Caiaq devices
Message-ID: <612e-62600a00-645-76afc200@261763543>
X-Forward: 127.0.0.1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

I'd like to suggest changing the snd-usb-caiaq driver module to send MI=
DI messages instead of emulating an input device. This proposal more pr=
ecisely refers to the Native Instruments Rig Kontrol 3 which I personal=
ly own. It's a 2in/2out USB sound card in a pedalboard housing with 8 f=
ootswitches and an expression pedal.

To me it makes more sense to use MIDI as the device is built for that p=
urpose. The configuration software provided by the manufacturer obvious=
ly doesn't work on Linux; but what it does is mapping the physical swit=
ches to MIDI messages.
On linux, as is the device emulates an input device that sends 1-9 keys=
trokes for the footswitches and reports a 3 axis joystick for the onboa=
rd pedal + the 2 external pedal inputs.
The onboard leds and 4 digits 7-segments display are available as contr=
ols (as listed by eg. amixer -c0 controls), this could also be changed =
to using MIDI as well.

I am hoping for this to be approved and am open to suggestions regardin=
g the implementation details.
More specifically if it makes more sense to use Note On/Off messages or=
 Controller Change messages, as well as the naming for the rawmidi inpu=
ts. The device will have two pairs of MIDI ports, one for the external =
I/O MIDI connectors and one for the "virtual" input reporting the butto=
n presses.

I have already started working on it and I have a very rough POC of thi=
s proposal, adding an extra MIDI device and sending a CC message when t=
he switches are pressed. It is available here: https://framagit.org/Sim=
on-L/snd-usb-caiaq
This has been discussed on #lad @ Libera.chat, I am registered as Fergu=
sL there.

Thanks!

SL
