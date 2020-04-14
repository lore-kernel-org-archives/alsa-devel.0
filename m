Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB3C2BB1D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:21:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D172076C
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E7DkpiIb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srcLj/bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D172076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74B4A950;
	Wed, 15 Apr 2020 01:20:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74B4A950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586906501;
	bh=DhBb7YbQg8uA8FQUMAl9TVLqiOPNJ7CzhaFLf19tTVc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E7DkpiIbtR2npldfqtNMfqlNZgUHe8j8CaWlqcdk12wUWUwDACOaCV66IZol1ALbV
	 cEMHyySNYxWsXVf7Fu0nz/CYDaxQvdRZb+Jz3hfo1Eg+jbzDap+OseqxBEFOQM4s8K
	 5ITeXRZFdb58WXqiwxAA0zs8+xHBKsBnk2/71lWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE882F80126;
	Wed, 15 Apr 2020 01:20:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52539F8013D; Wed, 15 Apr 2020 01:20:48 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34EF0F800B9
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 01:20:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34EF0F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="srcLj/bg"
Received: by mail-wr1-x443.google.com with SMTP id k11so16004534wrp.5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BA6IA/KUQ2yk6Fs+gDrfnpceXLK3T7qfruEPRzk2NFI=;
 b=srcLj/bgow42ol0OfDwj9gF5b0/NwgG3x4kAxZ4Wi9wTWZE/8NUED8XWG9oQrvEiFd
 7bI20dbDMEw/AJE0FZ6ehdxcQTodNCjHHIgfDTPSTDPX+7SKlj2ItOx9azKVhNo/aMY9
 dZI9fwAu2Dn6Cu3o1gyFhEHVvGEfXiMbeWN79h7AXlHneWDu/ybXkB6rBXIiVc8PxkFS
 lxFJR4DuczK0PffAC+To3+JuCKwHqQQ7n1XdxJUGdanwRC4qv2r6wgFAb/hD42hnawxS
 2S+80zqllJz4PCP8spCjAuUtAU1L4QxaEzSRgNYnYg4cnFt6zm7C8qWT4N11IfSe8bQt
 pBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BA6IA/KUQ2yk6Fs+gDrfnpceXLK3T7qfruEPRzk2NFI=;
 b=r1Fw8NGfsghBtWT5adYQWAmTuUrY99088d3Zru/TBAxog0mhhrtOgKpsRkicXA23+J
 YbumBZ+j+dkDMV3tX4J33Q2mTPAj3eJW7RNyjV833G6z/eKvRDV5gstdvOEtwk9StOrN
 0oF6QvhV0FlbXRyH+j6JxzjZqhj5Lmg58W5o5CUE5GyKyzap4rxrih/wnyzBGiLHkvqj
 8BsnNvj6o0wKA3U3Z7+9pw1pzbblxeibqdEPB4prbt12YAZMvb9V52RSp+qGFxHdVK12
 /AfQVy0fbNLzH67EHlhZ6CL1yvl2c744H678KbEgeXMZIei+iQIchj1j8jqA/l7R3BVF
 NlgA==
X-Gm-Message-State: AGi0PuaJHRr7ic3E0h413RNZNpTfuPqaOBcpsd4toHd8s97uwR5UhADO
 hGv24vhcdZ98wwrmme3KTVU=
X-Google-Smtp-Source: APiQypJblcyLc4sTu+r7LHFZ4EAosDjPP3fWPPdA7iuVCzViFOggPyIKTnnD4wXeGWEM4quMoFcocw==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr1006795wrw.207.1586906443936; 
 Tue, 14 Apr 2020 16:20:43 -0700 (PDT)
Received: from localhost (108.78.124.78.rev.sfr.net. [78.124.78.108])
 by smtp.gmail.com with ESMTPSA id n4sm20102701wmi.20.2020.04.14.16.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 16:20:43 -0700 (PDT)
Date: Tue, 14 Apr 2020 23:20:30 +0000
From: sylvain.bertrand@gmail.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: sw_params for a direct-ed(dmix) hw pcm
Message-ID: <20200414232030.GA3816@freedom>
References: <59266c58-96d8-93e9-bc8f-86e9fccf8d60@linux.intel.com>
 <20200328222021.GA4610@freedom> <s5hr1xbd2su.wl-tiwai@suse.de>
 <s5hlfng7oaj.wl-tiwai@suse.de> <20200401152538.GA11377@freedom>
 <s5hwo6z2o3r.wl-tiwai@suse.de> <20200401202126.GA9511@freedom>
 <20200402190326.GA12391@freedom> <20200406134957.GA643@freedom>
 <s5hk12ihz98.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s5hk12ihz98.wl-tiwai@suse.de>
User-Agent: Mutt/ (2018-04-13)
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Tue, Apr 14, 2020 at 05:18:27PM +0200, Takashi Iwai wrote:
> If the patch worked for you, basically it's OK to accept.

I did not manage to make it fail. But I found another and unrelated issue, see
github #41 and the patch attempt I did post on the mailing list earlier.

> So, could you post the proper patch for the merge?

I'll try to format that properly.

-- 
Sylvain
