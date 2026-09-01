Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1BEC79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:38:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADD6C60294;
	Tue,  8 Sep 2026 20:38:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADD6C60294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892695;
	bh=QL6FlMXWQ2cJapq2k70qYMuGvXY10kyAfCdQkUzMPDg=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Hv8YRBkXyiGF3Z2iXG7F2o3/wqSnuCbBcstr7Tz7vFBBbKTZkx6l483Dlox5qC+gt
	 wyVxKdrDWNyLIeFKkUnsOr/xbWQOy3gMwL+zX3eXU/oHmvLntD37O8xvD7QZOPFDYT
	 KTb7PIlKor0Co5/uk93eehWgkSLl2MmtpgkV10ZI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1614F80753; Tue,  8 Sep 2026 20:35:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59D9BF80750;
	Tue,  8 Sep 2026 20:35:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3065F804CC; Tue,  1 Sep 2026 22:37:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788295074;
	b=eoe/+3JuJOnWbyiQdE1fvBzjkz2zNxc2+bOUZ9ixkYwmaHATKcRi+7AOh+I5P+2aRTLt
	 inTrmgwd3jBrCQ38KQ47dE6XiH89+s9l/702eV9VTwVWpWu5j2pSY69VzceJe20nViIBE
	 gNI+/NYOJzfxdTk5PZgIuGj2fpQfVInC+n54rcm8r0l9a8L5vMQGNZrUdZXzUJu5+bK4Q
	 qa+wOIBspQjUOwKzH/NMNZX9ucc0P0RywhfarYre7ttTYu/IIFEn92PqbHcRWB1gsGjC4
	 /JZmJ5pyOMbe8ItiyDVS8B1dguGOHN+LP8pLmQ7qILyE49V+UhBsUbaEtrJbtYAJq4w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788295074;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:To:From:Subject;
	bh=QL6FlMXWQ2cJapq2k70qYMuGvXY10kyAfCdQkUzMPDg=;
	b=QrcDxX9AAmKJgZ3vDQEigoh3DV4DyIScN0CPbCc05k6M/hP0LnAJzm5zLb1CUpP8ptUi
	 oGKow0NzZ8h296ervL5j1880ma7ZliEVIr2lG0cywBRvZsQNXhanPbvWqXH/pyKkY6pCt
	 9J6DEFs+pfHaYdBQMXh2ib5VJdoNSluRk8iAvCJJOnUebdbDwZX6NJzAmzoGxFS4JpkUW
	 1nIGRAGf72I2MP6ZSRVdeYaNznknlG8hg8yWvdk9kd3L0stc96t7fXJok/afSI14Zp6aI
	 e8YO39Znu5aUaM1DQyAvXL3IOqzsICmzI6GCO7CN6B6aJ/TMi8dF1+pf2G6S0fM6rVg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="eQf/QvX1";
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4CD13F80071
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 22:37:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CD13F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eQf/QvX1
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZHjp5LwtzMlBT
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2026 22:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1788295070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PABOQpAsrfJz5RdcDnWmI5ZdOSz8Xx1nHsDD4HNxvSg=;
	b=eQf/QvX16oNG5xllD9enefIsFiCwCqOyUz1d7wvRcshGTzUADSBewEe8J9V3SWobdZBi1c
	L5jK/RIm+45uW5P881oGDVfEmS8ex69dbBkLSPcr0Ns7m+VGvaUNYwwFAmvJprJn7FJnTt
	j+WoXqM2yuCktcO8PHNPbzeK+1YTqWcZ8RImEPkFXsnRRHbSIpmHuxCMBle+e8yP0Kq2t4
	OciXQFNtO/z61xjF0CiM1/ljhTWcLGYgClSvr26O4bJTa6oAUdOSo9WZRn0WZFwHESiaii
	LnRWyI/SqGcgnEuIdV9C+til7M1/25mujjU3GJW0GV+b5wF7IT/DfYC9ddQbOQ==
Message-ID: <2ba97b47-c55c-4bda-b175-b7dc684bbc82@mailbox.org>
Date: Tue, 1 Sep 2026 21:37:49 +0100
MIME-Version: 1.0
Content-Language: en-US
To: alsa-devel@alsa-project.org
From: Digital Customer <customdigit@mailbox.org>
Subject: cs35l41-hda: speakers silent on kernel 7.0.0, working on 6.17 (Legion
 7 16ITHg6, SSID 17aa3855)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t1966pwuxiohu4xnix9nf7347zhcpzw8
