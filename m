Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9472CD3447
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2026 10:00:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE51960220;
	Fri,  8 May 2026 12:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE51960220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778234434;
	bh=RTIMasiSVV9DaOVJ0HIMAO4ngBiD3aHA9xyrurXatC4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RDV/mUH/OtWwyj+vvhuImvDFxesHKKg1vuCp2Dv3QKAWgn5xLaWqwuT6dA7DRdMI/
	 lxsboYuGg5/yv/jb9a81Y6htub+f+DclIm4/zxXByM9l2iqsvztYxJg78Vctk6/TwY
	 hoLfwHj6AUP1DDQdMeYC1i3dbpiQOS5GbXkrP3To=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E446CF805F5; Fri,  8 May 2026 11:59:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D782F805E9;
	Fri,  8 May 2026 11:59:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EA76F804F3; Fri,  8 May 2026 11:59:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D245F800FE
	for <alsa-devel@alsa-project.org>; Fri,  8 May 2026 11:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D245F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ad8ec0a40e4a00-webhooks-bot@alsa-project.org>
In-Reply-To: <18ad8ec0a3edaf00-webhooks-bot@alsa-project.org>
References: <18ad8ec0a3edaf00-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?HP_OmniBook_Ultra_Flip_=28Lunar_Lake=2C_103C=3A8CDE=29_=E2=80=94_ALSA_headphone_jack_state_changes_but_audio_does_not_route_to_headphones?=
Date: Fri,  8 May 2026 11:59:48 +0200 (CEST)
Message-ID-Hash: ATNGFNWBS332IJWNZCBH44ZNKM27WFQB
X-Message-ID-Hash: ATNGFNWBS332IJWNZCBH44ZNKM27WFQB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ATNGFNWBS332IJWNZCBH44ZNKM27WFQB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #758 was opened from pavlo0909:

### Description

On the HP OmniBook Ultra Flip (Intel Lunar Lake), headphone plug/unplug is correctly detected by ALSA, but audio does not route to the headphone output.

When headphones are inserted, the `Headphone Jack` control changes state correctly. However, the active output does not switch to headphones in KDE / PipeWire, and audio continues through the internal speakers. The internal speakers and internal DMIC both work normally.

### Environment

- Manufacturer / Model: HP OmniBook Ultra Flip Laptop 14-fh0xxx
- Platform: Intel Lunar Lake (LNL)
- Codec: Realtek ALC245
- PCI SSID: 103C:8CDE
- Distribution: Fedora 43 (KDE Plasma)
- Kernel: 6.19.14-200.fc43.x86_64
- Audio stack: SOF + PipeWire + WirePlumber

### Diagnostic Results

I verified headphone jack detection at the ALSA level using:

`watch "amixer -c0 contents | grep -A2 Jack"`

The control `numid=19,iface=CARD,name='Headphone Jack'` changes state correctly when plugging and unplugging headphones.

**Unplugged**
`values=off`

**Plugged**
`values=on`

This indicates that physical jack insertion is detected correctly.

### Additional ALSA Information

>From the attached `alsa-info.txt`:

- `Headphone Jack` reports `true` when plugged.
- `Headphone Playback Volume` is present.
- `Headphone Playback Switch` exists but remains `off`.
- Headphone pin `Node 0x21` is configured as `HP Out`, with `Pin-ctls: 0xc0: OUT HP`.

This suggests the codec exposes a valid headphone path and jack state, but the headphone route is not being selected or activated in userspace.

### Observed Behavior

- ALSA detects headphone insertion and removal correctly.
- The desktop audio output does not automatically switch to headphones.
- Audio continues through the internal speakers after headphones are plugged in.
- KDE / PipeWire does not expose a usable active headphone output.

### Additional Context

This issue was first reported in the SOF project.

Based on maintainer feedback there, HDA jack detection appears to be working correctly, which suggests the problem may be related to UCM jack mapping, port exposure, or user-space routing policy rather than low-level codec detection.

Related discussion: https://github.com/thesofproject/linux/issues/5757

### Technical Details

>From `alsa-info`:

- Headphone node: `Node 0x21 [Pin Complex]`
- Pin default: `0x03211020: [Jack] HP Out at Ext Left`
- Topology: `intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg`

Relevant playback controls are present:

- `Headphone Playback Switch`
- `Headphone Playback Volume`

### Request

Could you check whether this hardware requires a dedicated UCM configuration, jack mapping, or port definition for PCI SSID `103C:8CDE`?

`alsa-info.txt` attachement:
[alsa-info.txt](https://github.com/user-attachments/files/27514810/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/758
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
