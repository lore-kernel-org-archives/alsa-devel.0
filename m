Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEE9C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 06:12:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72DF11945;
	Tue,  7 Jun 2022 08:11:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72DF11945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654582320;
	bh=JJt0IO+HD16nKaMzBkekejjxzH6zJTBr5QCuFRGczGE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=auqnMTxbiW5YdWpt8o6shp2tia53vAiHCADcDsypnBCIdwWfgV+a+tS2wWG1Fpi3r
	 MW0hKhicvhsazcQFDLQnLvcXF6/lSPeXLvscidA+tG9NzmkZcwOOJ31avlOf7MZQXI
	 GPleg2s+Fq0PJmt2IwEpeK4kNda9QZNZR/WqzqzM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A197BF804E6;
	Tue,  7 Jun 2022 08:10:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9DAEF80109; Mon,  6 Jun 2022 17:25:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02B08F80109
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2022 17:25:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02B08F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FQvjxVAj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 84DF061559;
 Mon,  6 Jun 2022 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9A7C341DE;
 Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654529149;
 bh=JJt0IO+HD16nKaMzBkekejjxzH6zJTBr5QCuFRGczGE=;
 h=From:To:Cc:Subject:Date:From;
 b=FQvjxVAjYkRkMlnXeUbGK/ffXS9EGiIGJB6czmy41m7BUi+gGlw+X1Vu+xVWhr8kL
 VZmd7RutDKDJkQ6+PNC2k4EBuWcMiwehnWLeUgcaztEFymFfTpyADom9iKEZ2r0U6R
 8QTKxcO8tqR2nN17KQ7uaYrNw3fG0aG82GOK9/YW0npuVqsyv4lNhNtBEPuUTmVVIT
 XOE4wPosVqLjYqBNBMuGPxA5PXF0QCAYswfnxGdyJu5zTk6VkYY/y8ZNnVzT895FLj
 P6YX/uUQeJAT8yJ01In++Ksk7XfTNpL0aA6OZ6qjgQfLIhLB4De2E2AivHQOnNJprR
 rbUcjc+xUJibQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
 (envelope-from <mchehab@kernel.org>) id 1nyEby-0012On-0x;
 Mon, 06 Jun 2022 16:25:46 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/23] Update Documentation/ cross-references
Date: Mon,  6 Jun 2022 16:25:22 +0100
Message-Id: <cover.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jun 2022 08:10:18 +0200
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, alsa-devel@alsa-project.org,
 keyrings@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-phy@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Federico Vaga <federico.vaga@vaga.pv.it>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Markus Mayer <mmayer@broadcom.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-cachefs@redhat.com, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
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

Hi John,

There were a number of DT binding conversions and other docs change that
were not updated. Address them, in order to keep the cross-references on
a sane state.

Patch series is against v5.19-rc1 (and applies cleanly on the top of
today's -next).

Mauro Carvalho Chehab (23):
  dt-bindings: mfd: bd9571mwv: update rohm,bd9571mwv.yaml reference
  dt-bindings: interrupt-controller: update brcm,l2-intc.yaml reference
  dt-bindings: arm: update vexpress-config.yaml references
  dt-bindings: reset: update st,stih407-powerdown.yaml references
  dt-bindings: mfd: rk808: update rockchip,rk808.yaml reference
  dt-bindings: mmc: exynos-dw-mshc: update samsung,pinctrl.yaml
    reference
  docs: netdev: update maintainer-netdev.rst reference
  docs: filesystems: update netfs-api.rst reference
  Documentation: update watch_queue.rst references
  Documentation: KVM: update s390-pv.rst reference
  Documentation: KVM: update amd-memory-encryption.rst references
  Documentation: KVM: update msr.rst reference
  Documentation: KVM: update s390-diag.rst reference
  MAINTAINERS: update arm,hdlcd.yaml reference
  MAINTAINERS: update arm,komeda.yaml reference
  MAINTAINERS: update arm,malidp.yaml reference
  MAINTAINERS: update cortina,gemini-ethernet.yaml reference
  MAINTAINERS: update dongwoon,dw9807-vcm.yaml reference
  MAINTAINERS: update maxim,max77693.yaml reference
  MAINTAINERS: update snps,axs10x-reset.yaml reference
  objtool: update objtool.txt references
  ASoC: wm8731: update wlf,wm8731.yaml reference
  arch: m68k: q40: README: drop references to IDE driver

 .../ABI/testing/sysfs-driver-bd9571mwv-regulator   |  2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  2 +-
 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |  2 +-
 .../devicetree/bindings/hwmon/vexpress.txt         |  2 +-
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |  2 +-
 .../devicetree/bindings/phy/phy-stih407-usb.txt    |  2 +-
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  |  2 +-
 .../devicetree/bindings/regulator/vexpress.txt     |  2 +-
 .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |  2 +-
 Documentation/devicetree/bindings/usb/dwc3-st.txt  |  2 +-
 Documentation/devicetree/bindings/usb/ehci-st.txt  |  2 +-
 Documentation/devicetree/bindings/usb/ohci-st.txt  |  2 +-
 Documentation/security/keys/core.rst               |  2 +-
 Documentation/security/secrets/coco.rst            |  2 +-
 .../translations/it_IT/networking/netdev-FAQ.rst   |  2 +-
 Documentation/virt/kvm/api.rst                     |  4 ++--
 Documentation/virt/kvm/s390/s390-pv-boot.rst       |  2 +-
 Documentation/virt/kvm/x86/hypercalls.rst          |  2 +-
 Documentation/x86/orc-unwinder.rst                 |  2 +-
 MAINTAINERS                                        | 14 +++++++-------
 arch/m68k/q40/README                               |  4 +---
 include/linux/fscache.h                            |  2 +-
 include/linux/objtool.h                            |  2 +-
 include/linux/watch_queue.h                        |  2 +-
 init/Kconfig                                       |  2 +-
 kernel/watch_queue.c                               |  2 +-
 lib/Kconfig.debug                                  |  2 +-
 tools/include/linux/objtool.h                      |  2 +-
 tools/objtool/check.c                              |  2 +-
 29 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.36.1


