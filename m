Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5194C54ED1
	for <alsa-devel@archiver.kernel.org>; Thu, 22 May 2025 22:16:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EB0A601F3;
	Fri, 23 May 2025 00:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EB0A601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747952211;
	bh=ksa2Xj9VzgRqKFAIsxNbcgrfcTwrMTti6fBfUbMFuqE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OZavKP31EjpQ2KsuBjqJ/PS+js9y/oq9fJfTiK6eIv0s+TfWd6hDt6Kev4F7cxstv
	 yQbfLPFwNr4N3wyAseYayopKuYXsyC4cKLFeIhqaYMHAVzo2U0jcQFWefktBih+7/s
	 y06Nuej6vljgGJfPsRff+c8kVg68a3XE9rPfHXKE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5540CF80611; Fri, 23 May 2025 00:15:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47AE9F8060F;
	Fri, 23 May 2025 00:15:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D471FF805B4; Fri, 23 May 2025 00:15:47 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4087BF805AA
	for <alsa-devel@alsa-project.org>; Fri, 23 May 2025 00:15:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4087BF805AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1841f93749597300-webhooks-bot@alsa-project.org>
In-Reply-To: <1841f9374957c700-webhooks-bot@alsa-project.org>
References: <1841f9374957c700-webhooks-bot@alsa-project.org>
Subject: snd_config_imul always produces a zero result.
Date: Fri, 23 May 2025 00:15:47 +0200 (CEST)
Message-ID-Hash: KVEFYXNO4R7DECKP2VYO73IRNEHUOYBN
X-Message-ID-Hash: KVEFYXNO4R7DECKP2VYO73IRNEHUOYBN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KVEFYXNO4R7DECKP2VYO73IRNEHUOYBN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #456 was edited from shanekirk:

The config function snd_config_imul always produces a zero result. This is because it delegates to snd_func_iops() to perform the iterative multiplication, which always initializes its result value to zero. Then it iteratively multiplies-assigns result against each integer in the params array, which _always_ produces zero.

This breaks any configuration that leans on "\@func imul".

This can be demonstrated using this snippet of configuration...

```
test_fn
{
    @func imul
    integers [2 4 6]
}

```
...or this source code...
```
int main(int argc, char **argv)
{
    snd_config_t *pConfig = NULL;
    snd_config_top(&pConfig);

    /**
     * Setting up...
     * test_fn
     * {
     *     @func imul
     *     integers [2 4 6]
     * }
     */
    snd_config_t *pFnCS = NULL;
    snd_config_make_compound(&pFnCS, "test_fn", 0);
    snd_config_add(pConfig, pFnCS);

    snd_config_t *pFn = NULL;
    snd_config_imake_string(&pFn, "@func", "imul");
    snd_config_add(pFnCS, pFn);

    snd_config_t *pFnParams = NULL;
    snd_config_make_compound(&pFnParams, "integers", 0);
    snd_config_add(pFnCS, pFnParams);

    snd_config_t *pFnInt = NULL;
    snd_config_imake_integer(&pFnInt, "0", 2);
    snd_config_add(pFnParams, pFnInt);
    snd_config_imake_integer(&pFnInt, "1", 4);
    snd_config_add(pFnParams, pFnInt);
    snd_config_imake_integer(&pFnInt, "2", 6);
    snd_config_add(pFnParams, pFnInt);

    /**
     * Evaluating...
     */
    snd_config_evaluate(pFnCS, pConfig, NULL, NULL);
    assert(snd_config_get_type(pFnCS) == SND_CONFIG_TYPE_INTEGER);
    long result = 0;
    snd_config_get_integer(pFnCS, &result);
    assert(result == 48); // ** FAILS because result is always zero! **

    snd_config_delete(pConfig);
    return 0;
}
```

Note: If you replace "imul" above with "iadd" in either example, you'll get the result from iadd that you'd expect.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/456
Repository URL: https://github.com/alsa-project/alsa-lib
