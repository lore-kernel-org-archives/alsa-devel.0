Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A3C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 10:43:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9C461052
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 10:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B9C461052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 676011ADC;
	Tue, 27 Jul 2021 12:42:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 676011ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627382619;
	bh=8nv8xwa0qoAOi7QQ91NaQ7pT7WgRJhLjaXw+Ofssl0Q=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7NOyxcPbXJyJvlmYfeFRqbvM61+hTfOBYtN6tH376CFNd3sSsRJpz0Y+1O0up0H8
	 mmxvzPAJa/RcETkhU2P1rE0aueYOe6wftTyjIRokygTixpMgu6aw4zLUBr3/H3+p1a
	 U1wHjWOczidNdk2DGZTaz38Kpa6sDlB29YeMKFHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2F7AF80212;
	Tue, 27 Jul 2021 12:42:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C68BF8026C; Tue, 27 Jul 2021 12:42:47 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0873FF80159
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 12:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0873FF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="YEq93zH9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=79IMAl65lHLejQhv6/b+f/+BeXSM6ILBN3Uaf7DlIjI=; b=YEq93zH9jbQneUCC/OXPIg/sqq
 /D3w4z8OBgN7W8h1L0/c4kRNombouCS3h+Dm+O2AlPohLvTBU+uuajMc5QDLDnYajjkFk6qQpUNop
 WVobiSbazTLVWUGz01G1zLI8fuVhZOG5wvg7DMFAZYSPor4LxzlWVnP1pTw27IQ2gue0=;
Received: from [10.8.10.223]
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <puleglot@puleglot.ru>)
 id 1m8KXn-0000zm-J9; Tue, 27 Jul 2021 13:42:38 +0300
Message-ID: <b64108ad64550d51537c5d1ddb04249d6ea5faed.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: Add registration quirk for JBL Quantum
 600
From: Alexander Tsoy <alexander@tsoy.me>
To: alsa-devel@alsa-project.org
Date: Tue, 27 Jul 2021 13:42:37 +0300
In-Reply-To: <0feab0ff6f3f64f2a137676b084654df534f8d8a.camel@argudo.org>
References: <20210727093326.1153366-1-alexander@tsoy.me>
 <0feab0ff6f3f64f2a137676b084654df534f8d8a.camel@argudo.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Jean-Paul Argudo <jean-paul@argudo.org>
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

В Вт, 27/07/2021 в 11:54 +0200, Jean-Paul Argudo пишет:
> Hi Alexander, 
> 
> Le mardi 27 juillet 2021 à 12:33 +0300, Alexander Tsoy a écrit :
> > Apparently JBL Quantum 600 has multiple hardware revisions. Apply
> > registration quirk to another device id as well.
> > 
> > Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
> > ---
> >  sound/usb/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> > index e7accd87e063..326d1b0ea5e6 100644
> > --- a/sound/usb/quirks.c
> > +++ b/sound/usb/quirks.c
> > @@ -1899,6 +1899,7 @@ static const struct registration_quirk
> > registration_quirks[] = {
> >         REG_QUIRK_ENTRY(0x0951, 0x16ea, 2),     /* Kingston HyperX
> > Cloud Flight S */
> >         REG_QUIRK_ENTRY(0x0ecb, 0x1f46, 2),     /* JBL Quantum 600 */
> >         REG_QUIRK_ENTRY(0x0ecb, 0x2039, 2),     /* JBL Quantum 400 */
> > +       REG_QUIRK_ENTRY(0x0ecb, 0x203c, 2),     /* JBL Quantum 600 */
> 
> 
> Thanks! 
> 
> Thank you to Takashi Iwai also, who helped me a lot!
> 
> Just wondering how you could possibly "find" all devices id for those
> JBL headsets? I mean if the 600 has multiple hardware revisions, is it
> possible the 400 and 800 series too? 

We can only rely on bug reports and public databases I guess. The
current list is gathered from multiple sources:
https://bugzilla.kernel.org/show_bug.cgi?id=212669
https://www.spinics.net/lists/alsa-devel/msg129070.html
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/998
https://github.com/linuxhw/LsUSB/

> 
> 
> Thanks again,
> 
> 
> >         REG_QUIRK_ENTRY(0x0ecb, 0x203e, 2),     /* JBL Quantum 800 */
> >         { 0 }                                   /* terminator */
> >  };
> 


