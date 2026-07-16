Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FCC4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:41:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 796686023D;
	Sat, 18 Jul 2026 11:40:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 796686023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367662;
	bh=RJ6f+XfXAfbzW3Alo2HwVjlVjDJu2gJvJHFb9DEy8P0=;
	h=Date:Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HpqK5ceuFdrvuhqmGO0K0L61PBaRQst7mPN4gp0Pm0KdHwtJQLG+X7s/4PUaIJQZb
	 p+1DlOG+iIVabBxK1sO6oTGe/F39uhqLmLFF+d21Lg/+3IM4BTY9f0UuwGUH910BSo
	 fa0UVq6TWjj27YT3pZubP+IN5CVZxncAlaWv+aEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C92EDF80630; Sat, 18 Jul 2026 11:40:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A081F8063D;
	Sat, 18 Jul 2026 11:40:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83D63F80527; Thu, 16 Jul 2026 12:53:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=217.182.158.229
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784199208;
	b=VDs16RZoo/xGFzeyy4YvwoOySGkwSa4MTYqOYkPEDL3qOq/dBAtymVXktnYlLfwNmvv4
	 p8xJc1Mf4Nz7Eux5dWJSzUQxUuHrsSBmsTX9/x/Ytimw3GUepEL8ZWFI4GS9UaqJH7bDC
	 fN410U+KvxL5w7s80a200ZL8WABs2tCRQzB4Z5vo66RG9cYdVk7CvXtIcwwlQLCzA6o2u
	 B41TzAm0N2vx3+Rtys0dyPxEX+PwC7j2Armcsr7Er4DNeKefN7DpR0rdUBXINoSsVaN/i
	 8FEhjikwop+bHkEy+zlM0LvKFk5cl/oW7WJ6pT8Rf7qXQBYH8QmEd22nsg/vxg/k9aw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784199208;
	h=Message-ID:Date:MIME-Version:Subject:From:To:DKIM-Signature;
	bh=RJ6f+XfXAfbzW3Alo2HwVjlVjDJu2gJvJHFb9DEy8P0=;
	b=ieq646iXkstDo9Y4deyVVfJUirOmvxATUZpfqq5xhs2t/got7TUoyr9eapmZhEo5dzRF
	 F25D/LQ7pEqQEPHrUJGEhqwEmWwIVj5oLnLhb+6n4uPos5dW8mVv+y+vXeiUrFw+4LuLa
	 k2tYfZ/zbevm5mm0oQVup1eTP2t3g+j/4RG0pE+onH+pF+nL3taniNsMcXEpkuePzuLst
	 Nr+0ei5R1lrhVtzAXvsu9KJLalvqGzhHU96qHeq5e0SbSzv6aWal0njF2M0uVq7NE26NP
	 e+amQUsWsluIiLmVQJ9ei07mcHRXP6E5G2nHDjtttHAQMxPAduT5l6AADqvnL8YaA5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=peccini.fr header.i=@peccini.fr header.a=rsa-sha256
 header.s=ovhmo227787-selector1 header.b=LcvGWQqq;
	arc=none smtp.remote-ip=217.182.158.229
Received: from 4.mo17.mail-out.ovh.net (4.mo17.mail-out.ovh.net
 [217.182.158.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9BEBF8051E
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 12:53:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9BEBF8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=peccini.fr header.i=@peccini.fr header.a=rsa-sha256
 header.s=ovhmo227787-selector1 header.b=LcvGWQqq
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
	by mo17.mail-out.ovh.net (Postfix) with ESMTPS id 4h18z94DCGz8MbL;
	Thu, 16 Jul 2026 10:53:25 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
        by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with
 SMTP
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Jul 2026 10:53:25 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.57])
	by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h18z923vHz7tL6;
	Thu, 16 Jul 2026 10:53:25 +0000 (UTC)
