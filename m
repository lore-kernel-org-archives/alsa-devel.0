Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367EDCD5BD2
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 02:14:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0FDD6024E;
	Wed, 27 May 2026 04:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0FDD6024E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779848059;
	bh=SlstKGotvkTv2G3C97uj5RUdyUVtAZ1dWnrfmp12mYw=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cBLAZhVW3EECA4UZ9tuubzAcaSc3pIHM2em55XoqLaUxnL8ibFC2Wp8y4NKjuTeTG
	 aIZl6fUoIHwzMhmhOfu0ZwqX/f702Ngp1yKgxCeY1y0dLPLIwDXANCdH9JGrQMGQha
	 7YmpmfKBXhkb0C3je14Js8iVjm3k7BbJS+PICjKo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EA81F805F3; Wed, 27 May 2026 04:13:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2919F805E8;
	Wed, 27 May 2026 04:13:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD859F804FF; Wed, 27 May 2026 04:13:41 +0200 (CEST)
Received: from quail.birch.relay.mailchannels.net
 (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C37A0F80246
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 04:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C37A0F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=KIE9oK32
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 221BE4C1CAF
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 02:13:35 +0000 (UTC)
Received: from barmail5.idig.net (trex-green-9.trex.outbound.svc.cluster.local
 [100.101.152.156])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id C55574C1472
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 02:13:34 +0000 (UTC)
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Trail-Madly: 23fe553e698ba6df_1779848015033_3058080740
X-MC-Loop-Signature: 1779848015033:831699295
X-MC-Ingress-Time: 1779848015033
Received: from barmail5.idig.net (barmail5.idig.net [104.36.151.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.152.156 (trex/7.1.5);
	Wed, 27 May 2026 02:13:35 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail5.idig.net with ESMTP id W7NClX8SWZ5UNCWz
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for
 <alsa-devel@alsa-project.org>; Tue, 26 May 2026 19:13:34 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Type:Message-ID:Subject:To:From:Date:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LTI2WcN2v5f9IdrkqMRxY15mfmYDCkryhfxGYWWaNzU=; b=KIE9oK323ExaIblsnO7Y36sRca
	DGy+LRGFIYA/fdRK8vvBMk7d1HjBl9v8k3k63XZdAp1PjDTdgRrAM34O1R9a9hz8pQ+sNtLvJ9k4b
	xPukEn9UfsYdsE7D5lyMv3m7ETvuvNPsZEzZtdjIq+g0ghgXyZsjiEUWqyoaohnWNl3R8qpjIVt8x
	9fRIRj2C6xNpOldKw9OSzvF4V1gv92NOpdifH6I5SiyYKTMujUeY0AARSeoXnLSEcdmztz4QYb4h5
	1z+RbgEPHeLjGjVFPoElCm79vIcuxrNwfYcLdjjoK/RWpqxycHh9TYSQ+LVlieqCaOEIQccRq4+d7
	x/yPu8JQ==;
Received: from [::1] (port=24030 helo=cwh28.canadianwebhosting.com)
	by cwh28.canadianwebhosting.com with esmtpa (Exim 4.99.2)
	(envelope-from <simon@mungewell.org>)
	id 1wS3m2-0000000Cosc-2oEc
	for alsa-devel@alsa-project.org;
	Tue, 26 May 2026 22:13:33 -0400
MIME-Version: 1.0
Date: Tue, 26 May 2026 22:13:33 -0400
From: simon@mungewell.org
To: Alsa Devel <alsa-devel@alsa-project.org>
Subject: M-Audio C600 - SPDIF weirdness
User-Agent: Roundcube Webmail/1.6.15
X-ASG-Orig-Subj: M-Audio C600 - SPDIF weirdness
Message-ID: <99edd616bb6bb7d20fb8a3ef68b87921@mungewell.org>
X-Sender: simon@mungewell.org
Content-Type: multipart/mixed;
 boundary="=_68caa8019afc25ed0317f004e1cc7af7"
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1779848014
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.219:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 1702
X-ASG-Debug-ID: 1779848013-13d5ac78de179b60001-UKjUFf
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No,
 SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=8.0
 KILL_LEVEL=4.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ----------------------
 --------------------------------------------------
	 0.00 NO_REAL_NAME           From: does not include a real name
Message-ID-Hash: 4YKYESA3R6GEGYEPTJAMOS7IIE4GYXT5
X-Message-ID-Hash: 4YKYESA3R6GEGYEPTJAMOS7IIE4GYXT5
X-MailFrom: simon@mungewell.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YKYESA3R6GEGYEPTJAMOS7IIE4GYXT5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--=_68caa8019afc25ed0317f004e1cc7af7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi all,
In attempting to validate a 'live mixer' application for the C600, I 
noticed some weirdness I can't explain. This weirdness may indicate an 
issue with the driver.

1). Device is a 8-ch output, ch 1-6 are analogue outputs (balanced TRS) 
and ch7/8 are sent out of the SPDIF port.

'aplay -L' shows a SPDIF output, but this does NOT accept 2 channel out 
and DOES accept 8 channel output
---
$ aplay sin1k.wav -D "iec958:CARD=C600,DEV=0"
Playing WAVE 'sin1k.wav' : Signed 24 bit Little Endian in 3bytes, Rate 
48000 Hz, Stereo
aplay: set_params:1377: Channels count non available
---
$ aplay sin1k.wav -D "iec958:CARD=C600,DEV=0"
Playing WAVE 'sin1k.wav' : Signed 24 bit Little Endian in 3bytes, Rate 
48000 Hz, Channels 8
^CAborted by signal Interrupt...
--
With 8-ch output, the analogue (TRS) outputs the audio as well as the 
SPDIF output.


2). When a 'loop back' cable is used (from SPDIF out -> SPDIF in), you 
must (repeatably) select 'clock source' as 'SPDIF' and then something 
can be heard - but it is NOT the proper audio, it's a few clicks which 
suggests C600 can not sync/decode it's own output.

If the 'clock source' is internal, there is no audio captured.


3). If the C600's SPDIF output is connected to a 2nd device (Digi002R) 
then the audio DOES decode properly, and if I make connections (in Jack) 
to loop Digi's SPDIF IN -> Digi's SPDIF Out the received SPDIF at the 
C600 sounds correct too...

