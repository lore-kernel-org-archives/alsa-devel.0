Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007EFC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 11:47:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C6861373
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 11:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05C6861373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B7594E;
	Mon, 23 Aug 2021 13:46:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B7594E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629719268;
	bh=uf/bRxlMflMRbWGOYMw1BFi0GqTQZujLfnN9B+1eZKY=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QfE3MeM+uEd4xBGpkFhsrVvEKQHycDkdYIAkiGIPZZd4QzFmy4Bt6i9zvw/OBEegy
	 cmnbW+IRZtKIBsp9PQjSJO9OqHyZGYZPqOwIlEKnNT7JqBT8Nfd723LqF5X9VRhQ2d
	 Sqneyhugf9GyGUzoBG2RhP5lXFjLMpciJ5xtVtkQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A33F4F8020C;
	Mon, 23 Aug 2021 13:46:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10320F80217; Mon, 23 Aug 2021 13:46:56 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86225F8016E
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 13:46:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86225F8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="B0pfG5pB"
Received: by mail-il1-x12e.google.com with SMTP id y3so16780788ilm.6
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=yy4pE1GOmOy9ogUg19qEnYHdTY0X4dKp77N6saqxSvA=;
 b=B0pfG5pB25UV215r8g5FoDMPhITadc4t1NuapsT8r6gtdQBsKKPtKuUPfPlYAwZK84
 c+B47+cfSB1u0lGfv/VDcll2dfxAT5gmichduTG9ggBDnxvCb+kIQjZiNEXOB/QgnM0E
 fjFKvNK51uqmzrww5hZG+MVHXnsjPSk+7g+No5lvtMnZgruleJ3uj9vjBn9WCZpegv/8
 HTPgOFooOM/oxNZPpghTClYJgBbk/ragG5U/wLfZcY3BrhH3KrafZr2rKo3pBsv4DIgd
 FpPYZc2vF16sm4kUavbSPrAcPjr3v/2eqvXD0Y2HQLqjYGA7WF/DEBAT84gx0fI1m70p
 mBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=yy4pE1GOmOy9ogUg19qEnYHdTY0X4dKp77N6saqxSvA=;
 b=l+NbEVIM4+y4kEgD4/DiK9KF7nBMUanokss51WBh6o0MjURycZdD4CxZTK+t5kn1sg
 90iIg/aIB8TuMlEDenRdhHiOZnfw2MzfGPtrv4+9J8T9UAi+3LC23b5qqqz0CidNHH4c
 GdPJ/I6o9izgTRpSEwH4GZIfVk13bB6L/0SC3dAW3jkzzsxhimw2RTzNqHEbGL9TUNq6
 s2Ul2D0POw0eKBEJxFIpcg72pwIgk8Whwf5wLnE8kdVvCGyw5MRepCGyZDdF5o5VDi3J
 hTIwH0rLlpisUOuBzmieNfsi6qxWAtGMr+g+oYUllqKnWauIwwZWetrtcQDoQNM8PYdm
 +m8A==
X-Gm-Message-State: AOAM532MPFc7a0OUuAk7ni3/2U54/jH5z8kvEYgdWqMB92bKAjKrXTym
 xeK2kn4oUZto+a5FfM51MrqAlFgw3MYGVqZhCOqBv62yGPo=
X-Google-Smtp-Source: ABdhPJyQjikMfXUO2p643TEeVupCrPB0Ln/+oVrDjQqS1okMVz3UFxShfcF9piF2i+y9fs+A2K27s//jKC+PmC5N3bI=
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr22699041ilh.194.1629719208597; 
 Mon, 23 Aug 2021 04:46:48 -0700 (PDT)
MIME-Version: 1.0
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 23 Aug 2021 13:46:37 +0200
Message-ID: <CAGFh027Yf8wQxsxNkMDcN8cSZGu38CviYN=KSLZWabrZsOaV6g@mail.gmail.com>
Subject: [PATCH 1/2] ioplug: Check for callback error codes
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 src/pcm/pcm_ioplug.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 98184398..c96104e9 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -54,7 +54,7 @@ static int snd_pcm_ioplug_poll_revents(snd_pcm_t
*pcm, struct pollfd *pfds, unsi

 /* update the hw pointer */
 /* called in lock */
-static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
+static int snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 {
  ioplug_priv_t *io = pcm->private_data;
  snd_pcm_sframes_t hw;
@@ -85,7 +85,9 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
  snd_pcm_ioplug_drop(pcm);
  else
  io->data->state = SNDRV_PCM_STATE_XRUN;
+ return -EPIPE;
  }
+ return 0;
 }

 static int snd_pcm_ioplug_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
@@ -115,7 +117,10 @@ static int snd_pcm_ioplug_delay(snd_pcm_t *pcm,
snd_pcm_sframes_t *delayp)
      io->data->callback->delay)
  return io->data->callback->delay(io->data, delayp);
  else {
- snd_pcm_ioplug_hw_ptr_update(pcm);
+ int err;
+ err = snd_pcm_ioplug_hw_ptr_update(pcm);
+ if (err < 0)
+ return err;
  *delayp = snd_pcm_mmap_delay(pcm);
  }
  return 0;
@@ -499,11 +504,14 @@ static int snd_pcm_ioplug_start(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 {
  ioplug_priv_t *io = pcm->private_data;
+ int err;

  if (io->data->state == SND_PCM_STATE_OPEN)
  return -EBADFD;

- io->data->callback->stop(io->data);
+ err = io->data->callback->stop(io->data);
+ if (err < 0)
+ return err;

  gettimestamp(&io->trigger_tstamp, pcm->tstamp_type);
  io->data->state = SND_PCM_STATE_SETUP;
@@ -625,7 +633,7 @@ static int snd_pcm_ioplug_resume(snd_pcm_t *pcm)
  ioplug_priv_t *io = pcm->private_data;

  if (io->data->callback->resume)
- io->data->callback->resume(io->data);
+ return io->data->callback->resume(io->data);
  return 0;
 }

@@ -898,13 +906,14 @@ static void clear_io_params(ioplug_priv_t *io)
 static int snd_pcm_ioplug_close(snd_pcm_t *pcm)
 {
  ioplug_priv_t *io = pcm->private_data;
+ int err = 0;

  clear_io_params(io);
  if (io->data->callback->close)
- io->data->callback->close(io->data);
+ err = io->data->callback->close(io->data);
  free(io);

- return 0;
+ return err;
 }

 static const snd_pcm_ops_t snd_pcm_ioplug_ops = {
-- 
2.31.1
