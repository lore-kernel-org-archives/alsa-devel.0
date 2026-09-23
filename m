Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290DECA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:08:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3316602C9;
	Tue, 29 Sep 2026 21:07:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3316602C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708881;
	bh=DcXE3Yc2viJSW6Ow1/ox3KNAYWE0gUWdlJknnuKRpPs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nsQ6S9OL3O+yOzF3mJll5DpEWqybBncFtOVhOlH1EwaeGhfBEPYVzFIqbXY2Ol4e5
	 hfOiWQLz95s1Bqu5Fug7YionOEvEDldiv2+mOmefTp+s+8yuXAZiUoqyHH80EZchwz
	 Z2sdgrdZ5tu+MPe53TGUfIvs5Izycc2L6DlZbzxk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 686E1F8077B; Tue, 29 Sep 2026 21:05:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6B33F807CA;
	Tue, 29 Sep 2026 21:05:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AEFFF8051F; Wed, 23 Sep 2026 09:35:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790148902;
	b=OSK9g3MScRQvGHQgHRUyurF7xS1l4PQojMTjwIng7vBNs51sM1pHXNamolI+OuP+PHiw
	 1BsxDTjnJRIGqVT20A597kmJfvHRypPcYvMNql3rOy/qtS8r/bk34irO1OPOcYCLdO+ng
	 Y0JkBGCpgyx2w/EwnISc8RcFlnAM3MeWmR7wyNZ0freat+IeewiZm7EigUvEFbIpuHaZe
	 byx+FJzbxrO54GOIQ0EuDqn8hi4swkXOLTOfjh5V4h55/bbr5DWezT1NiW7TB0dZwCRr+
	 uxojeTQGZfeIdyWG1flnoi1RUXUY6+FcBp+bmLSWPgRSXMXzIwPBvBgGtCliWOHubHw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790148902;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=pEtqADn3pz8h+K1D1ONtrxvgL7zbhtP5GGjYDWS2paY=;
	b=NqWD0wStdGU4o+5ZvW0H2XEVdYPRSZnYfzWzwpFahvq7g00wyecmFx9BfRgmTSqQHzWP
	 KvbMtoBHnLx7oBsR5DwoFYhxaNZRtGA0HByeKcmM208P2yavNTk/An3Fvde4PYEF8PU0M
	 1BrBNc08ZB3GpvgqNgLIvIH9+MmxqEpQETJblbE6k9P2D7Lhrf0eP3XDWrDJ/WjSZ4UTk
	 9Wqiy8WeYt+8PjLpjuUbOQMqiXay7U9z3+QOiDuTTamL+kvD1ZG7yJa7UlFWthL8XmxD9
	 nsIqxNL+70eYY+hP8ZQu4Q8ps8CrWTr3My6YV+8MeUgFwQX2YXztopdidTyaxGilp/w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=haering.me header.i=@haering.me header.a=rsa-sha256
 header.s=MBO0001 header.b="E/I4j2Xu";
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C80DF80246
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2026 09:35:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C80DF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=haering.me header.i=@haering.me header.a=rsa-sha256
 header.s=MBO0001 header.b=E/I4j2Xu
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hqTJL2p0SzKnVW;
	Wed, 23 Sep 2026 09:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haering.me; s=MBO0001;
	t=1790148898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcLP6SdZrfauZQ3PhmTToRZh30dCx7bcQLk+cheppqo=;
	b=E/I4j2XuvkvoO7vZnCshz5136iDFVuEFKBUi5o+yHHFzwgOT+1bQH6eZTE+0q0oiVcGt86
	nO8aMfHCEJMn6IO1bBdfQvk84Z+oMIvih/3TNFyJnRK3K7pMJLCfrYf9y3xHwGIX9q+DOf
	3gysWgmFedWM0I9XKn168nxpXGtw1WhvJI1NMaNADc6grfebZ28fTkzzZenJ95PB1bNJjr
	4/PCtkL0IWijE3PqCG1h49ibL6f2u2Nv7fh31vqD1dliW2I/UWb5dnjJecXcMBC6ZKriSQ
	62pMpnqqeGTEV85HHGKsL9wlBE+MfIrNaHKwIwyXMMvW30r6PqG+upeVHXCPQw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of alsa-project@haering.me designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=alsa-project@haering.me
Date: Wed, 23 Sep 2026 09:34:56 +0200
From: Marlo <alsa-project@haering.me>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: "tiwai@suse.de" <tiwai@suse.de>
Subject: =?US-ASCII?Q?Re=3A_Conexant_SN6140=3A_ThinkPad_E?=
 =?US-ASCII?Q?14_Gen_8_=2817aa=3A513e=29_-_PCM_strea?=
 =?US-ASCII?Q?m_RUNNING_at_correct_rate_but_a?=
 =?US-ASCII?Q?nalog_outputs_silent=2C_HDMI_works?=
In-Reply-To: <38B8FF75-CF35-4EDA-87D4-99FABC272213@haering.me>
References: <38B8FF75-CF35-4EDA-87D4-99FABC272213@haering.me>
Message-ID: <9DA35CA2-6065-436B-B46D-028ACF1C98D3@haering.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4hqTJL2p0SzKnVW
X-MailFrom: alsa-project@haering.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7SAK3HHYFGIY3KXBD66K5ZVYOHO7AHWB
X-Message-ID-Hash: 7SAK3HHYFGIY3KXBD66K5ZVYOHO7AHWB
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:57 +0000
Content-Type: text/plain;
 charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7SAK3HHYFGIY3KXBD66K5ZVYOHO7AHWB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

