Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C36C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:34:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658012177B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ga/veubH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=definiteaudio.de header.i=@definiteaudio.de header.b="nB4I7mdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658012177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=definiteaudio.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68D871758;
	Tue,  8 Sep 2020 11:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68D871758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599557682;
	bh=JkRNctrqmSvhnqkMiverCEcFlfD5he6/cP6zVKNy6tA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ga/veubHTfMCrxUDDBFXMJqwg4OSsXqmnKu0gUzmXKuVzteB6/lIIYD3zOZMlCygI
	 QFlWCGx9WHVx+Au5DUdHxQ54is2D8yqtAS0QslF/8uXMih/TkGzO05BburWthsaCIw
	 yen1NebApY2qQPgffTeiWPbboAPrPyK2ejVfkD6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB6B0F801F2;
	Tue,  8 Sep 2020 11:33:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47632F8026F; Tue,  8 Sep 2020 11:33:50 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 509C0F8010B
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 11:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 509C0F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=definiteaudio.de header.i=@definiteaudio.de
 header.b="nB4I7mdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599557620;
 s=strato-dkim-0002; d=definiteaudio.de;
 h=Message-ID:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=zG+zVGk5T2l5nxNEjVn/caXn8bUN6wIOJeotOqnG4oM=;
 b=nB4I7mdC8x5msNB0sDoAncAV81U/C0e5J7Bqqpm8tzvVtHw8GcnFj3QLVd9Uc5VkO1
 f7qpTnN4fIvD8NGDElSshsqHrR67u+9mSpECOffTuy9zTzPlN2b4UsdJGTchj4D+VMHY
 CgbNej09+C1XnT/Kr+JIO8Hz/MzwFOc82yzxp4KVcOM81fzVOgBbK+oeud/D8qfPk1zE
 yvMaeUKBgHBHmaDXVhGb0uaQamDIRnHFcF8119F4DV/Tw/pSRdH0ra3xwQ7hBFzik+Ny
 vigfwwcW7ndm86JE6i1f3yikwDM28jCOk0wHSRm+6/Sy8JwMAZkNhsExarbLTqKnN7tj
 FtcA==
X-RZG-AUTH: ":JWICemCsfvk3ehlOmKmdx0CAz5pAM1N6ndVN/EbpzEy6tveMQc0pZJOI7ix8ltNrqyQO8Ta4yYkOXYJZ3dr0CZaIattkeEV/6kn0Pf5bl23wTY0="
X-RZG-CLASS-ID: mo00
Received: from NB180 by smtp.strato.de (RZmta 46.10.7 AUTH)
 with ESMTPSA id c01148w889Xdsce
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 8 Sep 2020 11:33:39 +0200 (CEST)
From: <info@definiteaudio.de>
To: <alsa-devel@alsa-project.org>
Subject: Additional features for ALSA Loopback Device?
Date: Tue, 8 Sep 2020 11:29:01 +0200
Message-ID: <01a601d685c2$7d041ee0$770c5ca0$@definiteaudio.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdaFwCK1Xud2QOUyTxu0gVxl7B0K+g==
Content-Language: de
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: info@definiteaudio.de
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

Hello,

I'm new here and I urgently need some functionality enhancements for the
ALSA loopback device.

 

Probably  this is not the right place to drop my request but my thought was,
that maybe here I can find a developer that is able and willing to realize
my requests. For sure my company is willing to pay for it!

 

Thank you for reading and I really appreciate your help.

 

Here are the requested additional features:

1.	Display a custom name for the card instead of "Loopback PCM" (should
be entered as parameter in modprobe).
2.	Increase max. sample rate to 384k (currently max. is 192k)
3.	Currently two soundcards are installed that are interconnected vice
versa. We need to have one card only where the output is interconnected to
the input.

 

Hope this can be realized.

 

Best

Dr. Carl-Werner Oehlrich

definiteAudio GmbH

mail: info@definiteaudio.de <mailto:info@definiteaudio.de> 

 

 

 

 

 