Received: from peccini.fr (unknown [10.1.6.5])
	(Authenticated sender: stephan-pro@peccini.fr)
	by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 313BA1923D99;
	Thu, 16 Jul 2026 10:53:23 +0000 (UTC)
Authentication-Results: garm.ovh;
 auth=pass (GARM-105G0064e5083bb-1f5b-43b2-a484-5820391537a7,
                    86351207988B327BB336620BB84F4B6E7B49C8FE)
 smtp.auth=stephan-pro@peccini.fr
X-OVh-ClientIp: 193.32.126.157
Message-ID: <fbc3a714-d083-4110-b788-d839c9f10751@peccini.fr>
Date: Thu, 16 Jul 2026 12:53:20 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: SN6186: Missing Mic Boost control and incorrect ADC gain on GMKtec
 EVO-X2 (Subsystem 0x2014801d)
From: =?UTF-8?Q?St=C3=A9phan_Peccini_-_Pro?= <stephan-pro@peccini.fr>
Content-Language: en-US, fr-FR
To: bo.liu@senarytech.com, alsa-devel@alsa-project.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13269011881115605908
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: 
 dmFkZTEup06/JE1BJAJ8H62L3hQs6oBMXP98V9ynCiCkiK+36NHCYWtGzudqL9kH9GYG/d3HXYLSNQGBgBoksil9COYDpCtoQ0C1FcEKMPczIwdZFa/gCNDFU24TZWRDUog7pLUHgIdccjP+DKt8XPtDALnoW064qdUa3/0ZeRwwmAwRvzPGr4Kx7S2gvtq8oHVgtr5FwZGwDvuDRPSa0xbhDtqXwsqycQecXssM2Ld2njxHFkWC8VZkhIrWvhGbSaSqUDeWI5qsWYZ+jTeJn4Xpb6jxPZIDM7j7PiyrfBJ4xPRKMH+y3GijdgmgrD7xL4brmXdDzi9lJN9u8pELUFDPZVWwJWi2828uehZkVssBdK4+ldlJxHc4H2BvGW0jNq/mjbVTh0T0+bnuitMLovoHUf9noFt/c2LoL0sq6L61uMH4qKKSsb2KOKgsjl/esqzx+P5sUc7pY5uNhu08xVNbVB/AKaBfKYh9QHdX+sJr60CedJpi6QPdy2WhvftRoTWc12gYokMabHvC2Ryu1Z+bViaJz8g5wDm2qvMlF4AtkuLCMN/A6+swi/3IRE53/UB8rNMx8G/YowW9SViaI+KVa8Ebl+gPgKloV3BF+/k2qTlOroL6OZpZV61jfOL/Ff+4JWTgkFqqMMIn5FMYJo6rFZbjnrtDQns+MNzG+nDt67r6CQ
DKIM-Signature: a=rsa-sha256; bh=ZfczRfdwTGJBnR8XdbYH+Rj9skXg/3QL1AsVDaBHLrg=;
 c=relaxed/relaxed; d=peccini.fr; h=From; s=ovhmo227787-selector1;
 t=1784199206; v=1;
 b=LcvGWQqqPf7C+4XVl7gT7FpDFQHyzSQdo9Y/LJ5hac0UdQiuzgPTLBkyBiBQs1BS4Er5qJir
 xeOPFVioOKd+CxWRw8VE2dxSTNf/gxjpBfmo8u8A3HogCipaP+se1D9UJ8t1kqHEMhyZ3/DTQjM
 mnHhuAbxVZCNet2GzKjBI3HXON79jaNge0UNMBQKkMp4OWB/aI5Py1Ad/0kTynHkAydnx1j9Lt0
 AkjNX4i8RywpF50PSzepN1yhds8mZXlWO2vSl4B1EDepuiPUZzml1aaeNZIgK5+ETNKSsFr3Vk0
 cwaBFCkUub6nQG3SPhO7S9P0B6SF1bhMGpaRlQ59bEgeQ==
