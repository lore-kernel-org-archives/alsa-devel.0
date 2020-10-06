Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F4DC4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C62320760
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GGFNWEsX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="svhfwihA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C62320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D26EB1751;
	Tue,  6 Oct 2020 16:05:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D26EB1751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601993150;
	bh=78BG9Iu2yAlND/COH/HKK6//gm3h8RbYRE58LCuOyj4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGFNWEsXwGIGkv4xYw2dA87iu17CB4JpodqVXm2wKOiFqr+xQeMG0rFOIyQQpKpkh
	 ZyeSvwstr8Tl4y8X8SYgN5WlZKnEv92sIRZo8bJhxxGdVTXiM4y81kKos7ROvi18VN
	 2j6rE2VwHBv51maeGSvo6ch3GmlFY/VFnwGenYYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23AB3F8015B;
	Tue,  6 Oct 2020 16:04:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 853EBF80128; Tue,  6 Oct 2020 16:04:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3958F80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 16:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3958F80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="svhfwihA"
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de
 [95.90.213.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD53B2226A;
 Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601993035;
 bh=78BG9Iu2yAlND/COH/HKK6//gm3h8RbYRE58LCuOyj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=svhfwihAjLuruTbK6MWBRvuq1rTft/Sm7MfsmPdLu7gQJ+qO5Lv3oXZrSPnPSlEOb
 XSUh3Ov79m7rjubijWfJ/7oarjQXa4WiytH4/QVgnl3Of2fDI+UxewPvgFLWSsJLZ4
 N9vTVwNGT75Y8cWIvBzqYNTYv+9+rybrPdG8b47o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kPnZI-0019GH-L7; Tue, 06 Oct 2020 16:03:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 39/52] docs: writing-an-alsa-driver.rst: fix some bad
 c:func: markups
Date: Tue,  6 Oct 2020 16:03:36 +0200
Message-Id: <185686ba69268d7c9fa1996b7a42f9f860757ff2.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Takashi Iwai <tiwai@suse.de>
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

Some such markups are invalid, as reported by Sphinx:

	./Documentation/sound/kernel-api/writing-an-alsa-driver.rst:3317: WARNING: Unparseable C cross-reference: 'snd_rawmidi_transmit*'
	Invalid C declaration: Expected end of definition. [error at 20]
	  snd_rawmidi_transmit*
	  --------------------^
	./Documentation/sound/kernel-api/writing-an-alsa-driver.rst:3917: WARNING: Unparseable C cross-reference: 'copy_from/to_user'
	Invalid C declaration: Expected end of definition. [error at 9]
	  copy_from/to_user
	  ---------^

The first case seems to be better replaced by a literal.

For the second one, let's generate cross-references, by
spliting it in two.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 85d6e9c643ef..73bbd59afc33 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3315,8 +3315,7 @@ data and removes them from the buffer at once:
   }
 
 If you know beforehand how many bytes you can accept, you can use a
-buffer size greater than one with the
-:c:func:`snd_rawmidi_transmit\*()` functions.
+buffer size greater than one with the ``snd_rawmidi_transmit*()`` functions.
 
 The ``trigger`` callback must not sleep. If the hardware FIFO is full
 before the substream buffer has been emptied, you have to continue
@@ -3916,7 +3915,7 @@ the maximum size of the proc file access.
 
 The read/write callbacks of raw mode are more direct than the text mode.
 You need to use a low-level I/O functions such as
-:c:func:`copy_from/to_user()` to transfer the data.
+:c:func:`copy_from_user()` and :c:func:`copy_to_user()` to transfer the data.
 
 ::
 
-- 
2.26.2

