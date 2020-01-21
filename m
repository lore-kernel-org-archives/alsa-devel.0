Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07CC2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBB6206A2
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W2PN3kDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBB6206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3428167F;
	Tue, 21 Jan 2020 18:30:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3428167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579627875;
	bh=7nr9vkdNxxwQtwcoAjvqWSIFNtkyFHkX0ev82fg3U24=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=W2PN3kDgbSQOl8shy82RJgQfVL4SGPBMl47zXLDnqD/2C9spnH1wITNCtdHWnBkU9
	 q/eZ93aYx0Mml1HvduqobgJDz+aZzvtpHYD6jJGc7np+B1LVWn8OOy+gxZ0/E4nfiq
	 BC9AMGClXK1dDEEthS/r8UenZ37gWhqk4RB1Tak4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFE4FF8028D;
	Tue, 21 Jan 2020 18:28:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E0CDF80277; Tue, 21 Jan 2020 18:28:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CC818F8021D
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC818F8021D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BE8630E;
 Tue, 21 Jan 2020 09:28:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB693F6C4;
 Tue, 21 Jan 2020 09:28:13 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200117073814.82441-2-tzungbi@google.com>
Message-Id: <applied-20200117073814.82441-2-tzungbi@google.com>
X-Patchwork-Hint: ignore
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
Subject: [alsa-devel] Applied "ASoC: max98090: revert "ASoC: max98090: fix
	lockdep warning"" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: max98090: revert "ASoC: max98090: fix lockdep warning"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 08df0d9a00f7ca07511614dd3b137fadd2de56fc Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 17 Jan 2020 15:38:12 +0800
Subject: [PATCH] ASoC: max98090: revert "ASoC: max98090: fix lockdep warning"

Commit 2dc98af62c32 ("ASoC: max98090: fix lockdep warning") introduced
a helpful-less small lock: shdn_lock.  Reverts the commit.

Reasons:

1. Lockdep should not be happy by either the original or current code.
From lockdep's point of view, there is a lock inversion anyway.

Let d = dapm_mutex, c = controls_rwsem, s = shdn_lock,

From the reported calling stack: lock acquisition order of
snd_soc_register_card() is: d -> c.
> snd_ctl_add_replace+0x3c/0x84
> dapm_create_or_share_kcontrol+0x24c/0x2e0
> snd_soc_dapm_new_widgets+0x308/0x594
> snd_soc_bind_card+0x80c/0xad4
> devm_snd_soc_register_card+0x34/0x6c

If calling snd_soc_dapm_put_enum_double() in kcontrol's put (e.g.
SOC_DAPM_ENUM_EXT), lock acquisition order is: c -> d.  Note that,
snd_soc_dapm_put_enum_double() acquires d.

The possible lock inversion is always there if registering sound card
and putting mixer control happen at the same time.  In fact, it never
happens because the control device don't show up to the userspace until
the sound card build success.

Commit 2dc98af62c32 ("ASoC: max98090: fix lockdep warning") changes the
order to: c -> s -> d.  The lock inversion is still there.

2. Commit 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when
changing sensitive registers SHDN bit") designed to use dapm_mutex to
protect SHDN bit.  Use a separate lock breaks the protection.

DAPM changes SHDN bit automatically when it finds the path.  Thus, any
code wants to change the SHDN bit, need to acquire the dapm_mutex first.

> SND_SOC_DAPM_SUPPLY("SHDN", M98090_REG_DEVICE_SHUTDOWN,
>        M98090_SHDNN_SHIFT, 0, NULL, 0),

Fixes: 2dc98af62c32 ("ASoC: max98090: fix lockdep warning")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20200117073814.82441-2-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 10 ++++------
 sound/soc/codecs/max98090.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 454cb8e5b0a1..c01ce4a3f86d 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -52,14 +52,14 @@ static void max98090_shdn_restore_locked(struct max98090_priv *max98090)
 
 static void max98090_shdn_save(struct max98090_priv *max98090)
 {
-	mutex_lock(&max98090->shdn_lock);
+	mutex_lock(&max98090->component->card->dapm_mutex);
 	max98090_shdn_save_locked(max98090);
 }
 
 static void max98090_shdn_restore(struct max98090_priv *max98090)
 {
 	max98090_shdn_restore_locked(max98090);
-	mutex_unlock(&max98090->shdn_lock);
+	mutex_unlock(&max98090->component->card->dapm_mutex);
 }
 
 static int max98090_put_volsw(struct snd_kcontrol *kcontrol,
@@ -2313,12 +2313,12 @@ static void max98090_pll_work(struct max98090_priv *max98090)
 	 */
 
 	/* Toggle shutdown OFF then ON */
-	mutex_lock(&max98090->shdn_lock);
+	mutex_lock(&component->card->dapm_mutex);
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, 0);
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
-	mutex_unlock(&max98090->shdn_lock);
+	mutex_unlock(&component->card->dapm_mutex);
 
 	for (i = 0; i < 10; ++i) {
 		/* Give PLL time to lock */
@@ -2731,8 +2731,6 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	if (max98090 == NULL)
 		return -ENOMEM;
 
-	mutex_init(&max98090->shdn_lock);
-
 	if (ACPI_HANDLE(&i2c->dev)) {
 		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
 					    &i2c->dev);
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index dabd8be34a01..0a31708b7df7 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1539,7 +1539,6 @@ struct max98090_priv {
 	unsigned int pa2en;
 	unsigned int sidetone;
 	bool master;
-	struct mutex shdn_lock;
 	int saved_count;
 	int saved_shdn;
 };
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
