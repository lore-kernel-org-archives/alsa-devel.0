Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0A7ECAAD5
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Aug 2022 07:57:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B03D784C;
	Mon, 29 Aug 2022 09:56:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B03D784C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661759869;
	bh=tdg5jbYt+YslfreOW3Uxk7qDjbgfK+zKxfWBoEd1pMo=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FK/PV1Bdz9sUW3yZlENv/TjOlxDIkBGSo2YAIjJtdLmnNTwI7dlPh4PSyGus79kFc
	 XnH7xR31O4w2Dzf/Y+OHNk28R1cZ3CuQfPeJS8eV73/KHnfvSjZtuSp+ynoso9r+70
	 S4C1B1jAUAfFMa9RcSgVny2DB/jVLYshMI4+pI60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CDBFF8016C;
	Mon, 29 Aug 2022 09:56:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D661F80115; Mon, 29 Aug 2022 09:56:58 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66C8FF80115
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2022 09:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66C8FF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="thqj4eCk"
X-UUID: d9cfa2bf1ddf4abfba39b9510fd48926-20220829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=miZndxyF6YKAyMt7o0rUzgMH4DUEGODcK1zWe2li5JA=; 
 b=thqj4eCk41JBMwIP35QF8iLmYU+ATaOcbzaVdSVhYl9yYi0XXJfMs1bgpq7oZ481gq5GJAkm0vH+0llPXjdzJxiNxddlVnBPGa5TrByXEB84Im7o0GcGegSn+72rzeMu7H6/qJmI++CZ1Lk9goePH6l4xRmEM+Qxqtkfn8MejIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10, REQID:788028ea-74c5-442a-a997-23c8fece900f, OB:0,
 L
 OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
 _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18, CLOUDID:780c6820-1c20-48a5-82a0-25f9c331906d,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d9cfa2bf1ddf4abfba39b9510fd48926-20220829
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <chihhao.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 3219923; Mon, 29 Aug 2022 15:56:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 29 Aug 2022 15:56:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 29 Aug 2022 15:56:42 +0800
Message-ID: <120e52d94c00aab2cf1f3d611b06f03356e8229f.camel@mediatek.com>
Subject: Re: missing sound on kernel-5.15
From: chihhao chen <chihhao.chen@mediatek.com>
To: <tiwai@suse.de>
Date: Mon, 29 Aug 2022 15:56:42 +0800
In-Reply-To: <YwNvQaNNIKB8ELhR@geday>
References: <87e6d6ae69d68dc588ac9acc8c0f24d6188375c3.camel@mediatek.com>
 <YwNvQaNNIKB8ELhR@geday>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Cc: alsa-devel@alsa-project.org
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

Hi Takashi,

Because of this problem, is it okay to remove configure_endpoints
function call in snd_usb_hw_params?

Then configure_endpoints would be called in snd_usb_pcm_prepare and USB
control transfers become the same as which in kernel-5.10. There will
be only one SAMPLING_FREQ_CONTROL request and no sound-missing
phenomenon.

Thanks


On Mon, 2022-08-22 at 08:57 -0300, Geraldo Nascimento wrote:
> On Mon, Aug 22, 2022 at 04:06:58PM +0800, chihhao chen wrote:
> > I am testing many headsets on Android platform with different
> > kernel
> > versions.
> > 
> > On kernel-5.10, calling sequence for playback is
> > 1. snd_usb_hw_params -> set highest sampling rate, no
> > SAMPLING_FREQ_CONTROL USB request sent in this stage
> > 2. snd_pcm_release
> > 3. snd_usb_hw_params -> set proper sampling rate, still no
> > SAMPLING_FREQ_CONTROL USB request 
> > 4. snd_usb_pcm_parepare -> in configure_endpoint
> > SAMPLING_FREQ_CONTROL
> > USB request was sent on USB bus
> > 
> > With the same calling sequence, a slightly behavior change on
> > kernel-
> > 5.15 is
> > 1. snd_usb_hw_params -> set highest sampling rate,
> > SAMPLING_FREQ_CONTROL USB request  was sent on USB bus
> > 2. snd_pcm_release
> > 3. snd_usb_hw_params -> set proper sampling rate,
> > SAMPLING_FREQ_CONTROL
> > USB request  was sent too
> > (because configure_endpoint was moved to snd_usb_hw_params
> > function)
> > 4. snd_usb_pcm_parepare -> no SAMPLING_FREQ_CONTROL USB
> > request  because of USB EP flag check
> > 
> > I checked all USB packets and confirmed audio data output was
> > correct.
> > But there may be missing sound problem for the first sound with
> > many
> > headsets (for example Samsung headset).
> > I found this issue is related to two-times sampling rate set
> > request.
> > (I tried to forcibly skip first USB request, everything became
> > okay.)
> > So do you guys know why configure_endpoint was moved to
> > snd_usb_hw_params?
> 
> Hi Chihhao,
> 
> the commit you're looking for is
> bf6313a0ff766925462e97b4e733d5952de02367
> ("ALSA: usb-audio: Refactor endpoint management")
> 
> Good luck,
> Geraldo Nascimento
> 
> > Or could you provide patch for this problem?
> > 
> > Many thanks
> > Chihhao
> > 

