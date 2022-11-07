Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3105C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 10:03:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59CDE822;
	Mon,  7 Nov 2022 11:02:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59CDE822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667815380;
	bh=CrmaftAiUg4UEhNgTb2hqXoDu05GtzedDnh0woigkQs=;
	h=From:Subject:To:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VfwCboKT11Pl+t5CxlrnsJAAHv49UfXtyDmmpYEitZAKyzUfzQr0j0SHA586+H3jF
	 DurcKT1nIlpUw1M7C9AZh8txyn5zKXDeTUznmK5/e8s1CIf6FoiLmvhxi3cWefRGcz
	 C7+sNn3bYt5G+lOUpz1KB0c0jQUsjtI62+VDX1EU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1F89F8024C;
	Mon,  7 Nov 2022 11:02:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2138DF8025A; Mon,  7 Nov 2022 11:02:08 +0100 (CET)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D8A7F800EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 11:01:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D8A7F800EC
X-UUID: 197602d15da44015b8148b3ce29ec060-20221107
X-UUID: 197602d15da44015b8148b3ce29ec060-20221107
Received: from cs2c.com.cn [(192.168.0.8)] by mailgw
 (envelope-from <aichao@kylinos.cn>) (Generic MTA)
 with ESMTP id 1613306883; Mon, 07 Nov 2022 17:01:19 +0800
Received: by cs2c.com.cn (NSMail, from userid 0)
 id 1065C181BCECB; Mon,  7 Nov 2022 17:01:08 +0800 (CST)
From: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTogW1BBVENIXSBBTFNBOiB1c2ItYXVkaW86IGZpeCBIYW1lZGFsIEMyMCB1c2IgY2FtZXJvIGRpc2Nvbm5lY3QgaXNzdWU=?=
To: =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>,
Date: Mon, 07 Nov 2022 17:01:08 +0800
X-Mailer: NSMAIL 6.0
Message-ID: <41c727u0jt-41c727u0ju@nsmail6.0>
References: 87pmdztc1x.wl-tiwai@suse.de
X-Delaysendtime: Mon, 07 Nov 2022 17:01:08 +0800
X-ns-mid: webmail-6368c954-41dh0192
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
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

       I tested the hotplug ãrecord and catch the picture,  this interface
   reset doesn't cause any problem.

   In snd_usb_endpoint_configure,  It set false to interface to deselect
   altsetting at first.

   But , if skip the interface clear (ex.  ep->cur_rate = 0;), there is no
   sound output.


   ----


   ä¸»ãé¢ï¼Re: åå¤: Re: åå¤: Re: [PATCH] ALSA: usb-audio: fix Hamedal C20
   usb camero disconnect issue
   æ¥ãæï¼2022-11-07 16:15
   åä»¶äººï¼Takashi Iwai
   æ¶ä»¶äººï¼è¾è¶

   On Mon, 07 Nov 2022 02:33:57 +0100,
   è¾è¶ wrote:
   >
   >     Yes, the audio device is a UAC1 device, and it used
   set_sample_rate_v1 to
   > set sample.
   >
   >     So, I add a quirk to keep up the USB interface up even if the
   audio stream
   > is closed.
   Well, my question is also about the parameter changes.  This interface
   reset doesn't cause any problem?  Or we should skip the interface
   clear there, too?
   Takashi
   >
   > ----
   >
   > ä¸»ãé¢ï¼Re: åå¤: Re: [PATCH] ALSA: usb-audio: fix Hamedal C20 usb
   camero
   > disconnect issue
   > æ¥ãæï¼2022-11-04 17:59
   > åä»¶äººï¼Takashi Iwai
   > æ¶ä»¶äººï¼è¾è¶
   >
   > On Fri, 04 Nov 2022 10:50:48 +0100,
   > è¾è¶ wrote:
   > >
   > > I 'm sorry, I don't know whether you receiver my mail for 'lsusb
   -v' to
   > > Hamedal C20
   >
   > I received your previous mails including lsusb -v output.  But the
   > post was filtered out by some reason?
   >
   > So the audio device looks like a UAC1 device.  And this one requires
   > to keep up the USB interface up even if the audio stream is closed
   > (not about the parameter changes)?
   >
   > Takashi
   >
   >
