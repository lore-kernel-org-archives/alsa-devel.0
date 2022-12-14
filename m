Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D868C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 21:24:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D73C62A2A;
	Wed, 14 Dec 2022 22:23:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D73C62A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671053088;
	bh=6i+uXOcEHXv6R+BKqJ2YEdmE4HKT/+VF1N8+Qs62I1w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IsjCwbJNSPKgmp+HmwzxCsvXWXTKOZGRiIHPUPIMxrOjjRd/sj9SRCNp2hvdwyLHB
	 7JmMOzfqCK9Rtt6rGbJcPTCbSAKwcQ8k90RbDSwCvJ3E4HdBu1Ag0gYjPgvKQ4KQeq
	 igOPfvcgaIlhMAXc6OOeBoh5wIOO8H4oUy9axmnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84C5CF804D0;
	Wed, 14 Dec 2022 22:23:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08BD8F804D7; Wed, 14 Dec 2022 22:23:57 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 893D4F80141
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 22:23:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 893D4F80141
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=u1jzofNs
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1560DB818D2;
 Wed, 14 Dec 2022 21:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BFC433EF;
 Wed, 14 Dec 2022 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671053032;
 bh=6i+uXOcEHXv6R+BKqJ2YEdmE4HKT/+VF1N8+Qs62I1w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=u1jzofNsDf/5KBreS3+NETXWD+t1sim9Juk0Qw5ZP2X4G2zYRDmYOUI8/MhbHdsOE
 W33/gAj1xfVeFwnARL2bNBdzIhluwFeDy5/SRWDnElaFJ9gE04AxgShT6hovFn+X33
 RJ7t5HVBwjpvpsQUUnQBfWOZpm+rAnwkQDJqJ90VSmSiB84t1Ok8ZHca7aPrZ599VR
 pNTc1IyRwhp2UfCdqkHAPpvOiWsMO8Fm3PSQJdHciG5MQuCaQiLadXyT2SO6+fvJtV
 SKC/WfjaWlC83tKp8GCeDsgiiKQjEFtkGiTH6z5qgIxzlVPev/OdZolkuEiYynWzRc
 oyeDkyWCQkqZw==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, Moises Cardona <moisesmcardona@gmail.com>
In-Reply-To: <20221214120830.1572474-1-moisesmcardona@gmail.com>
References: <20221214120830.1572474-1-moisesmcardona@gmail.com>
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Message-Id: <167105302976.462250.4837987756943780848.b4-ty@kernel.org>
Date: Wed, 14 Dec 2022 21:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 liam.r.girdwood@linux.intel.com, hdegoede@redhat.com, akihiko.odaki@gmail.com,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 14 Dec 2022 07:08:30 -0500, Moises Cardona wrote:
> The bytcr_rt5640.c file already supports the HP Stream 7.
> 
> The HP Stream 8 is almost identical in terms of the hardware
> with the exception of it having stereo speakers, a SIM
> card slot and the obvious size difference.
> 
> Signed-off-by Moises Cardona <moisesmcardona@gmail.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Add HP Stream 8 to bytcr_rt5640.c
      commit: ff5870a76c2abda389650d3711cdddc031d12665

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
