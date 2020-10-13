Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9529C433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:00:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58473208D5
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ilA9I8qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58473208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scripple.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5749F16B3;
	Tue, 13 Oct 2020 22:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5749F16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602622827;
	bh=kChyVfQl72ndY4H2OM+A+yxqQYA2xFlS7a5RJ94jvCg=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ilA9I8qPoeZx2FKLUf5JssOzgSoeBJSz5mPAnwJYxKL2VfckzSwVFRzCBK38hyhSb
	 27PUlznhkc2vbz9Rpi1aOfvexRuTajsH2wuyZe04xAIzyCvbx5yxs7DMLSEWZOKBfz
	 i+sFgkIwq3QgDRyLVBcKYUZbN9MnnyEmFq79gI28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 050C7F8012C;
	Tue, 13 Oct 2020 22:59:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DDBFF801A3; Tue, 13 Oct 2020 22:59:35 +0200 (CEST)
Received: from host.schells.com (host.schells.com [162.211.87.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 287B6F8012C
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 22:59:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 287B6F8012C
Received: from ip72-222-173-254.ph.ph.cox.net ([72.222.173.254]
 helo=benji.seadrac.com) by host.schells.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <alsa@scripple.org>) id 1kSROP-0003A8-6s
 for alsa-devel@alsa-project.org; Tue, 13 Oct 2020 13:59:33 -0700
Received: from [IPv6:::1] (localhost [IPv6:::1])
 by benji.seadrac.com (Postfix) with ESMTP id D9DC7239FF8
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 13:59:27 -0700 (MST)
From: alsa@scripple.org
Subject: Accessing pending hw_params in SND_PCM_HOOK_TYPE_HW_PARAMS call back
To: alsa-devel@alsa-project.org
Message-ID: <162e9d94-86f6-864e-443b-6a2096d1f33d@schells.com>
Date: Tue, 13 Oct 2020 13:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: cs@schells.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

I'll try again with a more specific question.

Is there a way one can access the hw_params that cause the 
SND_PCM_HOOK_TYPE_HW_PARAMS call back to be called inside the call back 
function?

The hook only provides access to the snd_pcm_t object, but all the 
public calls to get hw_params fail because it's not in a prepared state yet.

If there isn't a way to get them now could we please add the ability 
with a patch like the one below?

With this patch a call to snd_pcm_hook_get_hw_params provides access to 
the pending hw_params structure and the pending parameters can be 
accessed with standard calls like snd_pcm_hw_params_get_channels.

Hopefully I'm just missing how to get them without the patch, but if not 
they really should be made accessible.


diff --git a/alsa-lib-1.1.8/include/pcm.h b/pcm.h
index 5b07823..0cf5dca 100644
--- a/alsa-lib-1.1.8/include/pcm.h
+++ b/pcm.h
@@ -1181,6 +1181,7 @@ typedef struct _snd_pcm_hook snd_pcm_hook_t;
  /** PCM hook callback function */
  typedef int (*snd_pcm_hook_func_t)(snd_pcm_hook_t *hook);
  snd_pcm_t *snd_pcm_hook_get_pcm(snd_pcm_hook_t *hook);
+snd_pcm_hw_params_t *snd_pcm_hook_get_hw_params(snd_pcm_hook_t *hook);
  void *snd_pcm_hook_get_private(snd_pcm_hook_t *hook);
  void snd_pcm_hook_set_private(snd_pcm_hook_t *hook, void *private_data);
  int snd_pcm_hook_add(snd_pcm_hook_t **hookp, snd_pcm_t *pcm,



diff --git a/alsa-lib-1.1.8/src/pcm/pcm_hooks.c b/pcm_hooks.c
index 4416d36..f56c3af 100644
--- a/alsa-lib-1.1.8/src/pcm/pcm_hooks.c
+++ b/pcm_hooks.c
@@ -38,6 +38,7 @@ const char *_snd_module_pcm_hooks = "";
  #ifndef DOC_HIDDEN
  struct _snd_pcm_hook {
         snd_pcm_t *pcm;
+       snd_pcm_hw_params_t *params;
         snd_pcm_hook_func_t func;
         void *private_data;
         struct list_head list;
@@ -117,6 +118,7 @@ static int snd_pcm_hooks_hw_params(snd_pcm_t *pcm, 
snd_pcm_hw_params_t *params)
                 return err;
         list_for_each_safe(pos, next, 
&h->hooks[SND_PCM_HOOK_TYPE_HW_PARAMS]) {
                 snd_pcm_hook_t *hook = list_entry(pos, snd_pcm_hook_t, 
list);
+               hook->params = params;
                 err = hook->func(hook);
                 if (err < 0)
                         return err;
@@ -563,6 +565,17 @@ snd_pcm_t *snd_pcm_hook_get_pcm(snd_pcm_hook_t *hook)
         return hook->pcm;
  }

+/**
+ * \brief Get hw_params handle for a PCM hook
+ * \param hook PCM hook handle
+ * \return hw_params handle
+ */
+snd_pcm_hw_params_t *snd_pcm_hook_get_hw_params(snd_pcm_hook_t *hook)
+{
+       assert(hook);
+       return hook->params;
+}
+
  /**
   * \brief Get callback function private data for a PCM hook
   * \param hook PCM hook handle
@@ -609,6 +622,7 @@ int snd_pcm_hook_add(snd_pcm_hook_t **hookp, 
snd_pcm_t *pcm,
         if (!h)
                 return -ENOMEM;
         h->pcm = pcm;
+       h->params = NULL;
         h->func = func;
         h->private_data = private_data;
         hooks = pcm->private_data;
