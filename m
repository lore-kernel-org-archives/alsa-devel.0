Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C3FC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 03:08:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 942AB169C;
	Wed, 30 Nov 2022 04:07:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 942AB169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669777715;
	bh=BI3Z9dPBmCk5iVYsRyfiot/s8BguXHflyKX05PO4JeY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvr4Ngbf/89la998jFQn0kdT5p9YXNjofNZcBCl1vHxWXwrFdfoWbRX0lOpJsczPu
	 ZYdbdUj6PCQWoZabnbpd0GX2ePye4IdaDSE9XfgDWxYY2poEKwq4nOYCfsoUkf8y5Q
	 FtXlzedQm40H4kruuMpCl+X8r0kJus5iy6xLWciM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30E4FF8016B;
	Wed, 30 Nov 2022 04:07:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E3F2F80166; Wed, 30 Nov 2022 04:07:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 64BF8F80166
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 04:07:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64BF8F80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1669777657172286034-webhooks-bot@alsa-project.org>
References: <1669777657172286034-webhooks-bot@alsa-project.org>
Subject: arecord leaves doubled audio at end after a SIGTERM
Message-Id: <20221130030743.7E3F2F80166@alsa1.perex.cz>
Date: Wed, 30 Nov 2022 04:07:43 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils issue #179 was edited from chconnor:

Hello: I issue a command like this:

`arecord -t wav -c 1 -f S16_LE -r44100 -D hw:2,0 test.wav
`

It works fine, but then I hit ctrl-C to terminate. This works, but the file has "junk" at the end that repeats the last fraction of a second. E.g. in this demo file I ctrl-C when I say the word "one", and the recording is like "three, two, on-on":

https://caseyconnor.org/pub/audio/arecord_bug.wav

It's as if it is mistakenly writing a buffer an extra time?

(In my total ignorance and total lack of qualifications, I traced the code to [here](https://github.com/alsa-project/alsa-lib/blob/d28e8cb29485cc93f741b01dc65893c798359963/src/pcm/pcm.c#L7544), but I get lost and can't see if anything is awry...)

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/179
Repository URL: https://github.com/alsa-project/alsa-utils
