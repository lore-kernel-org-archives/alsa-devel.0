Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD3C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:04:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8819720637
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aWY6U8Gc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ4jy5Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8819720637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD0D11689;
	Tue, 19 Nov 2019 13:03:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD0D11689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574165080;
	bh=anBfy4TNjWNfC7nmtwmeViDl5jQ+tTwaTqk3uRL8GvQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aWY6U8Gcxb+06KyfPSiRsx2BdQTE5ThPOBwwrkivPsosEF7PUGyNG2jGVOwVKuE+V
	 G0GXmhHcyHvPPiaqbl6Gu2ThNhMqDKVsZVS46aj2YZHpgXirNYSAeSlmSHqvFqH4ed
	 VOlUrMePEtY1l5u5R+n04b5PUPQuqnCJf8+1UqZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26478F80135;
	Tue, 19 Nov 2019 13:03:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13009F80137; Tue, 19 Nov 2019 13:03:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DB68F800FF
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 13:03:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DB68F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hQ4jy5Nw"
Received: from localhost (unknown [171.76.117.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 852F1222DE;
 Tue, 19 Nov 2019 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574162791;
 bh=40G0YoRwx9u64P/Jhv1XvsB/25EhiboE4mOx305imv4=;
 h=Date:From:To:Cc:Subject:From;
 b=hQ4jy5NwGpFX2CWuAkynZjc6ZcboZlXJhPu1iZKpqaL/4qftu7o6G165W4rOzxxhH
 cyr//dX6AU0maqyDCUxw8idPr5fXBbuoo4kb11TgfWDaPnh4lBBubUuF1wEArxBw0x
 crhOtmNvyeeFs0zOWX3SkTgp8zijwsh6CoPpaWFM=
Date: Tue, 19 Nov 2019 16:56:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Message-ID: <20191119112625.GD82508@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [ANNOUNCE] fcplay: compressed audio test utility
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

I have forked the cplay test app into fcplay which is a different repo
[1] licensed as LGPLv2.1. The reason for fork was me getting sick of
seeing the tool miss sync word for mp3 and no support for other formats
which I wanted to test. But I was lazy to start exploring all media
formats and write a parser for them so I have used libavcodec to the job
for me which is GPL.

The fcplay links to libavcodec to get compressed audio parameters and
then uses tinycompress to send data to sound card.

It supports mp3 (no more complaints about sync words) and Flac. I will
add more formats, wma etc are in the list along with gapless audio
playback and support for new changes coming to gapless audio playback
as discussed in audio meeting at Lyon.

As usual patches are welcome.

Jaroslav, can we add to alsa-project github as well?

Thanks
-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
