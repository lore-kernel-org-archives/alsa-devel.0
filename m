Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA21C25B78
	for <alsa-devel@archiver.kernel.org>; Wed, 22 May 2024 23:43:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01066839;
	Thu, 23 May 2024 01:42:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01066839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716421389;
	bh=WR2XmlUO++ZRznTHcJOrYAc8fH8eLZwzKuxB7B3UH8I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CN3oKNJEYjh+lCiLbNSMNgp88wv82UsCdvR30S0BpyxWS1d/SLBf2x5NMa3axl/77
	 co9ARf8uTzG2J7gycw61DvU0WaBoI2f96AbGCfdPNGPPhREW7VF1V3+CIwMf/3LC3u
	 vH3jLl7fLOqeAgd552aSl7r1Gom1X9vJ0wUx5oP4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7306DF80587; Thu, 23 May 2024 01:42:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5D6BF805AD;
	Thu, 23 May 2024 01:42:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC4BBF8026A; Thu, 23 May 2024 01:41:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id CCD8BF800BA
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2024 01:41:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCD8BF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1716421282414216995-webhooks-bot@alsa-project.org>
References: <1716421282414216995-webhooks-bot@alsa-project.org>
Subject: topology: pre-processor: Introduce extends/overrides keywords for
 classes
Message-Id: <20240522234124.CC4BBF8026A@alsa1.perex.cz>
Date: Thu, 23 May 2024 01:41:24 +0200 (CEST)
Message-ID-Hash: DQSV6LS3SLGMQWKBUKVCYGZW5LWUSG52
X-Message-ID-Hash: DQSV6LS3SLGMQWKBUKVCYGZW5LWUSG52
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DQSV6LS3SLGMQWKBUKVCYGZW5LWUSG52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #268 was edited from ranj063:

Introduce a new keyword "Subtreecopy" for extending existing conf nodes
with additional nodes. This feature is useful for extending previous
pipeline class definitions with the addition of one or more widgets
without having to duplicate everything in the new class definition.

For example: Consider a pipeline class definition as below. Note that
only the widgets & routes are shown here.
```
Class.Pipeline.mixout-gain-dai-copier-playback {
	Object.Widget {
		mixout."1" {}
		dai-copier."1" {}
		gain."1" {}
		pipeline."1" {}
	}

	Object.Base {
		!route [
			{
				source mixout.$index.1
				sink	gain.$index.1
			}
		]
	}
}
```
If we want to extend this pipeline with the addition of an eqiir/eqfir,
we can create a Subtreecopy node with type extend as follows:
```
Subtreecopy.mixout-gain-eqiir-eqfir-dai-copier-playback {
	source "Class.Pipeline.mixout-gain-dai-copier-playback"
	target "Class.Pipeline"
	type extend

	Object.Widget {
		eqiir.1 {}
		eqfir.1 {}
	}

	Object.Base {
		!route [
			{
				source gain.$index.1
				sink   eqiir.$index.1
			}
			{
				source eqiir.$index.1
				sink   eqfir.$index.1
			}
		]
	}
}
```
But if we want to modify an existing pipeline class while modifying the
order of widgets and/or inserting new widgets, we should use the type
"override" instead. This allows for adding new widgets to the list of
widgets in the base class definition while also allowing overriding the
routes to allow inserting the new widgets and reordering the widgets in
the base class. For example, if we want to add a drc widget between the
gain and the eqiir modules in the above class, we can do the following:
```
Subtreecopy.mixout-efx-dai-copier-playback {
	source "Class.Pipeline.mixout-gain-eqiir-eqfir-dai-copier-playback"
	target "Class.Pipeline"
	type override

	Object.Widget {
		drc.1 {}
	}

	Object.Base {
		!route [
			{
				source mixout.$index.1
				sink	gain.$index.1
			}
			{
				source gain.$index.1
				sink	drc.$index.1
			}
			{
				source	drc.$index.1
				sink	eqiir.$index.1
			}
			{
				source	eqiir.$index.1
				sink	eqfir.$index.1
			}
		]
	}
}
```
Note that the routes array contains all the routes in the new subtreecopy definition.

This subtreecopy feature can also be used to copy normal config blocks
without having the need to duplicate information.

For example, if all the widgets in a pipeline support the same audio
formats, we can define it as follows:
```
Class.Pipeline.dai-copier-eqiir-module-copier-capture {
	formats {
		num_input_audio_formats 2
		num_output_audio_formats 2

		Object.Base.input_audio_format [
			{
				in_bit_depth		32
				in_valid_bit_depth	32
			}
			{
				in_channels		4
				in_bit_depth		32
				in_valid_bit_depth	32
				in_ch_cfg	$CHANNEL_CONFIG_3_POINT_1
				in_ch_map	$CHANNEL_MAP_3_POINT_1
			}
		]

		Object.Base.output_audio_format [
			{
				out_bit_depth		32
				out_valid_bit_depth	32
			}
			{
				out_channels		4
				out_bit_depth		32
				out_valid_bit_depth	32
				out_ch_cfg	$CHANNEL_CONFIG_3_POINT_1
				out_ch_map	$CHANNEL_MAP_3_POINT_1
			}
		]
	}

	Object.Widget {
		dai-copier."1" {
			type dai_out
			num_output_pins 1

			Subtreecopy.formats {
				source "Class.Pipeline.dai-copier-eqiir-module-copier-capture.formats"
				type override
			}
		}

		eqiir."1" {
			Subtreecopy.formats {
				source "Class.Pipeline.dai-copier-eqiir-module-copier-capture.formats"
				type override
			}

			Object.Control.bytes."1" {
				IncludeByKey.DMIC0_DAI_EQIIR {
					"passthrough"		"include/components/eqiir/passthrough.conf"
					"highpass_40hz_0db"	"include/components/eqiir/highpass_40hz_0db_48khz.conf"
					"highpass_40hz_20db"	"include/components/eqiir/highpass_40hz_20db_48khz.conf"
				}
			}
		}

		module-copier."2" {
			Subtreecopy.formats {
				source "Class.Pipeline.dai-copier-eqiir-module-copier-capture.formats"
				type override
			}
		}

		pipeline."1" {
			priority	0
			lp_mode		0
		}
	}
}
```
The subtreecopy node in each widget ensures that the pipeline formats
are applied to all widgets without the need for duplicating them for
each widget.

Link: https://github.com/thesofproject/sof/issues/9082

Request URL   : https://github.com/alsa-project/alsa-utils/pull/268
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/268.patch
Repository URL: https://github.com/alsa-project/alsa-utils
