Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF2CCD3436
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2026 10:37:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A52D60212;
	Fri,  8 May 2026 12:37:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A52D60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778236664;
	bh=MF7ELDhR6rcK4S/LK3aHZ1lkOpNjeE2JMsI7Q8xUqK0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ftj84DBZVZSYhqs01Xi1uHySgGsKqkh69SJ1BkyjXFII6pWG0I00dyA14jh2Dvk91
	 Jb8TD4EB7bUhtjSkE5M0w7dJ+5S7QMxYcHQoQF/q3S8alrvGj4B9qPKGNPbo066jec
	 WzjKZAm9kEFHQ8pZpnkJssKpWijBpmkRFXVj2cnY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2515F805EC; Fri,  8 May 2026 12:37:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 728F1F805F0;
	Fri,  8 May 2026 12:37:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2E67F804F3; Fri,  8 May 2026 12:37:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 043EEF80075
	for <alsa-devel@alsa-project.org>; Fri,  8 May 2026 12:37:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 043EEF80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ad90c92785d400-webhooks-bot@alsa-project.org>
In-Reply-To: <18ad90c9277b4d00-webhooks-bot@alsa-project.org>
References: <18ad90c9277b4d00-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?HP_OmniBook_Ultra_Flip_=28Lunar_Lake=2C_103C=3A8CDE=29_=E2=80=94_ALSA_headphone_jack_state_changes_but_audio_does_not_route_to_headphones?=
Date: Fri,  8 May 2026 12:37:03 +0200 (CEST)
Message-ID-Hash: C6KTLT6KXXMDXKJSFTTS2H7P44K2MWRS
X-Message-ID-Hash: C6KTLT6KXXMDXKJSFTTS2H7P44K2MWRS
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C6KTLT6KXXMDXKJSFTTS2H7P44K2MWRS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #758 was edited from pavlo0909:

### Description

On the HP OmniBook Ultra Flip (Intel Lunar Lake), headphone plug/unplug is correctly detected by ALSA, but audio does not route to the headphone output automatically.

When headphones are inserted, the `Headphone Jack` control changes state correctly. However, the active output does not switch to headphones in KDE / PipeWire, and audio continues through the internal speakers. The internal speakers and internal DMIC both work normally.

### Environment

- **Manufacturer / Model:** HP OmniBook Ultra Flip Laptop 14-fh0xxx
- **Platform:** Intel Lunar Lake (LNL)
- **Codec:** Realtek ALC245
- **PCI SSID:** 103C:8CDE
- **Distribution:** Fedora 44 (KDE Plasma Desktop Edition)
- **Kernel:** 6.19.14-300.fc44.x86_64
- **Audio stack:** SOF + PipeWire + WirePlumber

### Diagnostic Results

I verified headphone jack detection at the ALSA level using:
`watch "amixer -c0 contents | grep -A2 Jack"`

The control `numid=19,iface=CARD,name='Headphone Jack'` changes state correctly:
- **Unplugged:** `values=off`
- **Plugged:** `values=on`

### Observed Behavior
- ALSA detects headphone insertion correctly, but the desktop environment (PipeWire/WirePlumber) does not automatically switch the routing or expose the port correctly.
- Audio continues through internal speakers.
- **Key Observation:** Enabling ALSA `Auto-Mute Mode` manually via `amixer -c0 set 'Auto-Mute Mode' Enabled` resolves the issue immediately (internal speakers mute and audio routes to the headphones). This suggests the UCM configuration is missing the proper jack/verb mapping for this specific hardware SSID.

### Technical Details (from alsa-info)
- **Headphone node:** `Node 0x21 [Pin Complex]`
- **Pin default:** `0x03211020: [Jack] HP Out at Ext Left`
- **Topology:** `intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg`

### Request
Could you check whether this hardware requires a dedicated UCM configuration or specific JackControl/mapping for PCI SSID `103C:8CDE` to allow PipeWire to manage the switching without relying on the hardware Auto-Mute control?

---
**Note to Maintainers:** I have attached the full `alsa-info.txt` to this issue. This hardware was previously discussed in the SOF project (issue #5757) where it was confirmed that HDA jack detection is functional at the driver level.
[alsa-info.txt](https://github.com/user-attachments/files/27514810/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/758
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
