Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D3C433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Dec 2021 17:31:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E2F21739;
	Sun, 26 Dec 2021 18:30:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E2F21739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640539880;
	bh=U9rcJ3Kpo75RSFKRBbChBsejkN1ghjOOXJQFHCEFhEQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewa7vj6Z4I1fda1oNWmXxfmB+AUWaoB4TFSnsNxDp4xGHToOg1k+rh+s59i5Qeecw
	 6qCdUe+pV89Mhq1mwsjmzHZ+P+q8ib18wwVarqf4ANhx98OBh8Fi3S65ca304c2SEA
	 34ApoL4DVIUvFyANO/SZwmDkeaTjcPXvpMEo0awc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34F8EF801D8;
	Sun, 26 Dec 2021 18:30:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 565E5F8020C; Sun, 26 Dec 2021 18:30:27 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEF37F800E9
 for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2021 18:30:21 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 325D4A003F;
 Sun, 26 Dec 2021 18:30:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 325D4A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1640539820; bh=Mz3IOdR6anrqXBSOsewJ/Xsu3u9G4cJ3hC+Mdtyearg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nuqJDESxYM7SLQt7GVNf9T++B8/ZQ6cuPRUJsYFwLT2zbkgJnar32yNweJGll2l/8
 5mf+hq7MuvXErWwEnoiqtVwsaPFXBjIOzPzh6dzW6WGM3acKFjPFZrrgTUg4hT7RWa
 W7dKytj+5/zj9xOTH8gscYqeL31GRkpxnfb5GVUI=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 26 Dec 2021 18:30:15 +0100 (CET)
Message-ID: <3cd96113-3272-1efe-aa81-39de952d1e68@perex.cz>
Date: Sun, 26 Dec 2021 18:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND] Amlogic DPCM audio card(s) speaker placement issue
Content-Language: en-US
To: Christian Hewitt <christianshewitt@gmail.com>, alsa-devel@alsa-project.org
References: <ECC56215-1E02-4735-82F3-B68E73F56CB4@gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <ECC56215-1E02-4735-82F3-B68E73F56CB4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Reichl <hias@horus.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-amlogic@lists.infradead.org
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

On 26. 12. 21 12:43, Christian Hewitt wrote:

> **** List of PLAYBACK Hardware Devices ****
> card 0: LIBRETECHCC [LIBRETECH-CC], device 0: fe.dai-link-0 (*) []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

> numid=12,iface=PCM,name='ELD',device=2
> numid=11,iface=PCM,name='IEC958 Playback Default',device=2
> numid=10,iface=PCM,name='IEC958 Playback Mask',device=2
> numid=9,iface=PCM,name='Playback Channel Map',device=2
> 
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts#L136-L188

Have you tried to reorder the dai-link-# sections in DT? It appears to me that sound/soc/codecs/hdmi-codec.c / hdmi_codec_pcm_new() gets the internal PCM
device rather than the exported PCM device for the user space.

If the DAI routing cannot be changed, then the hdmi-codec.c should be modified to export the correct device number for the user space:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/hdmi-codec.c?h=v5.16-rc6#n805

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
