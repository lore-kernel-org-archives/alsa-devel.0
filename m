Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901C5C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Nov 2021 12:09:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B20501936;
	Fri, 26 Nov 2021 13:09:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B20501936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637928594;
	bh=YOscnsoeA6Wvoqn1LuX19RmPd8uIS9PuwPxrBOZyGaA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czep4wSYZtQaGw2K4hFAo+dxhOLx5P0mdADru7Ridm5nQ36nWs74XcsN1v44Tb23V
	 lwc8XWxq2XDG4tENx/3Rng7RAZNQxrSqC9MYXyOV9vKhsrhzzP7VoF7PIOpX5a9KNF
	 S2/4Use3DM7+fTnZkG275hbmEVx4V0p1l17qzFvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACFA5F80538;
	Fri, 26 Nov 2021 13:06:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEB41F80245; Fri, 26 Nov 2021 13:06:06 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2121AF80538
 for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2021 13:06:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2121AF80538
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=collabora.com header.i=@collabora.com header.b="g/a95erA"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 76D361F46849
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637928360; bh=YOscnsoeA6Wvoqn1LuX19RmPd8uIS9PuwPxrBOZyGaA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=g/a95erAcsTOZwS3imAuBf5UcjVPdb48Lz/U8800KEzzklkmxys4QC6C423leKXOW
 zr5gr7qQACvLxQ/uuPtaVvRMvLY0ZVM7Et/E+mVgHEde+tyV/m7FSo2ThLcnMEoRjo
 dwPjTkZJKbxU3fbZQBB/rTtCm6HXxbzb9bDJccehiTqcOZxiXnJBzoZmjEshIpw7yi
 AlybkUVc44QkONqI0LfNhB8Apt+YXuL1DBX1rWxeJsQZ7Z1RCAmS6tt81ec5/QAV3L
 v5shkkX4NS0T61AzgMNb1FlAWDp465nrCI/9QG6W7RHOOCLRcgDIzwj96KVidbB8+Y
 aJfkdDspYTvYQ==
Subject: Re: [PATCH v2 3/8] ASoC: SOF: topology: Add support for Mediatek AFE
 DAI
To: Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
 <20211118100749.54628-4-daniel.baluta@oss.nxp.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <c31d5fd8-4f11-9f8b-f607-ea9191bc1d1b@collabora.com>
Date: Fri, 26 Nov 2021 13:05:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-4-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@gmail.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 lgirdwood@gmail.com,
 =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, yc.hung@mediatek.com,
 daniel.baluta@nxp.com
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

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add new sof dai and config to pass topology file configuration
> to SOF firmware running on Mediatek platform DSP core.
> Add mediatek audio front end(AFE) to the list of supported sof_dais
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
