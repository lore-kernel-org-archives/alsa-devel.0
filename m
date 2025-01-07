Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA809E77197
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2025 22:10:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D509F60398;
	Tue,  7 Jan 2025 23:10:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D509F60398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736287850;
	bh=wBJ+wI+2LUlTSsW8QJ0Gd82eqbwMbvfF6mnJAJkx5mU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f046q2d/xt5TiLrM3t116Om4VsXvCueqVvDiiYi/qU+6Zj6LXHWkNHiAgh+nvJseY
	 p51g5ZfjffOlA9w6MCpZvfkYVSwDDnXwg0yExmU0kQpw7QgAQxHKZq1tij6MnEhEfN
	 WPXeLeiC4ipf0lq/V0oIfqaLkxAd8qHs4cRCnFng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 666F2F805C4; Tue,  7 Jan 2025 23:10:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44EE4F805C4;
	Tue,  7 Jan 2025 23:10:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 418FFF802DB; Tue,  7 Jan 2025 23:10:12 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 974AFF80086
	for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2025 23:10:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 974AFF80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1736287809908450842-webhooks-bot@alsa-project.org>
References: <1736287809908450842-webhooks-bot@alsa-project.org>
Subject: aseqdump version 1.2.11, There are small bugs
Message-Id: <20250107221012.418FFF802DB@alsa1.perex.cz>
Date: Tue,  7 Jan 2025 23:10:12 +0100 (CET)
Message-ID-Hash: UHALDX3FCSYUHCYIBXKCJTHCL2A4UNDM
X-Message-ID-Hash: UHALDX3FCSYUHCYIBXKCJTHCL2A4UNDM
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHALDX3FCSYUHCYIBXKCJTHCL2A4UNDM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #285 was opened from masahirokakishita:

Hello,

I found small bugs in aseqdump.c

static void dump_ump_midi2_event(const unsigned int *ump)
...
	case SND_UMP_MSG_PITCHBEND:
		printf("Channel pressure       %2d, value %s",
		       channel,
		       midi2_pitchbend(m->channel_pressure.data));
		break;

It is not "Channel pressure", but "Pitch Bend".

	case SND_UMP_MSG_NOTE_ON:
		printf("Note on                %2d, note %d, velocity %s, attr type = %d, data = 0x%x",
		       channel, m->note_off.note,
		       midi2_velocity(m->note_off.velocity),
		       m->note_off.attr_type, m->note_off.attr_data);
		break;

"note->on" is correct. This bug does not affect the display.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/285
Repository URL: https://github.com/alsa-project/alsa-utils
