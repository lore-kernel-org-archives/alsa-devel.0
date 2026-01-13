Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B712CF45D4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jan 2026 00:34:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D26F601FD;
	Tue, 13 Jan 2026 01:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D26F601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1768264492;
	bh=t2Z20IASmSRekpthgRp6LZoWnu/7JRhNC1LqmcNBaUY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=llLP9AIHn3G696VXyvMBoyBamL3EyRtJXQYgkZ5i6beBmhK5EO71JUzVSWgLbR4al
	 hjzpTWkkudfbj/PK6RWVlocWODTHtQB1U8ov9Ec083VW80OYfVwI/yiDG7Tf56ZQ6i
	 kfrdAXMasuPe3I2bulRBEHqyHE0UWPZulm1V3KGM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95869F805E4; Tue, 13 Jan 2026 01:34:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 319CCF805EB;
	Tue, 13 Jan 2026 01:34:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8621F8016D; Tue, 13 Jan 2026 01:28:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CE881F800E4
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2026 01:28:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE881F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <188a22d3b63fcc00-webhooks-bot@alsa-project.org>
In-Reply-To: <188a22d3b514b800-webhooks-bot@alsa-project.org>
References: <188a22d3b514b800-webhooks-bot@alsa-project.org>
Subject: snd_seq_drain_output change breaks existing code.
Date: Tue, 13 Jan 2026 01:28:22 +0100 (CET)
Message-ID-Hash: 5ASCCMALY5IMOPNS5FWV7IVBAMCEVWCW
X-Message-ID-Hash: 5ASCCMALY5IMOPNS5FWV7IVBAMCEVWCW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5ASCCMALY5IMOPNS5FWV7IVBAMCEVWCW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #493 was opened from Hoosier-Beagler:

The little gem shown below has broken a lot of code.  Previously, no positive results were returned and software relied on -EAGAIN to detect remaining data.  That result is no longer returned if some data was processed.  This has broken the old and stable version of my application written in C(++) which is no longer being maintained.  I have ported my app to python but this change has also broken public python wrappers for the alsa library.  In [alsa-python / pyalsa / alsaseq.c](https://github.com/alsa-project/alsa-python/blob/master/pyalsa/alsaseq.c) below line 2800 and also [python-alsa-midi / alsa_midi / client.py](https://github.com/Jajcus/python-alsa-midi/blob/main/alsa_midi/client.py) at line 626 and possibly the sub-classes as well (lines 1679, 1871).  None of these wrappers expected a valid return value and do not pass along said value returned from the c library call.

```
--- alsa-lib-1.2.14/src/seq/seq.c  2025-04-14 11:42:04.000000000 -0500
+++ alsa-lib-1.2.15.2/src/seq/seq.c       2026-01-08 08:27:57.000000000 -0600
@@ -4445,21 +4445,22 @@
 int snd_seq_drain_output(snd_seq_t *seq)
 {
        ssize_t result, processed = 0;
        assert(seq);
        while (seq->obufused > 0) {
                result = seq->ops->write(seq, seq->obuf, seq->obufused);
                if (result < 0) {
-                       if (result == -EAGAIN && processed)
+                       if (result == -EAGAIN && processed > 0)
                                return seq->obufused;
                        return result;
                }
                if ((size_t)result < seq->obufused)
                        memmove(seq->obuf, seq->obuf + result, seq->obufused - result);
                seq->obufused -= result;
+               processed += result;
        }
        return 0;
 }
 
 /**
  * \brief extract the first event in output buffer
  * \param seq sequencer handle

```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/493
Repository URL: https://github.com/alsa-project/alsa-lib