The Digi002R is running at 48KHz (same a C600), but I don't know what 
bit-depth. I don't see any place to change this within qJackCtrl.


Any suggestions as to what might be going on with the loop-back 
'clicking audio'?
Simon
--=_68caa8019afc25ed0317f004e1cc7af7
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=arecord_C600_devices.txt
Content-Disposition: attachment;
 filename=arecord_C600_devices.txt;
 size=510

aHc6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRGly
ZWN0IGhhcmR3YXJlIGRldmljZSB3aXRob3V0IGFueSBjb252ZXJzaW9ucwpwbHVnaHc6Q0FSRD1D
NjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgSGFyZHdhcmUgZGV2
aWNlIHdpdGggYWxsIHNvZnR3YXJlIGNvbnZlcnNpb25zCnN5c2RlZmF1bHQ6Q0FSRD1DNjAwCiAg
ICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRGVmYXVsdCBBdWRpbyBEZXZpY2UKZnJv
bnQ6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRnJv
bnQgb3V0cHV0IC8gaW5wdXQKZHNub29wOkNBUkQ9QzYwMCxERVY9MAogICAgRmFzdCBUcmFjayBD
NjAwLCBVU0IgQXVkaW8KICAgIERpcmVjdCBzYW1wbGUgc25vb3BpbmcgZGV2aWNlCnVzYnN0cmVh
bTpDQVJEPUM2MDAKICAgIEZhc3QgVHJhY2sgQzYwMAogICAgVVNCIFN0cmVhbSBPdXRwdXQK
--=_68caa8019afc25ed0317f004e1cc7af7
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=aplay_C600_devices.txt
Content-Disposition: attachment;
 filename=aplay_C600_devices.txt;
 size=1320

aHc6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRGly
ZWN0IGhhcmR3YXJlIGRldmljZSB3aXRob3V0IGFueSBjb252ZXJzaW9ucwpwbHVnaHc6Q0FSRD1D
NjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgSGFyZHdhcmUgZGV2
aWNlIHdpdGggYWxsIHNvZnR3YXJlIGNvbnZlcnNpb25zCnN5c2RlZmF1bHQ6Q0FSRD1DNjAwCiAg
ICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRGVmYXVsdCBBdWRpbyBEZXZpY2UKZnJv
bnQ6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRnJv
bnQgb3V0cHV0IC8gaW5wdXQKc3Vycm91bmQyMTpDQVJEPUM2MDAsREVWPTAKICAgIEZhc3QgVHJh
Y2sgQzYwMCwgVVNCIEF1ZGlvCiAgICAyLjEgU3Vycm91bmQgb3V0cHV0IHRvIEZyb250IGFuZCBT
dWJ3b29mZXIgc3BlYWtlcnMKc3Vycm91bmQ0MDpDQVJEPUM2MDAsREVWPTAKICAgIEZhc3QgVHJh
Y2sgQzYwMCwgVVNCIEF1ZGlvCiAgICA0LjAgU3Vycm91bmQgb3V0cHV0IHRvIEZyb250IGFuZCBS
ZWFyIHNwZWFrZXJzCnN1cnJvdW5kNDE6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2
MDAsIFVTQiBBdWRpbwogICAgNC4xIFN1cnJvdW5kIG91dHB1dCB0byBGcm9udCwgUmVhciBhbmQg
U3Vid29vZmVyIHNwZWFrZXJzCnN1cnJvdW5kNTA6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRy
YWNrIEM2MDAsIFVTQiBBdWRpbwogICAgNS4wIFN1cnJvdW5kIG91dHB1dCB0byBGcm9udCwgQ2Vu
dGVyIGFuZCBSZWFyIHNwZWFrZXJzCnN1cnJvdW5kNTE6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0
IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgNS4xIFN1cnJvdW5kIG91dHB1dCB0byBGcm9udCwg
Q2VudGVyLCBSZWFyIGFuZCBTdWJ3b29mZXIgc3BlYWtlcnMKc3Vycm91bmQ3MTpDQVJEPUM2MDAs
REVWPTAKICAgIEZhc3QgVHJhY2sgQzYwMCwgVVNCIEF1ZGlvCiAgICA3LjEgU3Vycm91bmQgb3V0
cHV0IHRvIEZyb250LCBDZW50ZXIsIFNpZGUsIFJlYXIgYW5kIFdvb2ZlciBzcGVha2VycwppZWM5
NTg6Q0FSRD1DNjAwLERFVj0wCiAgICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgSUVD
OTU4IChTL1BESUYpIERpZ2l0YWwgQXVkaW8gT3V0cHV0CmRtaXg6Q0FSRD1DNjAwLERFVj0wCiAg
ICBGYXN0IFRyYWNrIEM2MDAsIFVTQiBBdWRpbwogICAgRGlyZWN0IHNhbXBsZSBtaXhpbmcgZGV2
aWNlCnVzYnN0cmVhbTpDQVJEPUM2MDAKICAgIEZhc3QgVHJhY2sgQzYwMAogICAgVVNCIFN0cmVh
bSBPdXRwdXQK
--=_68caa8019afc25ed0317f004e1cc7af7--
