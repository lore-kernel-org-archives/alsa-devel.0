Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8BC47253
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 13:09:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155DA2071E
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 13:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OPtmghmK";
	dkim=pass (1024-bit key) header.d=precisionplanting.com header.i=@precisionplanting.com header.b="byHQVGf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155DA2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=precisionplanting.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 585C01692;
	Fri,  1 May 2020 15:08:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 585C01692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588338560;
	bh=Xt49oZOQ3OWZLJrk+59iKPfv8ZYOePQYFAeHYeELCMo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OPtmghmK7ANSuKZO+Rogg/pj+v9YZF4/+Ptl/X80bmzQSffHzGMU25cUseIQG879J
	 bywZA69Eq3fXVabdRcqxFHShFdXNQzOfv2tfzQ5aSKpb2EI8z6eRZhLZ4hR5vj95nr
	 L7MOEPCmZ6wRQu5MBdYHnsl1NnYbHVV+QjdAS1V8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2FB4F80217;
	Fri,  1 May 2020 15:08:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD0C9F8022B; Fri,  1 May 2020 15:08:28 +0200 (CEST)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86771F800B6
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 15:08:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86771F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=precisionplanting.com
 header.i=@precisionplanting.com header.b="byHQVGf0"
Received: by mail-lf1-x143.google.com with SMTP id g10so3796091lfj.13
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2020 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=fgVtz70Z8aTEzW5rAakTT6aERYu3NLiJQMYw7IvTsdQ=;
 b=byHQVGf0Oqi4dV+ggFlVLAxWKkVeyUQCfsHkyAdrOj6B/zgiahN3w+C2J0qSVIDfmx
 0JAehToks0W7EqTTXwLSZ/cZH1JksX5+QjDL+6UXo8foCnVaAoPi0e04eUzMW6kBpXAT
 MSDZJjsZ9WMiTPJR1H8dT5lsJttGSwIRf41I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=fgVtz70Z8aTEzW5rAakTT6aERYu3NLiJQMYw7IvTsdQ=;
 b=jssBmJ6xNefd/5EhYMTQz+OwubYXlpgxxtJo/TT+mcLNqS6eo1ox8HtvaFyZYkhGdM
 yoeS94NVg7w5YEaHbfeT23PLHvHtu65R7KeNMwRVErGVfu97jYLNDRBq0/71HUEg9PIS
 czKpAmlOefB0FUDjlVCjMkWa14/PWo2iXynB1Bu5GYgSClR3oDkhXikKeRsr7VldlBUj
 2dm/Jwi/CRGkGcjlc2fGtvdqyYw7BeSDMdTIkZ2OGU5ZfvmwC8eAim/bW+xNOjBTd9hP
 LVIfTLt1g7lF8CUK7G2QENRdMWSWte9TZ3ZJ8F43nL7nBzRdV8pnYwLQX4OM36tGXSnf
 c6Zg==
X-Gm-Message-State: AGi0PuYzFoJ7OPYFjY9pKZZDqh4asMURQ880zvAFJ5udz8mqmiVXeTjr
 kNJLpowhlrdCK7eBrQFL7zVGP6kyxLSj29ybdKDeSbhVbHjMjQ==
X-Google-Smtp-Source: APiQypIe5Gqxs4cZf3AJAhl9kyH9/81ejOIKnToHbEXTXtNtYJGYWvSVj7se2INWCQjJ/KEBbvJQU5QXEXzFVqTofKc=
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr2625935lfo.128.1588338500548; 
 Fri, 01 May 2020 06:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyfbRWixaWLSGMU4Urd6wne1XoTPtZKL0aho1GjsY-rj7_fVw@mail.gmail.com>
In-Reply-To: <CAOyfbRWixaWLSGMU4Urd6wne1XoTPtZKL0aho1GjsY-rj7_fVw@mail.gmail.com>
From: Dexter Travis <dexter.travis@precisionplanting.com>
Date: Fri, 1 May 2020 08:08:09 -0500
Message-ID: <CAOyfbRVYhf==xo99+2oq_==Q5TJbTGE=eOPZ81xqrQ+9uUqXOg@mail.gmail.com>
Subject: Re: TLV320AIC31xx recovery after a SPKVDD power glitch
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

I believe I found a suitable solution.  I intend to put the system
into standby mode and resume from standby when i enter this reduced
power battery backed up state.

I added the following to the tlv320aic31xx.c and eukrea drivers.  I
believe the critical changes is the suspend function for eureka which
unregisters the card as well as the remove function in tlv320aic31xx.c
which cleans up the regulator notifiers. This allows me to
unregister/remove the card on entering low power and restore it
correctly on getting power back.

I am now working on using a single GPIO to trigger suspend on falling
edge and resume on rising edge.

