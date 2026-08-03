Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCEBC55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:29:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C4A260206;
	Wed,  5 Aug 2026 12:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C4A260206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925753;
	bh=DzSWKolsbZfV/bmaX6Qw6RBF5KKptoaNWsLV4MdY+v8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IgpNUI+Ofc6eV2PY1+ci7Qxgaa4yBhdz0fWdnv0Yi5eeL2C8x1/qk9HqGCpSrlKua
	 Udmz7cTj8Zbc1siBjhGtxAkIZQCwGUOYsu+IVbb9CXosk9lfh6TZ3QT4BwobXQ5VVx
	 SpjtLL1rAqso6euCVwiRpSfG/pjCntxOGzI7UmvE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3704F805FF; Wed,  5 Aug 2026 12:28:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECD70F805F8;
	Wed,  5 Aug 2026 12:28:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40DEAF805BF; Mon,  3 Aug 2026 12:36:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785753364;
	b=Ys9dIXskWF6l+lCnHtoOl3TvhVvdx+kgsPPjJx14Zih2oUOiM7WH2mgS2v6dlVj0tSS2
	 VH2k9ZuUZdDR+QE1NXvLnge6et703IsdZ4eG/3wyIYW9E4cPGHVNn7D1IbiRTk2hlhe8J
	 G+crKQKJBAE8uIeKxr/Kg6UmjFTXmrr5zkCTVeYGbnPNqdvGiYqCOVdsGCD3rHF6J0mAF
	 b7KBJyPNFmiXOn6i02ib8JPXW7XuTqfkjQawE0SxhFRi2f0gvpJNzP4cvFJtDA//5CzQh
	 ma7NptZOMiHHtBhFyxIVM2I51IQqbWLSxSJTj/bugzT37hwT2J8IyToGdOCgcvOefQQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785753364;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:From;
	bh=DzSWKolsbZfV/bmaX6Qw6RBF5KKptoaNWsLV4MdY+v8=;
	b=d/u9qiVMeJFeq+Z+9G9Y098RGRCHncAuMQ3+PbIKot+ON5yLP2kxTtfchsI2ejNxTXM5
	 39lPm011jIrCNKwszxWopdM05LdekQmQhiOmNJ2eVeiA0cx0uTpOvlvKqWqgRPfkq5CFe
	 GCcOUL8xfTWxg64TCMItR4d31kwyjR591jkxg8gWyBJER1hOyLz00Rvhc1t1hgk+q7XIX
	 PYP1jUu8+mRaMYw49+K/MhBi/HgX6RRYxlHJ3jeyC/zYalASrOg3xtAvG/GGkfL90iZzf
	 8JGePXFhHgDB/h+by6bPG/YZzPWvHRn50mFGzqoxTs76Ee86K5f32VIY8lsihNSjqww==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=BrTfedeE;
	arc=none smtp.remote-ip=95.215.58.187
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CE87F800D2
	for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2026 12:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CE87F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=BrTfedeE
Message-ID: <b0bba73d-0ce4-4472-affe-e5dd6f4bbdc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785753361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7FxktgWcNxGwdqetE4tTPpoSBKbPAwvsXbY+ZSGtU8=;
	b=BrTfedeEeD9e0I2bYDbJAlIeMBKHwOgafGwDV+wv2AdAqRv/HLhVHvCrTdhqZhV6CB25h+
	V/c90KcpILbDybfRoEr3hNIkXtuLwSC4lGiaLXZqyGAtoAnyqilP/MkkC8/ZM2sYOR7tCO
	H28SUHt2W9TqcSwXwPsp51eSNQi3Uuk=
Date: Mon, 3 Aug 2026 12:35:05 +0200
MIME-Version: 1.0
Subject: Re: [BUG] ASoC: Intel PTL missing SoundWire machine match for RT712 +
 4x TAS2783 speakers
To: Michael <michael.aug@proton.me>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "cezary.rojewski@intel.com" <cezary.rojewski@intel.com>,
 "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
 "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "Ding, Shenghao" <shenghao-ding@ti.com>
References: 
 <0yjEfELdq8KgSJpwXwJvW10Htk7nW2uES5-hrdsx3iQUTRo3m_gxNgy9pTHxQinv0XiP2d8GWccuIbm3LuZthqwX7FQc_LAg5rncuoCx-70=@proton.me>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: 
 <0yjEfELdq8KgSJpwXwJvW10Htk7nW2uES5-hrdsx3iQUTRo3m_gxNgy9pTHxQinv0XiP2d8GWccuIbm3LuZthqwX7FQc_LAg5rncuoCx-70=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2BTY64SFIMBV3JCOIB3W57OSOLXCR4PP
X-Message-ID-Hash: 2BTY64SFIMBV3JCOIB3W57OSOLXCR4PP
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:28:30 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2BTY64SFIMBV3JCOIB3W57OSOLXCR4PP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> The expected configuration appears to be:
> 
> |link 2:   4 x TAS2783 (mfg_id 0x0102, part_id 0x0000) link 3:   RT712
> SDCA (mfg_id 0x025d, part_id 0x0712) |


There's a similar configuration with another bug report, see

https://bugzilla.kernel.org/show_bug.cgi?id=221782

the symptoms are different but clearly this configuration isn't well
handled just yet.

> Could you confirm whether this configuration is expected to be
> supported, and if so whether a PTL machine-table entry/topology is still
> missing?

It's my understanding that the function topologies are expected now,
machine table entries are no longer required.

In the dmesg log, what's suspicious to me is those lines:

[  225.115571] acpi device:1d: function type only supported as DisCo
constant
[  225.115930] acpi device:1f: function type only supported as DisCo
constant
[  225.116271] acpi device:21: function type only supported as DisCo
constant
[  225.116612] acpi device:23: function type only supported as DisCo
constant
[  225.117313] acpi device:25: SDCA function UAJ (type 6) at 0x1
[  225.117317] acpi device:26: SDCA function SmartMic (type 3) at 0x2
[  225.117320] acpi device:27: SDCA function HID (type 10) at 0x3

not sure why the 4 amps report information that's not well parsed, if
the amps were recognized as such you'd see a clearer log. For now only
the rt712 is handled correctly.
