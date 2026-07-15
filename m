Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8431C4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:39:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6248E6020D;
	Sat, 18 Jul 2026 11:39:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6248E6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367575;
	bh=mAuGNpdeshVQcCVxMFCCmwIQu0nxqqcw5NpHlcSzjl8=;
	h=Date:From:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bS6q698XDCFwLfGaLecuqmAHFtuDCFAjzOrOGcqgFFIbWlqsRF6DXjUPbpdcnV0D9
	 nfZ74QdUPCMiVZt7cOxppvz5e22eCCr9BPivlvmlSxcO/S6DReWweBeHxJVDEEAjCC
	 hK1Hibl+oHHUDvW6ORnWzmW27cTopAiQqofJAkiQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30C76F805FE; Sat, 18 Jul 2026 11:37:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8CA4F80605;
	Sat, 18 Jul 2026 11:37:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D398F8057F; Wed, 15 Jul 2026 17:08:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784128096;
	b=XaP2gONMIO9HlUkZiTodagR3/yCZY5+LyWeEtuuUPQpLBXBwDB0v142zaFBenak4vAHd
	 WYDO/7JRmzqx4I//nQuDAlvYGUCW+lPhRty/1VcWlbBfGf6+g75VIZ5UMYokEp6MOK4wM
	 89nKoeWKTLXmPKXHveRg7xaoJkIatN/haJdBbDL8oH3JX1ChJV0YsfrV7mhVErHAxvY7J
	 5P7/FmcO1NHm4aMvgl7I5gFzayT2NZr9Wzct45qgGuwav7xgK0PC1lViqJr+Bw2CoonoB
	 ei4+IAKME355aV5EiAZ1xAg4d0MoiC91rNJi11RCjcdKJYtb0W5SUOK2H7Jl5+m1whw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784128096;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:From:Subject:To;
	bh=mAuGNpdeshVQcCVxMFCCmwIQu0nxqqcw5NpHlcSzjl8=;
	b=nYZ/+DZVKNxPobaN6JCLz92ASJaqLbzhbcV9x5KIx0ehDiudz8bLzC3OnBvYp450Dejj
	 7FxvYYX3A2yBkk+0KmCL6jriFzEz6eKbIShw2abEDpT6253Fz2atTortpnk8MBFYpxcHR
	 LxAbo3aYS2vveFRdLXZA9Y+EHaQKJnu6HyjB0k+Yjko8gbcyg0BCL+iX7lrASjh9g3lYp
	 2mLw0Rl5d5PViPtws4W0H9wN9xJbm4H9/4VPy3TH1svR+rPpxF4/oU7EuNyExmSZI7Fw3
	 QCgMRQqhI1Q60Yooch7dK3ja4xcHGaPBuV5w1JOec6uHZmqXoNVC2+jX68nYFicqRYA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eqZYbYRV;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7777BF800B5
	for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2026 17:08:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7777BF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eqZYbYRV
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso50168315e9.0
        for <alsa-devel@alsa-project.org>;
 Wed, 15 Jul 2026 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128093; x=1784732893;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ge3+kmve43T55UiM7iPMLluXDi5ajDGPwJQiwHJ/lbU=;
        b=eqZYbYRV5pWClD45ITcaf2gmRIxzMql+4pErmHq/rGkQMkpO40AV/yX0hy0jSkS64t
         vuEVNH9094YYYpJ8gvIWD0LEwmuHfd9IAWBTbJwTPU5bmqHowWUU1/YINbhZYkqFRC1N
         8T3EzxeUoQ70jbSNUUFXGvA2OLs7S+v4dTmYtJH4z5WHlvYQYX87839MW2wio9r/zqW6
         boJ2Ko0uSA5QdUKNmC0fmJxoASq98L5E9ji2dW9canbzpxWNf9pa8qVicMovtnMj5q8e
         CTAYh3d+1qBaWj8s/3Bjp/q17kcqlwdyrUAvalzFfMaiiTrTDwlIaUxdFD9c7vGykaYe
         PaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128093; x=1784732893;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ge3+kmve43T55UiM7iPMLluXDi5ajDGPwJQiwHJ/lbU=;
        b=WEGC51s4ZQcU0yN3Jc63U+cdMKdVoUCOxuX1aVae81fzNvf8M+l7vmOelkOf+0X4wC
         Uyje7ma9ePvGcyUOKhIpM71h6Nn1a2Vv2CekYK8zweLkaAo53K8CfiowMKmtODT5nfAU
         3D4OoLQcVQXJlS/0BSrVZzkBpl7d3hG3Sk5xQgxfLptckeqmvqQQRcpT2JJksqJ79hbi
         +0gzLVya5cGXTFuNpDnHo85tReXm8VYateXmGgIQk0ts8/HM0kuI9j6kFO2z7KNWWwZG
         r8AxHoxhjpDclyn9gYMYtn0j+DrJfdfRRmGk+XxbzvB1HAaNpKX6QbPDW4E3NMnfPm8P
         Z0aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEx3+PtyixGlUZZH287xQSdLjmgpsUy8dhdqXtBon+Ultw6ffWvSOeDIZE9ntmTqCl85ufPPXvtq01@alsa-project.org
