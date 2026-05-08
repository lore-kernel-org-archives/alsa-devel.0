Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89CFCD3447
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2026 12:14:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9E48601FA;
	Fri,  8 May 2026 14:14:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9E48601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778242451;
	bh=4nkHb+lXIxeiQsuH7fn494/Bp8bY13Cy26NG/ZeBMX8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TV+4dY/kfCjPm+k4IAv+N781r/DE4Km4kXm66kyPVjQHunrgSNfqqG3QFmZv6npaR
	 ZUSo1ejXDE13CthvOc+iEZk7xLFZG2ZBb/7dN6RlHj/hoOe3IjKXBqmxsRlAL+wBSZ
	 cvFgs0qUZ36takbs4+mJhhlbqnwjW5uOqCleCmY4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98F71F805E7; Fri,  8 May 2026 14:13:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B8F6F80169;
	Fri,  8 May 2026 14:13:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEE11F80537; Fri,  8 May 2026 14:13:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 625EBF80169
	for <alsa-devel@alsa-project.org>; Fri,  8 May 2026 14:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 625EBF80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ad960b815ac200-webhooks-bot@alsa-project.org>
In-Reply-To: <18ad960b8155cf00-webhooks-bot@alsa-project.org>
References: <18ad960b8155cf00-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?HP_OmniBook_Ultra_Flip_=28Lunar_Lake=2C_103C=3A8CDE=29_=E2=80=94_ALSA_headphone_jack_state_changes_but_audio_does_not_route_to_headphones?=
Date: Fri,  8 May 2026 14:13:25 +0200 (CEST)
Message-ID-Hash: 4KFUKWO7NEVRDMAVZHVUQMRBTCJOK4UP
X-Message-ID-Hash: 4KFUKWO7NEVRDMAVZHVUQMRBTCJOK4UP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4KFUKWO7NEVRDMAVZHVUQMRBTCJOK4UP/>
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
- **Key Observation:** Manual routing is successful when performing the following sequence:
  1. `amixer -c0 set 'Headphone' on`
  2. `amixer -c0 set 'Speaker' off`
  3. `amixer -c0 set 'Auto-Mute Mode' Enabled`

### Technical Details (from alsa-info)
- **Headphone node:** `Node 0x21 [Pin Complex]`
- **Pin default:** `0x03211020: [Jack] HP Out at Ext Left`
- **Topology:** `intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg`

---
**Note to Maintainers:** I have attached the full `alsa-info.txt` to this issue. This hardware was previously discussed in the SOF project (issue #5757) where it was confirmed that HDA jack detection is functional at the driver level.
[alsa-info.txt](https://github.com/user-attachments/files/27514810/alsa-info.txt)

**Output of alsaucm dump text and spa-acp-tool lv for both the legacy and SOF case**
[sof_spa_acp.txt](https://github.com/user-attachments/files/27518858/sof_spa_acp.txt)
[sof_ucm_dump.txt](https://github.com/user-attachments/files/27518859/sof_ucm_dump.txt)
[legacy_spa_acp.txt](https://github.com/user-attachments/files/27518860/legacy_spa_acp.txt)

alsaucm dump text is only available for the SOF case; for the Legacy driver, it returns 'UCM is not supported'
```
alsaucm dump text > legacy_ucm_dump.txt
ALSA lib parser.c:305:(error_node) [error.ucm] UCM is not supported for this HDA model (HDA Intel PCH at 0x3013200000 irq 218)
ALSA lib main.c:1804:(snd_use_case_mgr_open) [error.ucm] failed to import hw:0 use case configuration -6
alsaucm: error failed to open sound card hw:0: No such device or address
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/758
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
