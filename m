Return-Path: <SRS0=g44s=O6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C9AC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 10 Oct 2021 11:26:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9EB60F9D
	for <alsa-devel@archiver.kernel.org>; Sun, 10 Oct 2021 11:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E9EB60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3A24167D;
	Sun, 10 Oct 2021 13:25:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3A24167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633865185;
	bh=3rW4Dukv0L7BVIaBbObMk8a9jUMv/N6vEEL9opUeusc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1dr4fu8mrE/NMiHkrlMA6nxlgnSVThaXbMu5IKb42H9QS/hU+x3mC3aJfid3QAaX
	 gCbWuhIKvzhWez15cO37Tl/bzAEqCOuxQVbe+GNkUq9dYAcISdeYtRwNBdvLmCXfV1
	 QExyNIZe0HnSpvJvlCQs1LsGJavCwSXx9urM+KVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B484F801D5;
	Sun, 10 Oct 2021 13:25:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1084F801F7; Sun, 10 Oct 2021 13:25:33 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BE63F8016D
 for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2021 13:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BE63F8016D
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 54D03FB03;
 Sun, 10 Oct 2021 13:25:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSDyrNOlMlRU; Sun, 10 Oct 2021 13:25:27 +0200 (CEST)
Date: Sun, 10 Oct 2021 13:25:25 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Message-ID: <YWLNpbvxWp/81lXz@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend>
 <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
 <5069869.zQgEQKRxDW@bagend>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5069869.zQgEQKRxDW@bagend>
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <treding@nvidia.com>
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

Hi,
On Sun, Oct 10, 2021 at 12:40:00PM +0200, Diederik de Haas wrote:
> On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
> > > Unfortunately this change broke multichannel audio on my Rock64 device
> > > running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a
> > > HDMI cable.
> > This looks like an user space configuration problem.
> 
> I have placed ALSA card definitions (I think) from LibreELEC on my system from
> https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
> filesystem/usr/share/alsa/cards

You likely have the paths wrong, see how `simple-card` ends up in the
config file path:

   https://github.com/alsa-project/alsa-ucm-conf/pull/102/files

Cheers,
 -- Guido