quick follow-up: after updating from kernel 7.2.5-200.fc44 to
7.2.7-200.fc44.x86_64 (Fedora 44), internal speakers and the
headphone jack work again on my ThinkPad E14 Gen 8 (17aa:513e).

Note that neither the SSID fallback nor the GPIO state has changed
compared to my original report:

snd_hda_codec_conexant hdaudioC0D0: SN6140: picked fixup  for PCI SSID 17aa:0000

GPIO: io=5, o=0, i=0, unsolicited=1, wake=1
  IO[0..4]: all enable=0, dir=0, data=0

So neither the 17aa:0000 fallback nor the unconfigured GPIOs seem
to have been the cause of the silent analog output; something else
between 7.2.5 and 7.2.7 fixed it. This may also be relevant for the
ThinkPad E16 Gen 4 (17aa:513f) report.

Thanks!

Best regards,
Marlo


> Marlo <alsa-project@haering.me> hat am 15.09.2026 14:09 MESZ geschrieben:
> 
>  
> Hello ALSA developers,
> 
> I would like to report what appears to be the same class of issue recently discussed for the ThinkPad E16 Gen 4 (thread: "Conexant SN6140: ThinkPad E16 Gen 4 (17aa:513f) has no speaker output, wrong PCI SSID fixup selected", 2026-07-17). My hardware has a different but neighboring subsystem ID (513e instead of 513f), and I have gathered some additional data points that hopefully narrow down the root cause further.
> 
> Hardware
> --------
> Laptop: Lenovo ThinkPad E14 Gen 8
> Product: 21Y6000SGE (Machine Type 21Y6)
> CPU: Intel Core Ultra (Panther Lake)
> Audio controller: Intel HD Audio [8086:e428]
> PCI subsystem: 17aa:513e
> Codec: Conexant SN6140
> Codec-reported Subsystem Id: 0x17aa513e
> BIOS: version 1.02 (no newer version available; fwupdmgr reports no update for System Firmware)
> 
> Software
> --------
> Distribution: Fedora 44
> Kernel: 7.2.5-200.fc44.x86_64
> PipeWire: 1.6.8
> 
> Problem
> -------
> Both analog outputs are completely silent:
> - Internal speakers (pin 0x17)
> - 3.5mm headphone jack on the laptop itself (pin 0x16)
> 
> The following DO work correctly:
> - USB-C connected earbuds (separate USB audio device, as expected)
> - A headphone plugged into an external HDMI monitor (digital HDMI audio path of the same Intel controller)
> 
> This suggests the issue affects the entire analog output section of the codec specifically, while the digital HDMI path on the same chip works fine.
> 
> During boot:
> 
> snd_hda_codec_conexant hdaudioC0D0: SN6140: BIOS auto-probing.
> snd_hda_codec_conexant hdaudioC0D0: SN6140: picked fixup for PCI SSID 17aa:0000
> 
> Same symptom as the E16 Gen 4 report: the driver falls back to PCI SSID 17aa:0000 instead of the actual Lenovo subsystem ID (17aa:513e in my case).
> 
> Mixer / pin state
> ------------------
> Master: 88% (unmuted)
> Speaker: 100% (unmuted), both channels
> Auto-Mute Mode: Disabled
> 
> Node 0x17 [Pin Complex] (speaker):
>   Pincap 0x00010010: OUT EAPD
>   EAPD 0x2: EAPD enabled
>   Pin Default 0x91170110: [Fixed] Speaker at Int Rear
> 
> Node 0x11 [Audio Output] (Speaker DAC):
>   Speaker Playback Volume / Switch both present, unmuted
> 
> GPIO block (from /proc/asound/card0/codec#0):
>   GPIO: io=5, o=0, i=0, unsolicited=1, wake=1
>   IO[0..4]: all enable=0, dir=0, data=0
> 
> Stream-level confirmation (the key new data point)
> ---------------------------------------------------
> With PipeWire/WirePlumber stopped, running speaker-test directly against plughw:0,0 while inspecting the kernel PCM state twice, 1 second apart:
> 
> cat /proc/asound/card0/pcm0p/sub0/status:
>   1st read: state RUNNING, hw_ptr = 144336
>   2nd read (+1s): state RUNNING, hw_ptr = 192616
> 
> That is a delta of 48280 samples in ~1 second, matching the configured 48000 Hz rate almost exactly. hw_params for this stream:
>   access: RW_INTERLEAVED, format: S16_LE, channels: 2, rate: 48000, period_size: 12000, buffer_size: 48000
> 
> So the PCM stream is correctly opened, configured, and demonstrably running at the correct real-time rate at the kernel/ALSA level - audio data is being delivered to the codec continuously and on time - yet no sound comes out of either analog output. This rules out any PipeWire/ALSA-lib/stream-configuration/timing issue and narrows the problem down firmly to the codec's analog output stage itself (DAC->amp->pin), consistent with the GPIO block being entirely unconfigured (all 5 GPIO pins disabled) as noted above.
> 
> Tests already performed without success
> ----------------------------------------
> - normal snd_hda_intel path (current default)
> - cold boot / full shutdown+restart cycle
> - checked for a newer BIOS (none available)
> 
> I have not yet tried aliasing via the model option with an existing quirk entry's $VENDOR:$DEVICE string as Takashi suggested in the E16 Gen 4 thread - happy to test that or any other patches/instrumentation if pointed in the right direction.
> 
> Full diagnostic report (alsa-info.sh):
> https://alsa-project.org/db/?f=5f8598a774edfeba0d09022c694a0014e3022bfc
> 
> Thank you very much for your work, and please let me know what further information or testing would help.
> 
> Best regards,
> Marlo