I can clean up the below patch and trim it down to just the essentials
if it is of interest to the community.  This is based on our modified
eukrea-tlv320 driver for use with the TLV320AIC3120.  When cleaned up
I believe it can be used with the mainline eukrea driver as well.

From 8c7998dba1510f2cbab20c69af1f89c807018a6e Mon Sep 17 00:00:00 2001
From: Dexter Travis <dexter.travis@precisionplanting.com>
Date: Wed, 29 Apr 2020 14:24:56 -0500
Subject: [PATCH] add suspend/remove functions to eukrea and tlv to register
 and unregister the sound card on suspend/resume.

---
 sound/soc/codecs/tlv320aic31xx.c | 45 +++++++++++++++++++++++++++++++-
 sound/soc/fsl/eukrea-tlv320.c    | 17 ++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 31daa60695bd..e7db7399fee7 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1314,12 +1314,22 @@ static int aic31xx_set_jack(struct
snd_soc_component *component,
  return 0;
 }

+static int aic31xx_codec_suspend(struct snd_soc_component *component) {
+ printk("DGT: %s:%d\n",  __func__, __LINE__);
+ return 0;
+}
+
+static int aic31xx_codec_resume(struct snd_soc_component *component) {
+ printk("DGT: %s, %d\n",  __func__, __LINE__);
+ return 0;
+}
+
 static int aic31xx_codec_probe(struct snd_soc_component *component)
 {
  struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
  int i, ret;

- dev_dbg(aic31xx->dev, "## %s\n", __func__);
+ dev_dbg(aic31xx->dev, "DGT ## %s\n", __func__);

  aic31xx->component = component;

@@ -1357,8 +1367,27 @@ static int aic31xx_codec_probe(struct
snd_soc_component *component)
  return 0;
 }

+static void aic31xx_codec_remove(struct snd_soc_component *component) {
+ struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
+ int i;
+
+ dev_dbg(aic31xx->dev, "DGT: ## %s\n", __func__);
+
+ for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
+ aic31xx->disable_nb[i].nb.notifier_call =
+ aic31xx_regulator_event;
+ aic31xx->disable_nb[i].aic31xx = aic31xx;
+ devm_regulator_unregister_notifier(
+ aic31xx->supplies[i].consumer,
+ &aic31xx->disable_nb[i].nb);
+ }
+};
+
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
  .probe = aic31xx_codec_probe,
+ .suspend = aic31xx_codec_suspend,
+ .resume = aic31xx_codec_resume,
+ .remove = aic31xx_codec_remove,
  .set_jack = aic31xx_set_jack,
  .set_bias_level = aic31xx_set_bias_level,
  .controls = common31xx_snd_controls,
@@ -1372,6 +1401,7 @@ static const struct snd_soc_component_driver
soc_codec_driver_aic31xx = {
  .use_pmdown_time = 1,
  .endianness = 1,
  .non_legacy_dai_naming = 1,
+
 };

 static const struct snd_soc_dai_ops aic31xx_dai_ops = {
@@ -1698,11 +1728,24 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);

