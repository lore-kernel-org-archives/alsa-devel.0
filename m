Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D0AC2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:15:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733A020737
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bdIn6LEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733A020737
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6D9A16CC;
	Mon, 13 Apr 2020 09:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6D9A16CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586762156;
	bh=6b3h8AzJGWZ1ZJFlRphzRsVYeQCV2003KdeHiG4hzg8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bdIn6LEtrenCTc1RUFZ42LpBt8xRAapquDhddwzd0orVGx7uf2NHvQbCvqtCaVJdx
	 G+peZm3Pz2ie8GWBylCeH2jS8wTsUoIxkUeWpKaHn1IfLBi1OWHx5aFRnR2gKalK64
	 qrS4MVQov26LqDpMIvNpvfF5Sn+kKfRn2ZohrFuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F3D8F80229;
	Mon, 13 Apr 2020 09:15:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37D5FF80245; Mon, 13 Apr 2020 09:15:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 72767F80115
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 09:14:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72767F80115
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586762099508881092-webhooks-bot@alsa-project.org>
References: <1586762099508881092-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq: tstamp: use wrapper structure instead of union
Message-Id: <20200413071504.37D5FF80245@alsa1.perex.cz>
Date: Mon, 13 Apr 2020 09:15:04 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #17 was opened from takaswie:

In UAPI for ALSA Sequencer, snd_seq_timestamp is union with
snd_seq_tick_time_t and struct snd_seq_real_time types. The
libalsaseq has GLib Boxed object for the union, named as
ALSASeqTstamp.

```
$ cat build/src/seq/ALSASeq-0.0.gir
    ...
    <union name="Tstamp"
           c:type="ALSASeqTstamp"
           glib:type-name="ALSASeqTstamp"
           glib:get-type="alsaseq_tstamp_get_type"
           c:symbol-prefix="tstamp">
      <source-position filename="../src/seq/tstamp.h" line="14"/>
      ...
    </union>
    ...
```

Although this is valid in a view of GObject
Introspection, it's not necessarily convenient to language
bindings because some programming language doesn't support
union type. In this case, the type is not available.

This commit adds an alternative structure to wrap the union.
As a result, ALSASeqTstamp is GLib Boxed object for the
wrapper structure.

```
$ cat build/src/seq/ALSASeq-0.0.gir
    ...
    <record name="Tstamp"
            c:type="ALSASeqTstamp"
            glib:type-name="ALSASeqTstamp"
            glib:get-type="alsaseq_tstamp_get_type"
            c:symbol-prefix="tstamp">
      <source-position filename="../src/seq/tstamp.h" line="18"/>
      <field name="tstamp" writable="1">
        <type name="gpointer" c:type="snd_seq_timestamp"/>
      </field>
      ...
    </record>
    ...
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/17
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/17.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