X-MailFrom: stephan-pro@peccini.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EY5FOUFPNHII72KCFJRPRIZRS6Z4JQFN
X-Message-ID-Hash: EY5FOUFPNHII72KCFJRPRIZRS6Z4JQFN
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:40:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EY5FOUFPNHII72KCFJRPRIZRS6Z4JQFN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I'm reporting a microphone input issue with the Senarytech SN6186 codec 
on a GMKtec EVO-X2 mini PC (AMD Ryzen AI Max+ 395, Strix Halo), running 
Fedora 44 with kernel 7.x and PipeWire 1.6.8.

Subsystem Id: 0x2014801d
Driver: snd_hda_codec_senarytech
Board: GMKtec EVO-X2 (Sixunited AXB35-02)

SYMPTOM

Microphone input via the front 3.5mm jack (pin 0x1a, Front Mic) is 
barely audible — the signal is present but far too low for any practical 
use (calls, recording, voice input). Headphone output works correctly.

ROOT CAUSE

Two issues found by inspecting the codec topology:

1. The ADC node 0x14 amp-in at index 1 (connected to pin 0x1a) 
initializes at value 0x3c instead of the offset value 0x4a. The amp-in 
caps specify ofs=0x4a as the 0 dB reference, so 0x3c corresponds to -14 
dB of attenuation on the capture path. This is the primary cause of the 
low volume.

2. The pin complex 0x1a has an input amplifier (Amp-In caps: 
nsteps=0x07, stepsize=0x17 = 24 dB per step, 42 dB total range) but the 
driver does not expose it as a Mic Boost mixer control. The only exposed 
capture control is the ADC 0x14 amp, mapped as "Mic" with +16 dB max. 
Users have no way to enable the hardware pre-amplifier.

Additionally, PipeWire resets the ADC gain to 0x0 (mute/zero) when it 
reopens the device, making any hda-verb workaround non-persistent.

DIAGNOSTIC DATA

dmesg at boot:
snd_hda_codec_senarytech hdaudioC1D0: SN6186: BIOS auto-probing.
snd_hda_codec_senarytech hdaudioC1D0: autoconfig for SN6186: line_outs=1 
(0x1d) type:line
snd_hda_codec_senarytech hdaudioC1D0: speaker_outs=1 (0x17)
snd_hda_codec_senarytech hdaudioC1D0: hp_outs=1 (0x16)
snd_hda_codec_senarytech hdaudioC1D0: inputs: Rear Mic=0x19, Front Mic=0x1a

amixer -c scontents shows only one control:
Simple mixer control 'Mic',0
Capabilities: cvolume cvolume-joined cswitch cswitch-joined
Capture channels: Mono
Limits: Capture 0 - 3896
Mono: Capture 3896 [100%] [16.00dB] [on]

Codec pin 0x1a amp-in values: [0x00 0x00] (gain step 0 = 0 dB boost)
ADC 0x14 amp-in values at index 1: [0x3c 0x3c] (= -14 dB vs 0 dB reference)
ADC 0x14 AMP_IN_CAP: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
Pin 0x1a AMP_IN_CAP: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=1

SUGGESTED FIX

A fixup entry for subsystem 0x2014801d in patch_senarytech.c that:
- Sets ADC 0x14 amp-in index 1 initial value to 0x4a (0 dB)
- Exposes pin 0x1a amp-in as a "Mic Boost" mixer control (0-42 dB range)

I can provide the full codec dump (cat /proc/asound/card1/codec#0) if 
needed.

cat /proc/asound/card1/codec#0
Codec: Senarytech SN6186
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x1fa86186
Subsystem Id: 0x2014801d
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
     rates [0x0]:
     bits [0x0]:
     formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
   Power states:  D0 D1 D2 D3 D3cold S3D3cold CLKSTOP EPSS
   Power: setting=D0, actual=D0
GPIO: io=7, o=0, i=0, unsolicited=1, wake=1
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Control: name="Headphone Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x50, nsteps=0x50, stepsize=0x03, mute=1
   Amp-Out vals:  [0x80 0x80]
   Converter: stream=0, channel=0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Control: name="Line Out Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Line Out Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Device: name="SN6186 Analog", type="Audio", device=0
   Amp-Out caps: ofs=0x50, nsteps=0x50, stepsize=0x03, mute=1
   Amp-Out vals:  [0x50 0x50]
   Converter: stream=0, channel=0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x12 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x13 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x50 0x50] [0x80 0x80] [0x80 0x80]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x18 0x24 0x19* 0x25 0x1f