+static int aic31xx_i2c_suspend(struct device *dev, pm_message_t state) {
+
+ printk("DGT: %d, %s:%d\n", state.event,  __func__, __LINE__);
+ return 0;
+}
+
+static int aic31xx_i2c_resume(struct device *dev) {
+ printk("DGT: %s, %d\n", __func__, __LINE__);
+ return 0;
+}
+
 static struct i2c_driver aic31xx_i2c_driver = {
  .driver = {
  .name = "tlv320aic31xx-codec",
  .of_match_table = of_match_ptr(tlv320aic31xx_of_match),
  .acpi_match_table = ACPI_PTR(aic31xx_acpi_match),
+ .suspend = aic31xx_i2c_suspend,
+ .resume = aic31xx_i2c_resume,
  },
  .probe = aic31xx_i2c_probe,
  .id_table = aic31xx_i2c_id,
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 09133b085fd2..f4a598a5f18e 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -82,6 +82,18 @@ static struct snd_soc_card eukrea_tlv320 = {
  .num_links = 1,
 };

+static int eukrea_tlv320_suspend(struct platform_device *pdev,
pm_message_t state) {
+ printk("DGT: %s,%d state: %d\n", __func__, __LINE__, state.event);
+ snd_soc_unregister_card(&eukrea_tlv320);
+ return 0;
+}
+
+static int eukrea_tlv320_resume(struct platform_device *pdev) {
+ printk("DGT: %s,%d\n", __func__, __LINE__);
+ snd_soc_register_card(&eukrea_tlv320);
+ return 0;
+}
+
 static int eukrea_tlv320_probe(struct platform_device *pdev)
 {
  int ret;
@@ -89,6 +101,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
  struct device_node *np = pdev->dev.of_node;
  struct device_node *ssi_np = NULL, *codec_np = NULL;
  struct clk *codec_clk = NULL;
+ printk("DGT: %s,%d\n", __func__, __LINE__);
  eukrea_tlv320.dev = &pdev->dev;
  if (np) {
  ret = snd_soc_of_parse_card_name(&eukrea_tlv320,
@@ -120,6 +133,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
  "fsl,mux-int-port node missing or invalid.\n");
  goto err;
  }
+
  ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
  if (ret) {
  dev_err(&pdev->dev,
@@ -214,6 +228,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)

 static int eukrea_tlv320_remove(struct platform_device *pdev)
 {
+ printk("DGT: %s,%d\n", __func__, __LINE__);
  snd_soc_unregister_card(&eukrea_tlv320);

  return 0;
@@ -232,6 +247,8 @@ static struct platform_driver eukrea_tlv320_driver = {
  },
  .probe = eukrea_tlv320_probe,
  .remove = eukrea_tlv320_remove,
+ .suspend = eukrea_tlv320_suspend,
+ .resume = eukrea_tlv320_resume,
 };

 module_platform_driver(eukrea_tlv320_driver);
-- 
2.24.1

On Mon, Apr 27, 2020 at 1:56 PM Dexter Travis
<dexter.travis@precisionplanting.com> wrote:
>
> I have a production agriculture display system using a TLV320AIC3120
> for sound output to a speaker built into the monitor. The primary
> processor is an NXP IMX6 Dual Plus. The system has an internal battery
> backup but not all voltage rails are backed by the battery.  In
> particular SPKVDD the 5V rail to the TLV320AIC3120 is not backed up.
> The rest of the voltage rails to this device are backed by battery.
> After a power glitch we do not emit sound.  Using dynamic debug and
> adding some additional messages to the log It appears the driver is
> working the same both before and after the power glitch.
> We developed this a few years ago using the Freescale/NXP (fsl)
> eureka-tlv320 (with slight modifications for the tlv320aic31xx) and
> tlv320aic31xx.c drivers.
>
> As an experiment i compiled both the eukrea-tlv320 and the
> tlv320aic31xx drivers as modules.  This worked as expected before the
> glitch.  After a glitch if I manually remove the modules and re-insert
> them sound can be restored.
>
> We have a user space application that can detect the power loss and if
> the loss is persistent will gracefully shutdown the system.  When
> power is restored we would like to use this to tell the driver to
> perform some kind of restorative action.  I have tried triggering
> through sysfs various resets to the tlv320aic3120 without success.  So
> far only a full module remove of both eukrea and tlv320 will restore
> sound.  remove and re-insert of either driver by itself does not work.
>
> I have a few questions and areas where I would like advice.
>
> 0) What am i missing or doing wrong?  Should I be taking a different
> approach altogether to this problem?
>
> 1) Should I migrate to simple-audio-card instead of eukrea-tlv320?
>
> 2) Suggestions on what needs to be reset/restored after the power rail
> comes back?
>
> 3) Suggestions on how best to trigger the reset/restore from either
> user space or the kernel?
>
> Below is the relevant sections of our devicetree.
>
>
>         sound {
>                 compatible = "eukrea,asoc-tlv320";
>                 eukrea,model = "pp-gen3display-tlv320aic3120";
>                 ssi-controller = <&ssi2>;
>                 fsl,mux-int-port = <2>;
>                 fsl,mux-ext-port = <3>;
>
>                 clocks = <&clks IMX6QDL_CLK_CKO>;
>         };
>
> &i2c1 {
>         clock-frequency = <100000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_i2c1>;
>         status = "okay";
>
>         tlv320aic3120: tlv320aic3120@18 {
>             reg = <0x18>;
>         };
> ...
>
> &ssi2 {
>         codec-handle = <&tlv320aic3120>;
>         status = "okay";
> };
> &audmux {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_audmux>;
>         status = "okay";
> };
>                 pinctrl_audmux: audmuxgrp {
>                         fsl,pins = <
>                                 MX6QDL_PAD_CSI0_DAT7__AUD3_RXD          0x130b0
>                                 MX6QDL_PAD_CSI0_DAT4__AUD3_TXC          0x130b0
>                                 MX6QDL_PAD_CSI0_DAT5__AUD3_TXD          0x110b0
>                                 MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS         0x130b0
>                                 MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x17059
>                                 MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1         0x130b0
>                         >;
>                 };
>
>
> Attached is our changes to the eukrea driver to support the
> TLV320AIC31xx in our system.
>
>
> Thank you,
>
>
> Dexter Travis
