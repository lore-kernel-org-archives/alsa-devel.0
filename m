Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F94C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 11:35:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20FCF1703;
	Wed, 13 Jul 2022 13:34:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20FCF1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657712125;
	bh=IfO+fFhIk47hUCE6tpigUMsBwZHf+UTRF4/LjRn0MEk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rzWhoxq1E2l0HeOw7GflTO0oTvR/RSRRg4IOctuxu3kVXtmp/9mv5DH5FWps/RM9e
	 hT3I+awnHj8iiuGN2XusnSkYKDvtAuA5kIn0Rt8GPU0JwnFharif1rJCDpGLtqmZyN
	 zyT9PunCW8pt/METLifQbAjvth4+Fi6FWCJR2+p0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AE81F8019B;
	Wed, 13 Jul 2022 13:34:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0486F80249; Wed, 13 Jul 2022 13:34:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 738EAF8012B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 13:34:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 738EAF8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1657712064400960922-webhooks-bot@alsa-project.org>
References: <1657712064400960922-webhooks-bot@alsa-project.org>
Subject: snd-aloop working no more on 1.2.7.1
Message-Id: <20220713113431.F0486F80249@alsa1.perex.cz>
Date: Wed, 13 Jul 2022 13:34:31 +0200 (CEST)
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

alsa-project/alsa-lib issue #251 was opened from tramchamploo:

`#
# Place your global alsa-lib configuration here...
#
#
pcm.er4s {
    # Direct hardware access
    type        hw

    # Loopback card name
    #
    # Has to match "id" in the options of the snd-aloop module
    card        "Loopback"

    # Loopback device ID
    device      0

    # Number of audio channels
    #
    # Has to match the number of channels in music player app
    # and in the CamillaDSP input configuration
    channels    2

    # Format of audio stream
    #
    # Has to match the format defined in the
    # of the CamillaDSP input configuration
    format      "FLOAT_LE"

    # Sampling-rate of audio stream
    #
    # Has to match the sampling-rate defined in the
    # CamillaDSP configuration
    rate        48000
}


ctl.er4s {
    type hw
    card "Loopback"
}
`
This is the .asoundrc I'm using, it worked before this update.
Now aplay -L doesn't show this device.
Using mpd to play to the Loopback gets `snd_pcm_hw_params() failed: Invalid argument`.

Btw, alsa should really have a detailed specification on asoundrc file. The value of the format option I specify is from a dsp project, otherwise I have no idea what to write here. And according to [https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gaa14b7f26877a812acbb39811364177f8](snd_pcm_format_t) it's in a totally different format.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/251
Repository URL: https://github.com/alsa-project/alsa-lib
