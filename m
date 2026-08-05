Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B0C55ABA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:06:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C9A860217;
	Wed,  5 Aug 2026 20:06:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C9A860217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785953200;
	bh=mKSHRhhntqcvLMCR0a5XV+Lo5eD+IOt3VYzlucbb69o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tihwgZuQrIp6on9XbR2srzfyOb4bGNaTE6JzkVWKXiLLgybmjtLeA3NpEgRcCLQ/Z
	 kQXliJohh4AnaL2VOsD389MBCtBCvpGtFlp3Cr4fsjJ2QRSuWecLEnypFVo+I7L7bm
	 Oc7b9q5fHzpFI1BD4m7sfXpOOdIZTfRdtTYpVXFU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5744F805EF; Wed,  5 Aug 2026 20:06:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86992F80600;
	Wed,  5 Aug 2026 20:06:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EDAEF8027B; Wed,  5 Aug 2026 20:06:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785953158;
	b=go5jXG8wD9T9vy4QLUfkJjqR+Kmoe6BiJqwCkbHLhLkkU23jP8k5EO5zaiTm8TONXv6Z
	 4+nLUsw+Z9Ip/eMPuThtnyJy4WwjiiWJ9cZMPiU+h4SATGGyOOf64uGdfJLKfHTSzipjH
	 5/x1+2HwZ9oUoVllzZlFQL9PUgJgxW2gLNHb954wfChDodmP72zswU1U2LgPjJsqBbKev
	 ZrPZXZTX/WH4F86ZA/ExZIGnXJILHIQlfMeifxDwzcWKZGPcx0rirMnmAX1UNgcjvPIrx
	 X61T5Lm3xZme9+thPhrK6Z9+iOOefarxS0LAIVTH0vT9dEcU7VlM8D0+sseRRZS4Fyw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785953158;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=mKSHRhhntqcvLMCR0a5XV+Lo5eD+IOt3VYzlucbb69o=;
	b=NzJIy2N+Z3Z48p5iKE/KO0+/7e/Z5GOL97S4qb/1a7pHQ+MP5X2Mx68yjJHFlMTOs7kb
	 2lAOx+FvkggLqVzEhd37Je0mWw9wVUEpZ6ixk10kJmOAQkd493QIpjV77XotGZtvDQajH
	 tKFHCrCC8g8UUlW18hELT0NMtlisY81nXFe+rORMF274dMpB86hkMIHmG3ZUeJ988TS+k
	 ujWEHpeUjx5IvefrcZCElOekqFnv0sjMNVUNP8/3XweHYCxrcfQAhduakn65Li1i3BRj1
	 CaAXHwFPBvSvQcGvP/xuQwKycvI+l0scF0JGaESGTOpQnEYkrwHbRw6Zou+PmwDehSQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 64034F80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 20:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64034F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c8faef01270f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18c8faef00f90100-webhooks-bot@alsa-project.org>
References: <18c8faef00f90100-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: the `Headphone Switch` cset in rt721.conf breaks the
 whole HiFi verb on amd-soundwire cards
Date: Wed,  5 Aug 2026 20:06:00 +0200 (CEST)
Message-ID-Hash: 65ZHDAR53IB3TN7DKW3SZY5SGOP2AI47
X-Message-ID-Hash: 65ZHDAR53IB3TN7DKW3SZY5SGOP2AI47
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/65ZHDAR53IB3TN7DKW3SZY5SGOP2AI47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #825 was opened from Robin-Everaars:

### Summary

On AMD SoundWire cards, `snd_use_case_set(uc_mgr, "_verb", "HiFi")` fails with
-ENOENT because `ucm2/sof-soundwire/rt721.conf` csets a control named
`Headphone Switch` that the card does not expose. `ucm2/sof-soundwire/HiFi.conf`
uses `disdevall ""` as its verb EnableSequence, so every device DisableSequence
runs during verb activation. The Headphones DisableSequence therefore takes the
verb down before any device is selected, and the card ends up with no usable
verb at all.

`conf.d/amd-soundwire/amd-soundwire.conf` is a symlink to
`../../sof-soundwire/sof-soundwire.conf`, so an AMD card inherits the Intel SOF
device definitions verbatim, including that cset.

Downstream, PipeWire's ACP layer calls the same function, gets the same -ENOENT
and silently falls back to its built-in profile set. That fallback binds the
sink to PCM 0 (the RT721 headset path) instead of the speakers, so audio comes
out of the headphone jack and the speaker amps are never addressed.

### Hardware

