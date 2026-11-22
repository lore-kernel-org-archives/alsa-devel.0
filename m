Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAF606A320
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Nov 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=hD60JREQ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8454E601F6;
	Sun, 22 Nov 2026 01:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8454E601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795305892;
	bh=GG2zDe3hIg+E4AA8hmiEJRCZdelX3r1zY7iw9aJNaY4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hD60JREQcr2n6Cq2kqLRSw+fVL9YQhypbGMJ64A5xy9Kia90ylhzAXh1UwvAQnMtd
	 3nwXmJU+sN6+ju57doCD9eBsJnerwYucr7/2c5ZNLk5v5mj9/e+pocfSRWG6NFSWEP
	 lccCrLAv40Ikl4r/Pv2kmIXNxb2bpEkEUE2S4h9M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C23F9F804B4; Sun, 22 Nov 2026 01:04:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A1D6F80600;
	Sun, 22 Nov 2026 01:04:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC203F804B4; Sun, 22 Nov 2026 01:04:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795305849;
	b=I0CsSGtkItNZiIvnUqhyLBQNLNN1sv/nj8irtGA4X83+jIJJEzAtBJ5v3Kb0bEsgQxNC
	 jh1mLMpaGjnwOKEmEMvIl7JhC6QzfZDXqWsdfWx4PaUAnHdGLwLgHAFbyCJmtl/hbJq0J
	 LLgmnrrwrtfS7Sz2lnD+45Oo2wLVZIKwhNJt4ZOiANSgaCLqncp01it+oKyQbf0l5Pk7g
	 a6obKR+mTPgLpzUnbBL2Cfp1mSxV0Hojsr2ob4voNuxNFTYUfUjBtVBsk8lnZhRwaMoja
	 yUPfaBrv/9IEMwm5enQH38YO1OKTi+TkF4074tOfWc2fuco+07ceitXTUbp1N4Gtt8A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795305849;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=GG2zDe3hIg+E4AA8hmiEJRCZdelX3r1zY7iw9aJNaY4=;
	b=dX/4lJpKlw18vLUwVFbtJuhROqPvgMXa49KhSI/HTu5Ze1iDEkFmti3hSiMGH+rKeA/b
	 1fvnZg92wxKAbKUGgTEpg9SUaHVKSBfCEfETdBF+dvM1V6wkuwonjsegQQge7Kl5pqqjm
	 Zx9yvEfQwef8ERe5FolbMHVjF+wKTFSeI8QobDKkUlB0uCILwjsEElA6re2Vj8vNgaRkw
	 UF+74F9UY64MT9N5GYojQSJK6JdbGRzDILlIYjQCJwDvn2zTG9jbSL8S6PCmrydBSZm6B
	 SHz5MuSp0fOhEX89alVdssk427DMwaOjkiWHusdxPZvPmNDsNGhDoeV8WEhVlHz94DA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DB946F80217
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2026 01:04:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB946F80217
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ea35283c335500-webhooks-bot@alsa-project.org>
In-Reply-To: <18ea35283c10c700-webhooks-bot@alsa-project.org>
References: <18ea35283c10c700-webhooks-bot@alsa-project.org>
Subject: Lenovo Yoga 7i no speaker audio / microphone
Date: Sun, 22 Nov 2026 01:04:10 +0100 (CET)
Message-ID-Hash: SHNUDTX5ANDRYLME5CHBVNBTD32UC4CI
X-Message-ID-Hash: SHNUDTX5ANDRYLME5CHBVNBTD32UC4CI
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SHNUDTX5ANDRYLME5CHBVNBTD32UC4CI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf issue #920 was opened from byrdie82:

**Summary**
On a Lenovo Yoga 7i 2-in-1 14" (Panther Lake, rt721 headset codec + rt1320 speaker amp over SoundWire), UCM fails to load because `ucm2/codecs/rt721+rt1320/init.conf` does not exist. PipeWire falls back to a generic `stereo-fallback` sink, so the built-in speakers produce no sound, the internal mic doesn't appear, and the mute LED stays on. Headphones work.

The `sof-soundwire/rt721+rt1320.conf` profile exists (added by the "sof-soundwire: add companion amp config with rt721 and rt1320" change), but the matching `codecs/rt721+rt1320/` directory is not in the repo. This is true for v1.2.16.1 and current master. Only `codecs/rt721/` and `codecs/rt1320/` exist.

**Hardware**
- Machine: Lenovo Yoga 7i 2-in-1 14" (`LENOVO-83TC-Yoga72_in_114IPH11-LNVNB161216`)
- CPU: Intel Core Ultra 7 355 (Panther Lake)
- Driver: `sof-audio-pci-intel-ptl`, SoundWire link 3 (rt721 part 0x0721, rt1320 part 0x1320)
- Distro: Ubuntu 26.10 (Kubuntu), alsa-ucm-conf 1.2.16.1-1ubuntu1
- Kernel: [output of `uname -r`]

**Card components**
```
cfg-amp:2 mic:dmic cfg-mics:4 iec61937-pcm:7,6,5 hs:rt721 spk:rt721+rt1320
```

**Error**
```
alsa-lib utils.c:373:(uc_mgr_config_load_into) could not open configuration file /usr/share/alsa/ucm2/codecs/rt721+rt1320/init.conf
alsa-lib parser.c:80:(uc_mgr_config_load_file) failed to open file /usr/share/alsa/ucm2/codecs/rt721+rt1320/init.conf: -2
alsa-lib main.c:1805:(snd_use_case_mgr_open) failed to import hw:0 use case configuration -2
```
Resulting PipeWire sink: `alsa_output.pci-0000_00_1f.3-platform-sof_sdw.stereo-fallback`

**Steps to reproduce**
1. Install a distro with alsa-ucm-conf 1.2.16.x on this hardware.
2. Run `sudo alsactl init` (or check `journalctl -b | grep -iE "ucm|alsa-lib"`).
3. Observe the errors above.

**Workaround**
Add `ucm2/codecs/rt721+rt1320/init.conf` that includes the two existing single-codec init files:

```diff
diff --git a/ucm2/codecs/rt721+rt1320/init.conf b/ucm2/codecs/rt721+rt1320/init.conf
new file mode 100644
--- /dev/null
+++ b/ucm2/codecs/rt721+rt1320/init.conf
@@ -0,0 +1,3 @@
+# Combined init: rt721 headset codec + rt1320 companion speaker amp
+Include.rt721.File "/codecs/rt721/init.conf"
+Include.rt1320.File "/codecs/rt1320/init.conf"
```

**Result with the workaround**
After creating this file at `/usr/share/alsa/ucm2/codecs/rt721+rt1320/init.conf` and running `sudo alsactl init`:
- The `alsa-lib` errors are gone
- Built-in speakers work in stereo
- The mute LED now follows the mute state
- Internal mic: working

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/920
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
