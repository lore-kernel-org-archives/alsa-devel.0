Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E443FC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 20:26:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD13225BB;
	Wed,  8 Dec 2021 21:25:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD13225BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638995176;
	bh=HD7WXhTfMPOyecXCnvDUCvKIjkIm6IiSrQh06hPqeZ4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atz/Kvexb2iYl3Df8RrfuW3qm5OB9LOD+fjBxT8nVIkUys6dFXHteBlNr0EMtK1Gr
	 28m0oEdMsLOQeC47oy63oKKU25PpoVUNRbD+4vAID6DbdK/QNgKWZZIrOjfjgI82Jh
	 wFmJhF3tBdxVREzsShnJG3P/bA8xLfsR2D8Hnbu8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B54FF804CC;
	Wed,  8 Dec 2021 21:25:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DFEAF804E5; Wed,  8 Dec 2021 21:25:25 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42C0AF80103
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 21:25:15 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6046AA003F;
 Wed,  8 Dec 2021 21:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6046AA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1638995114; bh=ZmSlxHFTTANPlzLGsy+tkobABA2RwHN/Rim8XYjrOgo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mcstFoZuKzL+ur7Zd5z8dU2irkFFtsri7L/g+h1yGaaTYO/gdcJCwovt69jJBfyIh
 mINgH1h77jloF5iYyLrvTINLPzk4Rpv0/EmfmObD8tS+u20Eu11DNJfL1PyxMAEDXP
 SaeQ+dk1qCwkXMaFerP+VtSAu/INRLSDBCkomRvk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  8 Dec 2021 21:25:04 +0100 (CET)
Message-ID: <1571a09a-a766-a733-e23f-36cf1ab14b86@perex.cz>
Date: Wed, 8 Dec 2021 21:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Content-Language: en-US
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sunil-kumar.Dommati@amd.com, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Vijendar.Mukunda@amd.com,
 Alexander.Deucher@amd.com
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

On 08. 12. 21 19:58, Ajit Kumar Pandey wrote:
> Add "Playback Switch" mixer control to mute or unmute speaker
> playback from ucm conf depend on use cases.
> 
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

The "Playback Switch" is too short. It should be more specific (Headphone, 
Speaker etc.).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
