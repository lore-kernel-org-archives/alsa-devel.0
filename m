Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48FCC7EE2E
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jun 2023 12:42:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA497A4A;
	Tue, 13 Jun 2023 14:41:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA497A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686660145;
	bh=39TPIj0g0NXC3j1K+rrieKlpJEhtMaIwj1UsjNN3qDU=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=P33Tf6pwzsP+1oUAUjsB0vz/ybSM/r+IATxBqYN/aT8nDUWWPwqi1gL8LU7lyoKfc
	 LEMQGaEILwTNSz42azZHnTIrI5TMZkQylxMljgwDbyCk/WjfHNpCM+uFndlFjt3Mur
	 ooDaxZucy8IXYV/5+3T2F7a2FgU3mZcTBjBSZE8o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1835FF80246; Tue, 13 Jun 2023 14:41:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC5CF80246;
	Tue, 13 Jun 2023 14:41:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF2B9F80149; Tue, 13 Jun 2023 14:41:07 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id A1692F80093
	for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2023 14:41:07 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
From: happy.debugging@gmail.com
To: alsa-devel@alsa-project.org
Date: Tue, 13 Jun 2023 12:41:07 -0000
Message-ID: 
 <168666006765.22.17667904471972537472@mailman-web.alsa-project.org>
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: X3VX5HRLVTUCBE2HLCE7GWQK3POX6DIB
X-Message-ID-Hash: X3VX5HRLVTUCBE2HLCE7GWQK3POX6DIB
X-MailFrom: happy.debugging@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WVDJUDDZBFH7JRQ32KMIQKLQP4AM4WCB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello I have a few questions:

1. As default, USB-audio driver will take the alternate setting for MIDI 2.0 interface:  Does this mean that the ALSA driver will default to Alt Function 1 if it exists ? 
2. What happens when using a kernel that does not support Alt Function 1 (MIDI 2.0) and  device with a  (much longer) MIDI 2.0 descriptor is attached ?
3. " However, user may let the driver falling back to the old MIDI 1.0 interface by a module option, too."
     Can or how it this done via the ALSA API  ? If the switch is made, does an ALSA client require to re-enumerate all the ports ?
4. Is there a way to force a specific device (port) to Legacy MIDI 1.0 ?
5. Is there a way , via ALSA, to select UMP MIDI 1.0 protocol instead of MIDI 2.0 UMP protocol.
6. To which protocol does the driver default ? UMP MIDI 1.0 or UMP MIDI 2.0 ? 
7. Does the driver do anything related to  Jitter Reduction ? How/is this supported via the ALSA API ?a
8. Does the driver do anything related to  Bandwidth restriction ?  How/is this supported via the ALSA API ?
9. Are/will UMP streaming messages be supported ? (new feature in MIDI 2.0 specification), if yes, how ?
10. Is function block information supported via ALSA, i.e added in the ALSA Port information ?
