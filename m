Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4789C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Nov 2022 09:10:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF70B15C1;
	Fri,  4 Nov 2022 10:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF70B15C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667553019;
	bh=BE05OUcqQbzjlg0khQbFRfJ9m2QCp4bm3uGWFM1YB24=;
	h=From:Subject:To:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=s1DQ5aapuZNjItqk68rDv/ZwXZ1nQniuFouFOKc2fYoqe+3JmB48/0RdatdjZw49r
	 MXD+i/atoR9Nv9/HXrVRRLu+TxISzvd5cHYKLh24ZTKzGOUsuENrBC14Rtn0mi0cKr
	 vFfZJsZMO9ao4HIWzKINw8rhXmHjkFeqZqKdOLHI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 674D5F80431;
	Fri,  4 Nov 2022 10:09:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B85BF80448; Fri,  4 Nov 2022 10:09:27 +0100 (CET)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18A75F80149
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2022 10:09:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18A75F80149
X-UUID: 6b03bae908d04a5daa15a9b53a9df1b8-20221104
X-UUID: 6b03bae908d04a5daa15a9b53a9df1b8-20221104
Received: from cs2c.com.cn [(192.168.0.8)] by mailgw
 (envelope-from <aichao@kylinos.cn>) (Generic MTA)
 with ESMTP id 1945938849; Fri, 04 Nov 2022 17:09:11 +0800
Received: by cs2c.com.cn (NSMail, from userid 0)
 id A5E91181BBF3D; Fri,  4 Nov 2022 17:09:02 +0800 (CST)
From: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBBTFNBOiB1c2ItYXVkaW86IGZpeCBIYW1lZGFsIEMyMCB1c2IgY2FtZXJvIGRpc2Nvbm5lY3QgaXNzdWU=?=
To: <tiwai@suse.de>,
Date: Fri, 04 Nov 2022 17:09:02 +0800
X-Mailer: NSMAIL 6.0
Message-ID: <1s92f1bcedp-1s92f1bcedq@nsmail6.0>
References: 871qqjkutb.wl-tiwai@suse.de
X-Delaysendtime: Fri, 04 Nov 2022 17:09:02 +0800
X-ns-mid: webmail-6364d6ae-1s93oz4r
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

   I'm so sorry

    My full name is Ai  Chao.


   ----


   ä¸»ãé¢ï¼Re: [PATCH] ALSA: usb-audio: fix Hamedal C20 usb camero
   disconnect issue
   æ¥ãæï¼2022-11-04 16:06
   åä»¶äººï¼tiwai@suse.de
   æ¶ä»¶äººï¼è¾è¶

   On Fri, 04 Nov 2022 08:35:18 +0100,
   aichao wrote:
   >
   > For Hamedal C20, the current rate is different from the runtime rate,
   > snd_usb_endpoint stop and close endpoint to resetting rate.
   > if snd_usb_endpoint close the endpoint, sometimes usb will
   >  disconnect the device.
   >
   > Signed-off-by: aichao <aichao@kylinos.cn>
   OK, this is more understandable than the previous one.
   But it doesn't look like a proper workaround, and we need to figure
   out the culprit more deeply.  The interface is anyway reset once when
   the parameter is changed / re-setup.  Doesn't it hit the same problem?
   Or it's about clearing the interface and keep it for long time?
   In anyway, please give lsusb -v output of the device.
   BTW, is aichao your full name?  The sign-off must be with the real
   full name, and it's a legal requirement.
   thanks,
   Takashi
   > ---
   >  sound/usb/endpoint.c | 4 +++-
   >  1 file changed, 3 insertions(+), 1 deletion(-)
   >
   > diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
   > index 533919a28856..c19e420b1780 100644
   > --- a/sound/usb/endpoint.c
   > +++ b/sound/usb/endpoint.c
   > @@ -825,7 +825,9 @@ void snd_usb_endpoint_close(struct snd_usb_audio
   *chip,
   >   usb_audio_dbg(chip, "Closing EP 0x%x (count %d)\n",
   >        ep->ep_num, ep->opened);
   >
   > - if (!--ep->iface_ref->opened)
   > + if (!--ep->iface_ref->opened
   > + && (le16_to_cpu(chip->dev->descriptor.idVendor) != 0x0525)
   > + && (le16_to_cpu(chip->dev->descriptor.idProduct) != 0xa4ad))
   >   endpoint_set_interface(chip, ep, false);
   >
   >   if (!--ep->opened) {
   > --
   > 2.25.1
   >
