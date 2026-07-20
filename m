Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B5FC4452B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:24:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D52FC601D2;
	Mon, 20 Jul 2026 17:24:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D52FC601D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784561077;
	bh=RyyzFvIsI8JcPIzG8DmCO8tAAAWSk61Vw5g1bEkTCQ0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=j5rC5gmoGjgxZ7BagbyBmfLwA6RV8ZhzlCRpZR7OGmGV4ZkD4dhX+M7u9retfMYSa
	 6N62MRXWFUQIPwKV9v0O0EE58GzkBx/UeHLbGX6ts1rY9HP6KkI+c86Gk81NXg4FP6
	 PEpV3kLwetjxPhy7t5ongMbsdpNrq3wsB6mRRCf0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFE6DF805F9; Mon, 20 Jul 2026 17:24:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34368F805F0;
	Mon, 20 Jul 2026 17:24:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10B6AF80496; Mon, 20 Jul 2026 17:23:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784561037;
	b=gDg7qN63lcSdYUffaXjhWmMr6mFr05djs7zAQVF2yIkjT4dPrZ8Il6uXegot6otq4N1h
	 aZTekeIgpVm2uGNnyrMSzn8guBclQLwSTtApD1h+60hFAf0u8wbZRExC9YHuafi8q+pjq
	 0p9F11rjUewz1656SraWrcJKbCt5/vuj7ojgWIPZIA801RmrwmEAVnNMC/oor9BRDd+37
	 j5zq6CTfOYB43NsvGB4nnnsskf8GrURTuH+fmxNNpwclFFjIZNzazhPqAhXNMi5t5hlzd
	 1LvlZp3+6elE7PDLSlvi+0UrsX8M6ss2LsS5DaKZSTVHFNr79lkV4KhW9Fe1Ll+JzgA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784561037;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=RyyzFvIsI8JcPIzG8DmCO8tAAAWSk61Vw5g1bEkTCQ0=;
	b=DVn45Aa/6C0UuTH1bdW5DeCA45GwI+q5gdSiz5UBdz2xOP+GVIU9mBknj6luiN9ac2ya
	 RnSqHwH7Tf9OKydfzVPV7teGPnYjLXG4jkDRyXekHE0x2fN2l61/9V6RCO2m6IJsXwlyJ
	 b11QX8rg8Zpdg0b9/R9RgoAcgWq+jl16VqyL23l9YFlTZlScqAyTLF6QJEu2iT6Wtpcj9
	 pSRZOxUMGXc2AD+To1bKqI63OT0+eEKKmrLOXDrBdLr0Ro5sLDM8hw6p84zQzlqjCFDmh
	 ma+CT7ydEFP9XaZs14i6nGJOou2ymSiAkrjFX9P3JJfC9DYwwBvXV4Dchbe00k59jzQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B5C95F80423
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 17:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5C95F80423
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c408ceb6112200-webhooks-bot@alsa-project.org>
In-Reply-To: <18c408ceb60b1700-webhooks-bot@alsa-project.org>
References: <18c408ceb60b1700-webhooks-bot@alsa-project.org>
Subject: Audient Evo8 split into mono inputs and stereo outputs
Date: Mon, 20 Jul 2026 17:23:59 +0200 (CEST)
Message-ID-Hash: 5S4CQNSBQMEP22MB7ECBOLRLQJK4RGYT
X-Message-ID-Hash: 5S4CQNSBQMEP22MB7ECBOLRLQJK4RGYT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5S4CQNSBQMEP22MB7ECBOLRLQJK4RGYT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #816 was edited from JMWalkman:

Hi!

So based on the work that @motolav and @perexg did on the evo 4, I managed to create a similar config file for the audient evo8 to expose separate mono inputs and stereo output pairs

It's just that I'm not sure how to submit it to this repo, but i'd like this to be a part of the default experience for more people who have the interface like me. I've been using it for a couple of weeks and it's been awesome, so here's the contents of the file

If in the meantime, anyone finds this issue wanting to implementent it.
I created a file called `99-Audient-EVO8-split.conf` located at `~/.config/pipewire/pipewire.conf.d`

```
context.modules = [
    # ------------------ INPUTS (Mics 1-4 + Loopback) ------------------
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Mic_1"
        node.description = "EVO 8 Mic/Inst 1"
        capture.props = { target.object = "alsa_input.usb-Audient_EVO8-00.pro-input-0" audio.position = [ AUX0 ] stream.dont-remix = true node.passive = true }
        playback.props = { media.class = "Audio/Source" audio.position = [ MONO ] }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Mic_2"
        node.description = "EVO 8 Mic 2"
        capture.props = { target.object = "alsa_input.usb-Audient_EVO8-00.pro-input-0" audio.position = [ AUX1 ] stream.dont-remix = true node.passive = true }
        playback.props = { media.class = "Audio/Source" audio.position = [ MONO ] }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Mic_3"
        node.description = "EVO 8 Mic 3"
        capture.props = { target.object = "alsa_input.usb-Audient_EVO8-00.pro-input-0" audio.position = [ AUX2 ] stream.dont-remix = true node.passive = true }
        playback.props = { media.class = "Audio/Source" audio.position = [ MONO ] }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Mic_4"
        node.description = "EVO 8 Mic 4"
        capture.props = { target.object = "alsa_input.usb-Audient_EVO8-00.pro-input-0" audio.position = [ AUX3 ] stream.dont-remix = true node.passive = true }
        playback.props = { media.class = "Audio/Source" audio.position = [ MONO ] }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Loopback_In"
        node.description = "EVO 8 Loopback Input"
        capture.props = { target.object = "alsa_input.usb-Audient_EVO8-00.pro-input-0" audio.position = [ AUX4 AUX5 ] stream.dont-remix = true node.passive = true }
        playback.props = { media.class = "Audio/Source" audio.position = [ FL FR ] }
      }
    }

    # ------------------ OUTPUTS (Outputs 1-4 + Loopback) ------------------
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Out_1-2"
        node.description = "EVO 8 Output 1-2"
        capture.props = { media.class = "Audio/Sink" audio.position = [ FL FR ] }
        playback.props = { target.object = "alsa_output.usb-Audient_EVO8-00.pro-output-0" audio.position = [ AUX0 AUX1 ] stream.dont-remix = true node.passive = true }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Out_3-4"
        node.description = "EVO 8 Output 3-4"
        capture.props = { media.class = "Audio/Sink" audio.position = [ FL FR ] }
        playback.props = { target.object = "alsa_output.usb-Audient_EVO8-00.pro-output-0" audio.position = [ AUX2 AUX3 ] stream.dont-remix = true node.passive = true }
      }
    }
    { name = libpipewire-module-loopback
      args = {
        node.name = "EVO8_Loopback_Out"
        node.description = "EVO 8 Stereo Loopback Output"
        capture.props = { media.class = "Audio/Sink" audio.position = [ FL FR ] }
        playback.props = { target.object = "alsa_output.usb-Audient_EVO8-00.pro-output-0" audio.position = [ AUX4 AUX5 ] stream.dont-remix = true node.passive = true }
      }
    }
]
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/816
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