* ASUS ProArt PX13 HN7306EAC (AMD Strix Halo)
* Card 1 `amdsoundwire`, driver `amd-soundwire`, longname
  `ASUSTeKCOMPUTERINC.-ProArtPX13HN7306EAC-1.0-HN7306EAC`
* Components string: `cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721 spk:tas2783`
* Realtek RT721 SDCA on SoundWire, two TI TAS2783 SmartAmps on SDW1, AMD ACP PDM
  DMIC array
* Kernel 7.1.5, alsa-lib and alsa-ucm-conf 1.2.16.1, alsa-utils 1.2.16,
  PipeWire 1.6.8, WirePlumber 0.5.15, NixOS
* `ALSA_CONFIG_UCM2` points at a copy of stock alsa-ucm-conf 1.2.16.1 plus one
  added file, `sof-soundwire/tas2783.conf`. Without it the mandatory
  `Include.a.File "/sof-soundwire/${var:SpeakerCodecFile}.conf"` in
  `sof-soundwire.conf` aborts `snd_use_case_mgr_open` with -2. That part is what
  PR #812 addresses.

### Reproducer

```
$ alsaucm -c hw:1 list _verbs
  0: HiFi
    Play HiFi quality Music

$ alsaucm -c hw:1 set _verb HiFi
ALSA lib main.c:843:(execute_sequence) [error.ucm] unable to execute cset 'name='Headphone Switch' off'
ALSA lib main.c:2866:(set_verb_user) [error.ucm] failed to initialize new use case: HiFi
alsaucm: error failed to set _verb=HiFi: No such file or directory
```

Enumeration works, activation does not. The card has 19 controls and none of
them is `Headphone Switch`:

```
$ amixer -c 1 controls
numid=19,iface=MIXER,name='rt721 ADC 07 L Mux'
numid=18,iface=MIXER,name='rt721 ADC 07 R Mux'
numid=15,iface=MIXER,name='rt721 ADC 08 L Mux'
numid=14,iface=MIXER,name='rt721 ADC 08 R Mux'
numid=13,iface=MIXER,name='rt721 ADC 09 Mux'
numid=17,iface=MIXER,name='rt721 ADC 10 L Mux'
numid=16,iface=MIXER,name='rt721 ADC 10 R Mux'
numid=1,iface=MIXER,name='rt721 FU05 Playback Volume'
numid=5,iface=MIXER,name='rt721 FU06 Playback Volume'
numid=2,iface=MIXER,name='rt721 FU0F Capture Switch'
numid=3,iface=MIXER,name='rt721 FU0F Capture Volume'
numid=8,iface=MIXER,name='rt721 FU15 Boost Volume'
numid=6,iface=MIXER,name='rt721 FU1E Capture Switch'
numid=7,iface=MIXER,name='rt721 FU1E Capture Volume'
numid=4,iface=MIXER,name='rt721 FU33 Boost Volume'
numid=9,iface=MIXER,name='tas2783-1 Amp Volume'
numid=10,iface=MIXER,name='tas2783-1 Speaker Volume'
numid=11,iface=MIXER,name='tas2783-2 Amp Volume'
numid=12,iface=MIXER,name='tas2783-2 Speaker Volume'
```

The offending lines are `ucm2/sof-soundwire/rt721.conf` 58 to 70 (v1.2.16.1),
the two csets being lines 62 and 66:

```
SectionDevice."Headphones" {
	Comment	"Headphones"

	EnableSequence [
		cset "name='Headphone Switch' on"
	]

	DisableSequence [
		cset "name='Headphone Switch' off"
	]

	Value {
	      PlaybackPriority 200
	      PlaybackPCM "hw:${CardId}"
	      JackControl "Headphone Jack"
	}
}
```

and the verb sequence that pulls the DisableSequence in,
`ucm2/sof-soundwire/HiFi.conf` 3 to 6:

```
SectionVerb {
	EnableSequence [
		disdevall ""
	]
```

### Proof that this single cset is the whole problem

Copy the tree, guard those two sequences with a `ControlExists` condition and
change nothing else:

```diff
--- a/ucm2/sof-soundwire/rt721.conf
+++ b/ucm2/sof-soundwire/rt721.conf
@@ -58,12 +58,18 @@
 SectionDevice."Headphones" {
 	Comment	"Headphones"
 
-	EnableSequence [
-		cset "name='Headphone Switch' on"
-	]
-
-	DisableSequence [
-		cset "name='Headphone Switch' off"
-	]
+	If.headphone_switch {
+		Condition {
+			Type ControlExists
+			Control "name='Headphone Switch'"
+		}
+		True.EnableSequence [
+			cset "name='Headphone Switch' on"
+		]
+		True.DisableSequence [
+			cset "name='Headphone Switch' off"
+		]
+	}
 
 	Value {
 	      PlaybackPriority 200
```

