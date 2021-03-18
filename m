Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F4C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 18:37:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E3264F1D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 18:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E3264F1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A78051693;
	Thu, 18 Mar 2021 19:36:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A78051693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616092633;
	bh=32MVLQm5NpcZUcsApMkyjQjmNOtHJjts4RMDAFFvCzQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cz+mN/K6jr+ldntMiREXUWubMN4Jws69ilq+HrEL31wwWcMUyT3r0Bj4U3z+F1v/m
	 dGBjwbLnTUrccciQmhBJLoKS/GgquZ+WEf4z8qqRXOeGMohIpydQJB445KV8xgN+nH
	 shnsnhyxpkkxwb+KuEa/tTz1ANPfJnbzpEflxO1c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FF19F802E3;
	Thu, 18 Mar 2021 19:36:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D060BF8032B; Thu, 18 Mar 2021 19:36:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83A3DF80218
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 19:36:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83A3DF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TNXtAxGm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C6A664F1B;
 Thu, 18 Mar 2021 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616092571;
 bh=32MVLQm5NpcZUcsApMkyjQjmNOtHJjts4RMDAFFvCzQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TNXtAxGmRKnJVgNHIolBdNvPsmQPjzPJQU+/Qz3yuc5vhALZ7DdilOG80VV1cZu7W
 HGrxD/cZ0lqIAjjZB+Wt7BwptR2JLkrqbygoq/vc/gqugvLUJ4BeBo1L1uHErsaAqo
 1wkjXRMWaqd4DzEVZ0SY52/RsU8RMAmvgu9TWVa2yh+FXds7LVvwPOnmUkXLuej3WC
 A4/5GS6EoGijDo8RuL5a72zHyuGSAgn/vMXPjB/57TwcNmXtwRXhVBWJNy6xKJUyYB
 k7TeDxEn1sA/shqo3x18vb6Fovf1puarEmrCXzrK8KHJLIMf/4fxKHtqRzEKQEhbC0
 mKa3RZ8zuABBg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
Date: Thu, 18 Mar 2021 18:36:01 +0000
Message-Id: <161609213719.41838.1344950391495541076.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317110824.20814-1-brent.lu@intel.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Dharageswari R <dharageswari.r@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Libin Yang <libin.yang@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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

On Wed, 17 Mar 2021 19:08:24 +0800, Brent Lu wrote:
> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
> platform.
> 
> This driver also supports ALC1015Q-CG if running in auto-mode.
> Following table shows the audio interface support of the two
> amplifiers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp support
      commit: ad83b1adc58d6693036fd330d6af95a33564eaae

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