X-Gm-Message-State: AOJu0YyHDL6LBmlsuBF0ulSOKq/4oRADYNHC+kkvJ76lTF1ymPc09auc
	mpYsz+2nixN+k8/BU5CWIHegVLKYsfzk38Fyt4cVwxMLFlC+7ctGF7Lq
X-Gm-Gg: AfdE7cmZ5+TOBKSpZoRuQ72ijYsqP7/ZsDaETNa0Dzh+wnANcLKC6zuHDgRPs7QXJFE
	n/QuW3Irlf1GeBbR7pbluPvV6HonGE3R0X+J3b7YSUuMQoS7Ec+fUsaM4r/i0irv6ls8pCjCBKM
	8nphsnbbiHpgwOLHp+fWen9DlBXj/oreuYNKcFjXwQ4ygt/FSfFkwZdk0HXe2emTMDzuHn180/S
	G4z+jU4qBjiyhXkosdX6PIRRmJsOUfxzwXMChDdz4ZEhM8YdNMUcIreLSfBIfOeVUJO+LD7Dh1g
	OIbgUwP5bVSbPBHu9o5UcKURx0WX79ItsSOHnviDO3wnfdGlv+sKwr1FVGYdoZbFu6YV+zTrp58
	oFT/nx2hjapbswlj9344f8pYSqo9OAuwNXEM5I3sQwT1uEdopXeN0sOBCOBw8NxUiayOulmf44j
	PNRJkrAm9st+XCSeb2PU2YD2Sl
X-Received: by 2002:a05:600c:b90:b0:493:c182:6b08 with SMTP id
 5b1f17b1804b1-49538a1e2famr77680395e9.36.1784128092666;
        Wed, 15 Jul 2026 08:08:12 -0700 (PDT)
Received: from [192.168.18.146] ([176.202.18.59])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322dc6sm163843135e9.10.2026.07.15.08.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 08:08:11 -0700 (PDT)
Message-ID: <35264720-a5b8-4b08-8bd4-442c0bd5a8a7@gmail.com>
Date: Wed, 15 Jul 2026 18:08:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Salman S. Tahir" <salman.abusaad@gmail.com>
Subject: =?UTF-8?Q?=5BREGRESSION_7=2E2-rc3=5D_ASoC=3A_cs35l56=3A_component_p?=
 =?UTF-8?Q?robe_waits_for_an_init=5Fcompletion_that_cannot_be_signalled_unti?=
 =?UTF-8?Q?l_the_wait_ends_=E2=80=94_whole_sof=5Fsdw_card_fails?=
To: patches@opensource.cirrus.com, rf@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: salman.abusaad@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IMOFOOZ6FL654LUWVFW3FCIN6PCSNW3B
X-Message-ID-Hash: IMOFOOZ6FL654LUWVFW3FCIN6PCSNW3B
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:37:08 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IMOFOOZ6FL654LUWVFW3FCIN6PCSNW3B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On a Lenovo Yoga 9 2-in-1 14ILL10 (83LC, Core Ultra 7 258V / Lunar Lake; 
CS42L43
plus two SPI-attached CS35L56 amps behind it) the machine has no sound 
card at all
on 7.2-rc3. /proc/asound/cards is empty and PipeWire falls back to a 
null sink.