```
$ ALSA_CONFIG_UCM2=/tmp/ucm2-test alsaucm -c hw:1 set _verb HiFi
$ echo $?
0
```

Deleting the two cset lines outright works too, and returns 0 the same way.
Prefixing the control name with `-` does not work: `cset "-name='Headphone
Switch' off"` still fails, now with -EINVAL, so the ignore-error prefix
documented for `exec` does not apply to `cset`.

### Downstream effect on PipeWire

PipeWire's ACP layer calls the same function, so it inherits the failure and
drops to its built-in profile set. With stock rt721.conf:

```
$ spa-acp-tool -vvv -c 1 list-profiles
I       alsa-ucm.c:1019      UCM available for card hw:1
I       alsa-ucm.c:1128      Set UCM verb to HiFi
I           main.c:843       unable to execute cset 'name='Headphone Switch' off'
I           main.c:2866      failed to initialize new use case: HiFi
E       alsa-ucm.c:1044  Failed to get the verb HiFi
E       alsa-ucm.c:1052  No UCM verb is valid for hw:1
I     alsa-mixer.c:4932      Loading profile set: .../profile-sets/default.conf
    profile 0: name:"off" prio:0 (available: yes)
    profile 1: name:"output:stereo-fallback" prio:5100 (available: unknown)
  * profile 2: name:"pro-audio" prio:1 (available: yes)
```

With the guard in place:

```
$ ALSA_CONFIG_UCM2=/tmp/ucm2-test spa-acp-tool -vvv -c 1 list-profiles
I       alsa-ucm.c:1019      UCM available for card hw:1
D       alsa-ucm.c:467         Got PlaybackPCM for device Speaker: _ucm0001.hw:amdsoundwire,2
D       alsa-ucm.c:467         Got PlaybackPCM for device Headphones: _ucm0001.hw:amdsoundwire
I            acp.c:2010      Found UCM profiles
    profile 0: name:"off" prio:0 (available: yes)
    profile 1: name:"HiFi" prio:8600 (available: unknown)
  * profile 2: name:"pro-audio" prio:1 (available: yes)
```

`output:stereo-fallback` binds to PCM 0, the RT721 headset path, which is why
audio came out of the headphone jack and the speakers were never addressed.

### Suggested fix

Any of these would work and I am happy to send a PR for whichever you prefer:

1. Guard the Headphones sequences with `Condition { Type ControlExists Control
   "name='Headphone Switch'" }`, the pattern `sof-soundwire.conf` already uses
   for its PGA BootSequences at lines 198 to 226. This is the variant in the
   diff above, and it is the one I tested on hardware.
2. Use an RT721 SDCA function-unit control the card actually exposes, for
   example a mute on the same FU as `rt721 FU05 Playback Volume`, instead of the
   DAPM pin switch.
3. Give amd-soundwire its own `conf.d` entry and headset conf that omits the pin
   switch, rather than symlinking straight at `sof-soundwire.conf`.

### A second, related gap

Once the verb activates, the HiFi profile is correct: Speaker on
`hw:amdsoundwire,2`, Headphones on `hw:amdsoundwire`, Mic on
`hw:amdsoundwire,4` and Headset on `hw:amdsoundwire,1`. Jack detection still
does not work, because this card registers no jack kcontrol either:

```
I       alsa-ucm.c:2556      UCM jack Headphone has_control=0
I       alsa-ucm.c:2556      UCM jack Headset Mic has_control=0
D            acp.c:1909        Pruned singleton availability group Headphone from port [Out] Headphones
D            acp.c:969         Found 0 jacks.
```

So `JackControl "Headphone Jack"` and `JackControl "Headset Mic Jack"` name
controls that do not exist on amd-soundwire either. Treat that as background for
this bug rather than a second request. If the right answer is that the AMD
machine driver ought to register the `Headphone Switch` and `Headphone Jack`
controls the way the Intel `sof_sdw` boards do, please say so and I will take the
whole thing to the ASoC list instead. I have not read the AMD machine driver, so I
cannot say which side is wrong.

### Related

* #805 same laptop, RT721 capture switches default to OFF, still open
* #806 the PR for #805
* #812 adds the tas2783 profile this card needs, does not touch rt721.conf
* #227 the same "Failed to get the verb" symptom on ALC4080
* #356 the policy discussion about failing early on a missing control

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/825
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