X-MBO-RS-ID: 85c48302d0e4a18bb7b
X-MailFrom: customdigit@mailbox.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NFGPDNAUBNYQLHPPDP52WKFHMT47YJUT
X-Message-ID-Hash: NFGPDNAUBNYQLHPPDP52WKFHMT47YJUT
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NFGPDNAUBNYQLHPPDP52WKFHMT47YJUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Internal speakers are silent on kernel 7.0.0-28 and 7.0.0-30, and work
correctly on 6.17.0-35.

Hardware: Lenovo Legion 7 16ITHg6 (machine type 82K6), dual Cirrus
CS35L41 amps on shared reset, SSID 17aa3855, ACPI ID CLSA0101, Realtek
ALC287 codec.

Distro: Linux Mint 22.3 (Ubuntu 24.04 base), Ubuntu-packaged kernels.

On 7.0.0 the driver detects both amps (Revision B2, shared reset noted)
but then stops. No DSP firmware is loaded and neither amp is bound to
the codec - no "Firmware Loaded" or "CS35L41 Bound" lines appear, and
no error is logged. The firmware files are present in
/lib/firmware/cirrus/ (cs35l41-dsp1-spk-prot-17aa3855*), and the same
files load correctly on 6.17.0-35.

Not a suspend/resume issue: fails identically after a cold power-off.
Mixer state is clean (Master and Speaker unmuted at 100%, PCM 100%);
headphones work normally, which is consistent with the amps never being
enabled.

No intermediate kernel versions are available in the Ubuntu 24.04
repos, so the regression window is 6.17.0-35 to 7.0.0-28.


Working (6.17.0-35-generic):

cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Using extra _DSD properties, 
bypassing _DSD in ACPI
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40), 
Revision: B2
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Using extra _DSD properties, 
bypassing _DSD in ACPI
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Reset line busy, assuming 
shared reset
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855.wmfw: format 3 timestamp 0x6022b0f4
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855.wmfw: Tue 09 Feb 2021 16:57:39 W. 
Europe Standard Time
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 
0x2 v0.29.0, 2 algorithms
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855-spkid0-l0.bin: v0.29.0
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Cirrus\Project\Lenovo_PC_Y760\Smart PA Tuning\Release 
Version\Y760_Intel_Version4.5_LS647\Lenovo_
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Calibration applied: R0=5671
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Firmware Loaded - Type: 
spk-prot, Gain: 17
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: CS35L41 Bound - SSID: 
17aa3855, BST: 1, VSPK: 1, CH: L, FW EN: 1, SPKID: 0
snd_hda_codec_alc269 hdaudioC0D0: bound i2c-CLSA0101:00-cs35l41-hda.0 
(ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855.wmfw: format 3 timestamp 0x6022b0f4
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855.wmfw: Tue 09 Feb 2021 16:57:39 W. 
Europe Standard Time
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 
0x2 v0.29.0, 2 algorithms
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-17aa3855-spkid0-r0.bin: v0.29.0
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Cirrus\Project\Lenovo_PC_Y760\Smart PA Tuning\Release 
Version\Y760_Intel_Version4.0_LS647\Lenovo_
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Calibration applied: R0=5610
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Firmware Loaded - Type: 
spk-prot, Gain: 17
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: CS35L41 Bound - SSID: 
17aa3855, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: 0
snd_hda_codec_alc269 hdaudioC0D0: bound i2c-CLSA0101:00-cs35l41-hda.1 
(ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Cirrus Logic CS35L41 (35a40), 
Revision: B2


Broken (7.0.0-28-generic; 7.0.0-30-generic identical):

cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Using extra _DSD properties, 
bypassing _DSD in ACPI
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40), 
Revision: B2
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Using extra _DSD properties, 
bypassing _DSD in ACPI
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Reset line busy, assuming 
shared reset
cs35l41-hda i2c-CLSA0101:00-cs35l41-hda.1: Cirrus Logic CS35L41 (35a40), 
Revision: B2

Logs are from `journalctl -b -k | grep -i cs35l41`, timestamps and
hostname stripped. Happy to test patches or provide further output.