Node 0x14 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Capture Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Capture Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Device: name="SN6186 Analog", type="Audio", device=0
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x80 0x80] [0x50 0x50] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x18 0x1a* 0x24 0x25 0x1f
Node 0x15 [Vendor Defined Widget] wcaps 0xf0050b: Stereo Amp-In
   Amp-In caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 3
      0x10* 0x11 0x23
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x0001001c: OUT HP EAPD Detect
   EAPD 0x2: EAPD
   Pin Default 0x01214030: [Jack] HP Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=01, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x10
Node 0x17 [Pin Complex] wcaps 0x400500: Mono
   Pincap 0x00010010: OUT EAPD
   EAPD 0x2: EAPD
   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x23
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=1
   Amp-In vals:  [0x07 0x07]
   Pincap 0x00003324: IN Detect
     Vref caps: HIZ 50 80 100
   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x25: IN VREF_100
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=1
   Amp-In vals:  [0x80 0x80]
   Pincap 0x00003324: IN Detect
     Vref caps: HIZ 50 80 100
   Pin Default 0x01a11040: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x4, Sequence = 0x0
   Pin-ctls: 0x25: IN VREF_100
   Unsolicited: tag=04, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x1a [Pin Complex] wcaps 0x40058b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=1
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00013334: IN OUT EAPD Detect
     Vref caps: HIZ 50 80 100
   EAPD 0x2: EAPD
   Pin Default 0x02a13050: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Blue
     DefAssociation = 0x5, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=03, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 3
      0x10* 0x11 0x23
Node 0x1b [UNKNOWN Widget] wcaps 0x0: Mono
Node 0x1c [UNKNOWN Widget] wcaps 0x0: Mono
Node 0x1d [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x0001001c: OUT HP EAPD Detect
   EAPD 0x2: EAPD
   Pin Default 0x02014020: [Jack] Line Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=02, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x11
Node 0x1e [UNKNOWN Widget] wcaps 0x0: Mono
Node 0x1f [Pin Complex] wcaps 0x40040b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=0
   Amp-In vals:  [0x07 0x07]
   Pincap 0x00000020: IN
   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x20 [UNKNOWN Widget] wcaps 0x0: Mono
Node 0x21 [UNKNOWN Widget] wcaps 0x0: Mono
Node 0x22 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 3
      0x15* 0x25 0x1f
Node 0x23 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Control: name="Speaker Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Speaker Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x50, nsteps=0x50, stepsize=0x03, mute=1
   Amp-Out vals:  [0x80 0x80]
   Converter: stream=0, channel=0
   PCM:
     rates [0x540]: 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x24 [Pin Complex] wcaps 0x40058b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=1
   Amp-In vals:  [0x07 0x07]
   Pincap 0x00013334: IN OUT EAPD Detect
     Vref caps: HIZ 50 80 100
   EAPD 0x0:
   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x25: IN VREF_100
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 3
      0x10* 0x11 0x23
Node 0x25 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x07, stepsize=0x17, mute=0
   Amp-In vals:  [0x07 0x07]
   Pincap 0x00000020: IN
   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0

Best regards,

-- 
Stéphan Peccini - (+33) (0)6 70 06 93 98
Site : https://conseil.peccini.fr
Profil : https://www.linkedin.com/in/stéphan-peccini/
Consultant Numérique Responsable
Expert Stratégie Conception Responsable
Prendre rendez-vous : https://cal.com/stephanpeccini

