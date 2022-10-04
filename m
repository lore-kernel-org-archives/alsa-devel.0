Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E871C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Oct 2022 02:34:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEDB116FD;
	Tue,  4 Oct 2022 04:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEDB116FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664850841;
	bh=Yn1jbAxiC/edNvh17JqIJIJzbT2X5nA+SfJHVLYIGCk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5U7vbbY0sCD/Yui0/tw88LQiv/kipLHomI6eM7B/C0KaFNKcTNp/wkrAZl6WJwJC
	 +eXrOOLc/hWxwwQxPe/6vJJZBQtjdSfwWPZ/Ztgox+i+NQefEk3dKGkwG/R3XyUYlW
	 TTApesioq+sOGGiMvDeWoOKO9ByyST4e3ABdtz34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78DC2F8012A;
	Tue,  4 Oct 2022 04:33:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64CADF8012A; Tue,  4 Oct 2022 04:33:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 967A6F8012A
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2022 04:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 967A6F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1664850786066464901-webhooks-bot@alsa-project.org>
References: <1664850786066464901-webhooks-bot@alsa-project.org>
Subject: Another ALC4080 hardware identifier to add...
Message-Id: <20221004023310.64CADF8012A@alsa1.perex.cz>
Date: Tue,  4 Oct 2022 04:33:10 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #223 was opened from ethereal-engineer:

Heyo,

I just expanded the regex in 
`/usr/share/alsa/ucm2/USB-Audio/USB-Audio.conf`
to include this guy
`ID 0b05:1a16 ASUSTek Computer, Inc. USB Audio`
which is onboard a
`ROG STRIX Z690-A GAMING WIFI D4`.

Finally, front panel microphone works. I will test the digital output and all other aspects soon. Just wanted to add this ID to the growing pool of identifiers that are not covered at present.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/223
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
