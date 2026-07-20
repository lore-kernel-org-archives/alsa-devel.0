Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5726C44515
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:22:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1D3601FA;
	Mon, 20 Jul 2026 17:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1D3601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784560927;
	bh=75GHVG19DKwh6og1+EDC3NkbTNE35dA8ivt3u8l8Oy8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BF8gsRZ9ANhPHP+TXXILp2/tMVc3KBiO5Utqjn/lMnHOH7v7aMhZjiW5sY+Pk96D+
	 HvXOgAwom4dkfJfr6Cjww7QI079SfZDg2951VRAKSDZS+Mlbi5JZp9pD6IlJltSz6E
	 e4DW1Nrdn5dm/TOjl7Ed0nwewV6QyaqRmF44fT2o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD89BF8010B; Mon, 20 Jul 2026 17:21:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50287F80600;
	Mon, 20 Jul 2026 17:21:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69122F80496; Mon, 20 Jul 2026 17:21:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784560888;
	b=eaO22hYhpD3gUBEEUKpHil0tjzQJ9Ny+WpOLO2l2rLxHPy+bAFnpadpEC/39o70aENwc
	 9tKKlLyMWpb16xpUhTRJRlzeoclIjjvBivPa6IuxWFdd+DVsQXFzd2+aghi6ky+wzxMlp
	 cOK1A1tttNlOeZCw29aV8OBQFhd799VNCAdgCPiahIIAqErmilywNHSh0Qb371NsbgvlZ
	 J+OemNpz6IgqwIpqY1qMNHEx9GNx1c3EtPrkN02VpUyAbi3Zmp4YarxW/2mDiUjNn/Jye
	 sHhMgyp2qkvtaXo/X03ILxBOgA0wVq/x2j83YcFVIPosoFWJjitRLqJtpBHRMFWG8Pw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784560888;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=75GHVG19DKwh6og1+EDC3NkbTNE35dA8ivt3u8l8Oy8=;
	b=DK0kqyACaos+yy6OFa8E4h9HUERtJ2fA7omIAo+1+A/uQ+FJJ22Ll+dQXLm1WDxVaU3M
	 CR82iPuSbScdKrJTAkjZcEpnwkGBM77mUwoU6UfE/awGEaAVtFwgVcaf9k9TzJbgg7WU4
	 b/zAZnfvS758QtddyChxVFfvAew8ATkDXgB4HerNxqnph8e9xyQPqKsJms3KBO6I663v6
	 7vqFLRbCy8254RRF6JQPwqkvUw9X4/zAvDnAs9aUNyt+tNpwoiXIpHaag9PQqrzswNtSp
	 ykIeCgQwCt+0anl58wh5uBpiyyn463+YjPHY/yYS+KmqHX+MPZiemDlqFJ6HqHMD4oA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 57386F8010B
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 17:21:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57386F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c408abe413fc00-webhooks-bot@alsa-project.org>
In-Reply-To: <18c408abe3e97100-webhooks-bot@alsa-project.org>
References: <18c408abe3e97100-webhooks-bot@alsa-project.org>
Subject: Audient Evo8 split into mono inputs and stereo outputs
Date: Mon, 20 Jul 2026 17:21:29 +0200 (CEST)
Message-ID-Hash: 4NXDRLJUWCV77ZML7RZPIWYKHDLCFAM2
X-Message-ID-Hash: 4NXDRLJUWCV77ZML7RZPIWYKHDLCFAM2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4NXDRLJUWCV77ZML7RZPIWYKHDLCFAM2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #816 was opened from JMWalkman:

Hi!

So based on the work that @motolav and @perexg did on the evo 4, I managed to create a similar config file for the audient evo8 to expose separate mono inputs and stereo output pairs

It's just that I'm not sure how to submit it to this repo, but i'd like this to be a part of the default experience for more people who have the interface like me. I've been using it for a couple of weeks and it's been awesome, so here's the contents of the file

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