The right-hand amp's ASoC component probe times out waiting for 
init_completion,
returns -ENODEV, and ASoC then tears down the entire card -- so 
speakers, internal
mics, headset and all three HDMI outputs die because of one failed 
component:

[ 10.301...] cs35l56 spi-cs35l56-right: _cs35l56_component_probe: 
init_completion timed out
[ 10.301...] cs35l56 spi-cs35l56-right: ASoC error (-19): at 
snd_soc_component_probe() on spi-cs35l56-right
[ 10.302...] sof_sdw sof_sdw: ASoC: failed to instantiate card -19

This is 100% reproducible. Scanning my whole journal (151 boots, back to
2026-03-07): 11 failures in 11 boots on 7.2.0-rc3, against 0 failures in 
138 boots
on every kernel I ran before it -- 6.17.0-14 (1 boot), 6.19.4 (83), 
7.0.0-15 (20),
7.0.0-22 (20), 7.0.0-27 (14). It breaks at the first 7.2-rc3 boot and 
has failed
every one since. (A 12th 7.2-rc3 boot is clean, but only because of the 
workaround
described below.) Those failures were all captured on an otherwise stock 
machine --
clean kernel cmdline, distro modprobe.d only, no out-of-tree modules 
(other than the
timeout experiment below), no DSDT override, distro Cirrus firmware. I 
now run a
local workaround (a snd_soc_sof_sdw blacklist plus a service that loads 
it late --
described below); I can drop it and reproduce the failure on demand.


This is not a slow-firmware race
--------------------------------

The obvious reading of that log is "the amp is a bit too slow and misses 
the 5s
deadline". It isn't, and I want to save you from chasing that. I rebuilt
snd-soc-cs35l56 for 7.2-rc3 with a single change -- the component-probe 
wait at
sound/soc/codecs/cs35l56.c:1371, msecs_to_jiffies(5000) -> 
msecs_to_jiffies(30000)
-- and booted it. It fails identically, just later:

component-probe timeout | wait expires at | right amp's cs35l56_init() 
actually starts
------------------------+-----------------+-------------------------------------------
5000 ms (stock) | 10.301 s | 10.355 s -- 54 ms after the wait gave up
30000 ms (patched) | 35.901 s | 36.005 s -- 104 ms after the wait gave up

During the entire 30-second wait the right amp emits nothing. It does 
not even reach
the cs35l56_hw_init() identification print that the left amp produced at 
5.29 s:

[ 5.294911] cs35l56 spi-cs35l56-left: Cirrus Logic CS35L56 Rev B0 OTP3 
fw:3.4.4 (patched=0)
[ 5.603038] cs35l56 spi-cs35l56-left: DSP1: 
cirrus/cs35l56-b0-dsp1-misc-17aa3832-spkid0.wmfw: format 3 ...
[ 7.681077] cs35l56 spi-cs35l56-left: DSP1: Firmware: 1a00d6 vendor: 0x2 
v3.11.26, 41 algorithms
[ 9.498049] cs35l56 spi-cs35l56-left: Calibration applied
<-- 26 seconds of silence from the right amp -->
[ 35.901035] cs35l56 spi-cs35l56-right: _cs35l56_component_probe: 
init_completion timed out
[ 35.902534] sof_sdw sof_sdw: ASoC: failed to instantiate card -19
[ 36.005138] cs35l56 spi-cs35l56-right: Cirrus Logic CS35L56 Rev B0 OTP3 
fw:3.4.4 (patched=0)

So the right amp's init is not losing a race against the deadline -- it 
is blocked by
the wait itself, and only proceeds once the waiter gives up. Increasing 
the timeout
just increases the wait; a 300-second timeout would fail at 305 seconds. 
The amp is
not slow: once released it completes cs35l56_init() normally. (It gets 
no firmware
download at that point -- the timeout path returns -ENODEV well before the
queue_work(&cs35l56->dsp_work) at the end of _cs35l56_component_probe(), 
so nothing
ever queues one for it.)


