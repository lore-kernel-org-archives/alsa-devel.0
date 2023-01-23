Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF98DC05027
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Jan 2023 12:02:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0937F41EE;
	Mon, 23 Jan 2023 13:01:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0937F41EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674475355;
	bh=T8OXRkrHxy3NkHWATjgYaIRI6VNAsIcLGBZEaL9yM/o=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mu4V7zMAwIOWEXDoOxzsBp6sDu52pTLQDQyFIgB11mPtcIA59hvA73ZpuzZV0KY5L
	 zorntwL4/JrgRjvRYeHM+20Ao1MwKbh4H8BkzwUaVvlWUNw4XimVAc8+rr72vgf5yD
	 RXZ5XNsxSxmyqWKKWweacuzCFXiqpL/x+or2PDfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B49EF804A9;
	Mon, 23 Jan 2023 13:01:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 757A2F804C2; Mon, 23 Jan 2023 13:01:42 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 843E4F80132
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2023 13:01:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 843E4F80132
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=aDVBk3f/
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30N7Fv1T020060; Mon, 23 Jan 2023 06:01:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=izTgtVzxPHcMXYUQT4fT9Lgt910Hc0xQkh8SkYDYybU=;
 b=aDVBk3f/tr1HKCI8EI7kpFMnKeu8wohA+AxZ50hBhYAfyZp5rvZu0rHBIB4MrsJFrf9l
 AuEP+yNROCCFlX44orBuS/uFJGxYa/lYEpVzvGnApb7EtDprI2K8FiMP4JAdw7JHQaOw
 M8Nw/HnzPbZPwe3c9VgtjWPNP+8WsXcCYq/Bb3Yi7eNg77Ixw8jIPxHG70+2srUomVGs
 mUsrCN4H5GCIz9Pw0uZp4HW031eZJ0pkejGbMkYfrHO9ZsOserREaBJv+upFqJubQkT7
 h9kYpQX+dhNaiF9g7LKrfb4JIfsMYSNAz6Fp5Ht0MXccwN6ajCJt8a256Ah2kSd9JxQ4 PA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsk93g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jan 2023 06:01:36 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 06:01:34 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via
 Frontend Transport; Mon, 23 Jan 2023 06:01:34 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C722511CB;
 Mon, 23 Jan 2023 12:01:34 +0000 (UTC)
Date: Mon, 23 Jan 2023 12:01:34 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: Question about DPCM private_data of soc-compress.c
Message-ID: <20230123120134.GW36097@ediswmail.ad.cirrus.com>
References: <87tu0i6j7j.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87tu0i6j7j.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: bUUrGy2PgqUKq0gYjz6nlMasaHlLsg5G
X-Proofpoint-GUID: bUUrGy2PgqUKq0gYjz6nlMasaHlLsg5G
X-Proofpoint-Spam-Reason: safe
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Jan 23, 2023 at 03:08:49AM +0000, Kuninori Morimoto wrote:
> 
> Hi ALSA ML
> 
> I'm not familiar with soc-compress.c, but I think dpcm_capture case don't need "else" ?
> I think it is same as soc-pcm.c :: soc_new_pcm().
> I'm happy to post patch if someone acknowledge this question.
> 
> 	--- soc-compress.c --------
> 	int snd_soc_new_compress(...)
> 	{
> 		...
> 		if (rtd->dai_link->dynamic) {
> 			...
> 			if (rtd->dai_link->dpcm_playback)
> 				be_pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
> -			else if (rtd->dai_link->dpcm_capture)
> +			if (rtd->dai_link->dpcm_capture)
> 				be_pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
> 			...
> 		}
> 		...
> 	}
> 
> 	--- soc-pcm.c ---------------
> 	int soc_new_pcm(...)
> 	{
> 		...
> 		if (rtd->dai_link->no_pcm || rtd->dai_link->params) {
> 			if (playback)
> 				pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
> =>			if (capture)
> 				pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
> 			goto out;
> 		}
> 		...
> 	}
> 

I would certainly agree, pretty sure the else is redundant.

Thanks,
Charles
