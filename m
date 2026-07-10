Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D355DC43458
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:46:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47E86601D9;
	Fri, 10 Jul 2026 12:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47E86601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783680362;
	bh=5rV2rI21VhZ4AqPpQN0h0i4VVnZtMGqIJQttR0mGQKM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YFKTQuk+Fwjwgh5TWFD+unMBh+fO8d3RfoomrQyZogzfHkVmCbX2NmD307CUJRN8y
	 a7bKaiiLGctm2B9kqFsuhBT8Exk9Nd1o+bdC82OaUjqywXZcRY5EGgrA/SLh11zMTK
	 r9LMkEDylRaHd1zPBKxfTKszgdaxQa4yo/He/7l8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3309F80600; Fri, 10 Jul 2026 12:45:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CD95F8058C;
	Fri, 10 Jul 2026 12:45:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95DC0F8057E; Fri, 10 Jul 2026 12:45:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783680320;
	b=HeI2d5J2C7eDmCbq53vtpmwTh8jo8lpViwPBU7rA0Xn0hL3+h5+aZLdl2QHBG4+95P9U
	 mlv36vVlqrc1Bvt2LzYKDO2YLaX6TFhvroa/HBGdLfbuMondSQW8KvrbYhYZlc8s8uBQF
	 jHRJddFHDgS5ZsCZGg0NVNN3j9xc8mOkmG4zu0ObyfSyDCQ7vL3gQ+TCO73RkxjWEpCYk
	 IP9sMCA+HsvkjcT36L+YiQr+kVgAMKM9g2ZE0kpmyTUnWpmSBydeww7UhuqkImITd8fpR
	 cF0skVMzNRM7+/a8CpaeBSNabEgw6DKFbQ/fdNNc9QYCIZxzdLESwIwNlTe8dx50Y3Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783680320;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=5rV2rI21VhZ4AqPpQN0h0i4VVnZtMGqIJQttR0mGQKM=;
	b=ORvZ3TsiM5t1JMCae3bPos5Jsei+hymYdzxHGvljmeaHb5zga4dIpl+RrUJOz+JNqEoh
	 DDSmhD0wvu5ICvMApqLjg4ycqpPVD/Brkedqg4NujdDO0vHcQ4A8zCwPTD0CUNO2DLTTb
	 +SoViekT25lrzRfPWRrO37Pqs9q/G58Sx65sXHxb/nYuyYz76aGtXYA4KKNuUtv6qH+hh
	 hk3Ar3duZzQOGayK2531RukifZdpNWmaZFn78UW36mp7CYattCbpJbr+AB1csnQw0AnjV
	 f0ZJMcekKu3xdM7vdgA2ClcaUCBxv56nONE3iONDj5RXrSwNoaFhVrxJiC3ClAcCaQA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ND4ie0Oc;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 99DB1F80423
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2026 12:45:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99DB1F80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ND4ie0Oc
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id EBB2C402B9;
	Fri, 10 Jul 2026 10:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 58F991F000E9;
	Fri, 10 Jul 2026 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680315;
	bh=8QFS/UzOEfR7QT5s1IpcmXGVFQcaySqXOUnd6kbIuso=;
	h=From:To:Cc:Subject:Date;
	b=ND4ie0OcEYgYHAo6DaeDoEV/Z6xhdEZyW2/2ol+k0nAh3Q4BQbMrUZaUBpQbTnrUh
	 ZPjHkGIf9ciR4afz4x1561MXG3zsO/hP791/ULnwhJ5tWHwZwApJrmpfh6TfHmrtHf
	 ZFuheKTa1ItBH79nrkjVIZ2ludnYYNgnE8XWCdSwRMiQh9FDKWGkaOpJI/imIA3aLq
	 5vma2I8cwnK3sKddQ5dYhBydVgmEpsGNWh1QXABLnRaVPwggFra9vmalzAzIg1G48S
	 hD4Ep8arO+Ua0WZh0z6m+LigaBjjpHR55vKTAVly2MRXDbpKBruyaJH0IZHm7S6S8G
	 3dfrLBKFj+11Q==
Message-ID: <19b1f3ea7e0f08ad827d02c50075f69d@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc2
Date: Fri, 10 Jul 2026 11:45:07 +0100
Message-ID-Hash: LSRC4PFC7VWJTQBYCMTKGEWB26IE5LAF
X-Message-ID-Hash: LSRC4PFC7VWJTQBYCMTKGEWB26IE5LAF
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSRC4PFC7VWJTQBYCMTKGEWB26IE5LAF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc2

for you to fetch changes up to 3238c634725afbb2a137fdda762208510828f71d:

  ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup (2026-07-09 00:33:20 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

A fairly standard set of device specific fixes and quriks for new
devices, nothing too remarkable here.

----------------------------------------------------------------
Baojun Xu (1):
      ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783 support

Charles Keepax (1):
      ASoC: cs42l43: Correct report for forced microphone jack

Christian Hewitt (1):
      ASoC: meson: aiu: fifo-spdif: soft reset the S/PDIF datapath on start/stop

Maciej Strozek (1):
      ASoC: sof_sdw: Add a quirk for 0x17aa383c laptop using sidecar amps with cs42l43

Mark Brown (2):
      Vijendar Mukunda <Vijendar.Mukunda@amd.com> says:
      ASoC: qcom: Add Eliza audio support

Ravi Hothi (3):
      ASoC: dt-bindings: qcom: Add Eliza LPASS macro codecs
      ASoC: dt-bindings: qcom,sm8250: Add Eliza sound card
      ASoC: qcom: sc8280xp: Add support for Eliza

Syed Saba Kareem (1):
      ASoC: amd: acp: Fix linker error with SDCA quirks

Tianze Shao (1):
      ASoC: rt712-sdca: reset codec at io_init to fix silent headphone

Uday Khare (1):
      ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup

Vijendar Mukunda (3):
      ASoC: amd: ps: disable MSI on resume in ACP PCI driver
      ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()
      ASoC: amd: ps: replace bitwise OR with logical OR in IRQ return check

 .../bindings/sound/qcom,lpass-rx-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-va-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |  1 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 sound/soc/amd/acp/Kconfig                          | 10 +++--
 sound/soc/amd/acp/Makefile                         |  3 +-
 sound/soc/amd/acp/amd-acp70-acpi-match.c           | 47 +++++++++++++++++++++-
 sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c       |  4 --
 sound/soc/amd/ps/pci-ps.c                          | 33 ++++++++++++++-
 sound/soc/codecs/cs42l43-jack.c                    |  3 +-
 sound/soc/codecs/rt712-sdca.c                      | 11 +++++
 sound/soc/codecs/tas2562.c                         |  5 ++-
 sound/soc/intel/boards/sof_sdw.c                   |  1 +
 sound/soc/meson/aiu-fifo-spdif.c                   |  5 +++
 sound/soc/qcom/sc8280xp.c                          |  1 +
 16 files changed, 113 insertions(+), 15 deletions(-)