The hardware is fine -- the card is just built ~100 ms too early
----------------------------------------------------------------

After the failed instantiation, spi-cs35l56-right is bound to the 
driver, i.e. its
probe returned 0 and complete(&cs35l56->init_completion) did run. 
Nothing about the
hardware, the firmware download or the SPI-over-SoundWire path is 
broken; the card is
simply instantiated before the right amp is ready, and nothing ever 
retries it.

I confirmed that by keeping the deadlock from forming at all, rather 
than repairing it
afterwards: blacklist snd_soc_sof_sdw, wait until both amps have 
signalled init, then
load it. With no card probe in flight there is nothing to starve the 
right amp: both
amps reach their identification print within ~260 ms of each other 
(4.744 s and
5.008 s), the component probe's wait returns immediately, no timeout 
fires, and the
card registers first time. Both amps are still patched=0 at that point, 
so both take
the full firmware-download path, and both calibrate:

[ 19.770067] cs35l56 spi-cs35l56-left: Calibration applied
[ 19.777038] cs35l56 spi-cs35l56-right: Calibration applied

That boot has since suspended and resumed with the card intact, and 
contains no error
or warning from cs35l56, cs42l43 or SOF at all.


Hypothesis (unverified -- offered only as a starting point)
-----------------------------------------------------------

Something in 7.2 appears to have changed the ordering such that the 
right amp's probe
and the sof_sdw card probe end up on the same execution context (the 
deferred-probe
worker would fit the ~100 ms lag), so the blocking wait in 
_cs35l56_component_probe()
starves the very work it is waiting for. I have not confirmed that, and 
I have not
bisected -- I am reporting the reproducible behaviour rather than 
guessing at the
culprit commit, and I would rather not send you down a path I only inferred.


Suggested direction
-------------------

Regardless of what changed the ordering, blocking in a component probe 
on a completion
that a different probe must signal looks fragile by construction. Returning
-EPROBE_DEFER instead -- letting the driver core retry the card once the 
amp is bound
-- would use the mechanism the kernel already has for this, and 
snd_soc_bind_card()
already special-cases -EPROBE_DEFER from soc_probe_link_components(). 
Something along
the lines of:

if (!wait_for_completion_timeout(&cs35l56->init_completion,
msecs_to_jiffies(5000)))
return 
dev_err_probe(cs35l56->https://www.google.com/url?q=http://base.dev&source=gmail&ust=1784212475584000&sa=E, 
-EPROBE_DEFER,
"init_completion not signalled, deferring\n");

I have not tested that; I did not want to submit a patch built on a 
mechanism I have
only hypothesised.

I have the hardware, I can reproduce this on every boot, and I am happy 
to test
patches, run instrumented builds, or bisect if that would help. Just 
tell me what
would be most useful.


Environment
-----------

- Lenovo Yoga 9 2-in-1 14ILL10 (83LC), Core Ultra 7 258V (Lunar Lake)
- CS42L43 (SoundWire) + 2x CS35L56 Rev B0, SPI-attached via the CS42L43
- Firmware: cirrus/cs35l56-b0-dsp1-misc-17aa3832-spkid0.wmfw v3.11.26 
(distro linux-firmware)
- Bad: 7.2-rc3 (7.2.0-070200rc3-generic, mainline build) -- 11 failures 
/ 11 boots
- Good: 7.0.0-27 (14 boots), 7.0.0-22 (20), 7.0.0-15 (20), 6.19.4 (83), 
6.17.0-14 (1)
-- 138 boots, 0 failures
- Only the 30 s-timeout boot above ran a rebuilt (out-of-tree, 
kernel-tainting)
snd-soc-cs35l56; every stock-timeout failure was on the untainted distro 
module
- Not bisected
- Workaround currently in place: blacklist snd_soc_sof_sdw + a systemd 
unit that
modprobes it once both amps have signalled init. Removable on request -- 
I can
reproduce the failure on any boot.

Thanks,
Salman S. Tahir
