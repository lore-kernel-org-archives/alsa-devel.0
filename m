Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDB7CA5FE3
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:45:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82F8E602A4;
	Sat,  3 Oct 2026 10:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82F8E602A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791017132;
	bh=BnS9K81fPSDp7sLy2mjEXk17/tZkJLgijji/V3gg1O0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Cm9918PX6sqhmcGv16eGi6/BfNyr900ghRA8MU3mbdeLwM5Xjn9j6jaWF9QktJgC6
	 4rHfemAEXAY4XrXcefc7JEQTGblrQo8PzzpNVwh/oEmLj3xmjaMcb2s9KhGhTYld9/
	 +4LCcUXyuArLG2mwxA4MR7NjyJS5FkycEAsbewbI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B230F805F8; Sat,  3 Oct 2026 10:44:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5643F80601;
	Sat,  3 Oct 2026 10:44:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9029DF80548; Sat,  3 Oct 2026 10:44:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791017092;
	b=grAipKKhf6TJlvWT9R0LiQ492IpOa4B1wiux9s0uNxLaa0IfgptRTAGH9kGu6d0W+mTN
	 nAS1HK11nLIrRzaZL3XwaxdeZ0tGtznylckES8SxSYPYuNnnX62FuMmz9SZL4aBvWKoxh
	 xPZ5UalKtqk5Knll/CCRvII2FnDWEZMwsKkR+dhCNT7x4MILF/pmCnuaPrfJHELcZsAZW
	 xwGPHh5V9zYZZa4j56++wDdM7TAYQLLOmpb2QvKL6Z04bhPSV4xvI2qp5ToHGO2aEClju
	 y/eubDuy4HX5FSGg0CYejRSFMTFVimYN8xBK5mh1rVKma2UDwsYe5ePMYZLy/x+rIqA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791017092;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=BnS9K81fPSDp7sLy2mjEXk17/tZkJLgijji/V3gg1O0=;
	b=c9SXO+uo1lPPR8N8xFSHFsnBN/EN+XUJmxhDgnHH74zWGYB6Orh5+1RM9RKihzIr6O9Y
	 OzGO6lAap0JSliyHSaGbc4pKqHPWdQRA/kh1cpXx0Y+ULjJHd1qJOXkUj800cHWA6mj17
	 3lfLCTHonXo/vemaKCgLTSBMarOpm0qtvpPm5GoPckhATd7eyV2gxFTN+QFFJq7jVJ2cN
	 9wlRXsI2hGQWIbPH7vZ8ktuEBmZ52W23U4k9pG3q00mNgX+Oohedz3NlwUpYcrxf1sUBs
	 J97ZXWC9mzu4sdvGFGWSVdk61TT2xhJokajRBVsZUuVXlYIF14E/Z8kh9NL3kh9sP+g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 876C0F80246
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 10:44:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 876C0F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18daf88e1b876b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/528@alsa-project.org>
References: <alsa-project/alsa-lib/pr/528@alsa-project.org>
Subject: seq: snd_seq_parse_address() accepts port name
Date: Sat,  3 Oct 2026 10:44:53 +0200 (CEST)
Message-ID-Hash: EAPXYIO67ONOSGM6I4B3FV6V6WNJTBCV
X-Message-ID-Hash: EAPXYIO67ONOSGM6I4B3FV6V6WNJTBCV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EAPXYIO67ONOSGM6I4B3FV6V6WNJTBCV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #528 was opened from thanks4opensource:

This pull requests allows `snd_seq_parse_address()` to accept port names as well as port id numbers. This improves the usability of `aconnect`, particularly within shell scripts where port names are more readable/self-documenting than port numbers, and are also more robust as client updates are more likely to reorder/renumber ports than to change their names.

The functionality could be added within `aconnect` itself, but doing so inside alsa-lib makes it available for all programs, e.g. ones that use `snd_seq_subscribe_port()`,etc to connect themselves to other clients.

The new code is almost completely compatible with existing use-cases, with one exception: If passed a non-numeric port, a bug in the current `snd_seq_parse_address()` sets 0 for the port id/number without returning an error. This causes `aconnect` to silently make an incorrect connection or fail with a confusing error message.

Consider the following example:

```
$ aconnect -oil
client 128: 'arbitrary_client' [type=user,pid=837984]
    0 'output          '
    1 'input           '
client 129: 'synthesizer' [type=user,pid=837982]
    0 'outside_speaker_input'
    1 'headphone_input '
client 130: 'virtual_piano' [type=user,pid=837983]
    0 'output          '
```
Until I looked at the source code, I never understood:

```
$ aconnect 130 128:100
Connection failed (Invalid argument)
$ aconnect 130 128:input
Connection failed (Operation not permitted)
$ aconnect 130 128:1 
$ aconnect -oil     
client 128: 'arbitrary_client' [type=user,pid=837984]
    0 'output          '
    1 'input           '
	Connected From: 130:0
client 129: 'synthesizer' [type=user,pid=837982]
    0 'outside_speaker_input'
    1 'headphone_input '
client 130: 'virtual_piano' [type=user,pid=837983]
    0 'output          '
	Connecting To: 128:1
```

If the error message had been "Invalid argument" instead of "Operation not permitted" (why can't I connect an output to an input?) it would have been less of a mystery.

Equally confusing, and potentially dangerous:

```
$ aconnect -x
$ aconnect 130 129:headphone_input
$ aconnect -oil                   
client 128: 'arbitrary_client' [type=user,pid=838343]
    0 'output          '
    1 'input           '
client 129: 'synthesizer' [type=user,pid=838347]
    0 'outside_speaker_input'
	Connected From: 130:0
    1 'headphone_input '
client 130: 'virtual_piano' [type=user,pid=838350]
    0 'output          '
	Connecting To: 129:0
```

That's a somewhat contrived example, but imagine it's 3 AM and you want to practice some loud heavy metal keyboard riffs. Suddenly you're in big trouble with your neighbors. ;)

This pull request "does the right thing" in all cases. My general policy is to never change existing behavior, but in this case the "silently convert to port 0" is at best an undocumented feature, and at worst an undeniable bug. Anything relying on it really should be fixed.

The code maintains current feature of accepting a prefix of a client name ("FLU" instead of "FLUID Synth"). If accepts any substring for port names because several common ALSA clients have long port names which differ only at their ends ("alt" for "Synth input alternate"). In both cases an exact name match overrides a prefix/substring.

The branch includes test/address.c which extensively validates `snd_seq_parse_address()` (4349 tests at latest count), including checking returned errors in cases of nonexistent client or port names, out of range client/port id numbers, etc. As necessitated by the sequencer API, and as per the current code, it requires a non-NULL `snd_seq_t*` argument to handle names but will parse purely numeric ids without. It currently does not check whether there are existing clients/ports matching the requested client/port numbers.

I apologize for completely rewriting `snd_seq_parse_address()`, but the existing version parsed the port string before the client, including multiple early returns from the function. The client is required for searching port names, and the code would have been a mess if the order of operations had been retained. Of course I also believe the new version, particularly the parsing of the input string into client and port, is simpler and more readable.

Please consider merging this pull request. Thank you.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/528
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/528.patch
Repository URL: https://github.com/alsa-project/alsa-lib
