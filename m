Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8B1C021B8
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:58:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5858360214;
	Sat,  1 Mar 2025 15:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5858360214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1740841115;
	bh=qO63Dme/0RwgdJJfNf9EXZBkzG1pcTlRUcmtCLlDDsk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ky49WvwPLPXgEtcQjxjTyEc+pAM01/0JxjsXKsYcS048lPdFyx+9NXJ/pIIJFrCr4
	 LT/rCh7qbHUh7KTIlpN2eDo70Qed0RCLNYS0qJ4+aLuuHSH40LhaoRpSlXBF6IFYpb
	 T4Qqq/c3wJe4Eg6TIn4FsPAi30KVakiIgSSCZSts=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D42AF800C1; Sat,  1 Mar 2025 15:58:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D5EF805BF;
	Sat,  1 Mar 2025 15:58:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79E51F8014B; Sat,  1 Mar 2025 15:57:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CEAC3F80095
	for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2025 15:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEAC3F80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1740841049385895014-webhooks-bot@alsa-project.org>
References: <1740841049385895014-webhooks-bot@alsa-project.org>
Subject: unclear example how to use remap plugin
Message-Id: <20250301145742.79E51F8014B@alsa1.perex.cz>
Date: Sat,  1 Mar 2025 15:57:41 +0100 (CET)
Message-ID-Hash: 6YGYXI57KHYW3MH27OPPE4IMY6MJLSSY
X-Message-ID-Hash: 6YGYXI57KHYW3MH27OPPE4IMY6MJLSSY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6YGYXI57KHYW3MH27OPPE4IMY6MJLSSY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #441 was opened from dibalavs:

Hello. 

I combiled 3 sound cards into one vrurtual 5.1 card for PCM, and now trying to make volume control also to use single virtual device, to set up volume for all chanel of virtual 5.1 card.

 
I am trying to use remap control plugin mentioned at [source](https://github.com/alsa-project/alsa-lib/blob/master/src/control/control_remap.c#L1230)

But I unable to understand what does it mean:

```
ctl.name {
	type remap              # Remap controls
	child STR               # Child name
	# or
	child {                 # Child definition
		type STR
		...
	}
	remap {
		# the ID strings are parsed in the amixer style like 'name="Headphone Playback Switch",index=2'
		SRC_ID1_STR DST_ID1_STR
		SRC_ID2_STR DST_ID2_STR
		...
	}
	map {
		# join two stereo controls to one
		CREATE_ID1_STR {
			SRC_ID1_STR {
				vindex.0 0	# source channel 0 to merged channel 0
				vindex.1 1
			}
			SRC_ID2_STR {
				vindex.2 0
				vindex.3 1	# source channel 1 to merged channel 3
			}
		}
		# split stereo to mono
		CREATE_ID2_STR {
			SRC_ID3_STR {
				vindex.0 0	# stereo to mono (first channel)
			}
		}
		CREATE_ID3_STR {
			SRC_ID4_STR {
				vindex.0 1	# stereo to mono (second channel)
			}
		}
	}
}
```


I do not understand what should I write as SRC and DST?:

```
# the ID strings are parsed in the amixer style like 'name="Headphone Playback Switch",index=2'
SRC_ID1_STR DST_ID1_STR
SRC_ID2_STR DST_ID2_STR
```

Can you give real example without placeholders like: "name", "SRC", "DST", "STR" ?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/441
Repository URL: https://github.com/alsa-project/alsa-lib
