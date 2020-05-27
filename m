Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6698C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 02:50:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1B1207CB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 02:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nr+r23In"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1B1207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grossmann-venter.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A9A81780;
	Wed, 27 May 2020 04:49:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A9A81780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590547832;
	bh=/Ii+G3fBOKe1Z/JZuKgsReWyAyznLTeORE/DLd8u8/w=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nr+r23InFg/UmZFfSswhKB1jvkOm45irSV7jV6AAtaxmS/qj5GhiMZz/jz+uIwjop
	 QRc1zIrrwrUP162KQOs9AFLDlStANW+O/oJQ0dag7jqBPm2hp+c0YalaWF+nyhzXxH
	 SxgHQnr1enwoPFzDkzd29adwMCzs0fj0K269drRc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15C14F80149;
	Wed, 27 May 2020 04:49:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D860F8014E; Wed, 27 May 2020 04:49:39 +0200 (CEST)
Received: from server54-3.web-hosting.com (server54-3.web-hosting.com
 [198.54.126.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07D28F80146
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 04:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07D28F80146
Received: from [::1] (port=56998 helo=server54.web-hosting.com)
 by server54.web-hosting.com with esmtpa (Exim 4.93)
 (envelope-from <admin@grossmann-venter.com>) id 1jdm8E-001NZN-E1
 for alsa-devel@alsa-project.org; Tue, 26 May 2020 22:49:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 26 May 2020 22:49:26 -0400
From: liebrecht@grossmann-venter.com
To: alsa-devel@alsa-project.org
Subject: Alsa Midi Driver Question/Issue
Message-ID: <770a8eb1beaf66e2ac4d3f12e42adda5@grossmann-venter.com>
X-Sender: admin@grossmann-venter.com
User-Agent: Roundcube Webmail/1.3.8
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server54.web-hosting.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grossmann-venter.com
X-Get-Message-Sender-Via: server54.web-hosting.com: authenticated_id:
 liebrecht@grossmann-venter.com
X-Authenticated-Sender: server54.web-hosting.com: liebrecht@grossmann-venter.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: rewritten was: [admin@grossmann-venter.com],
 actual sender does not match
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

This is not really a straight forward user question and thereby I post 
it in the developer forum.

My Problem:
I use Alsa/Jack/Pulseaudio to run quite an extensive audio interface to 
DAW with involved Jack routings of both Audio and Midi.
The system runs like greased lightning and I can do things on Linux that 
I could never do on windows period.

The problem is that there exist applicatio9ns that is not ALSA/JACK Midi 
friendly.
One such Application is Bitwig for Linux

1) Bitwig absolutely requires to have exclusive access to a USB pad 
Controller in order to recognise the controller.
2) We all know that the Alsa Midi driver forwards ALL Midi devices it 
finds to Jack where the  aj2midid daemon provides a bridge to jack and 
the midi devices are then elegantly routed with jack to jack enabled 
programs. The alsa midi and jack bridge is a thing of beauty.
3) However Bitwig to be able to use a midi pad controller DEMANDS that 
you DISABLE alsa midi driver before it recognizes the midi controller.
4) This is very unfortunate and very W$ndish approach to devices.
5) So at the moment I can either use Bitwig with a pad controller and 
absolutely no other midi through Alsa/Jack will work, or my alsa/jack 
routings work but I cannot use Bitwig with a Midi Controller.

My Question
1) Is it in any way possible to configure the Alsa Midi driver tgo 
ignore a specific Midi device in order that my Alsa/Jack routings can be 
used in conjunction with Bitwig using its pad-controller.
2) To summarize my question, I need to somehow blacklist the midi 
controller to not be touched or accessed ihn any way. Basically totally 
forget about its existence.
3) I am sure this must be possible as there are a lot of W$ndish style 
programs like this developed to need exclusive access to a midi device.
4) I tried to convince the developers of Bitwig to make Bitwig Jack 
aware, but it is seemingly not going to happen. That would have been the 
right way.

I sincerely hope you will have a recommendation I can work on and 
impliment.

Thank you.
