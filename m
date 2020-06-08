Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B29C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:24:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768242076C
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ku0yo4sE";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX8nIUcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768242076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2B121676;
	Mon,  8 Jun 2020 22:23:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2B121676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591647875;
	bh=W+/71z+muXc5iTtTUxsFJfL4a/cVSskdySsz03Q/x34=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ku0yo4sEKYhKutjQ8/0pmRwb8RJ1W9g5qxaq2i9AY51qaGVaxYmd2ALa1N1roz9QN
	 dutTm35dlJe+r8pScyYR32Q/WbqFyyH+STTGr2uDwWDKK8Xg50IF9heBmhSrA5urQh
	 3KyGsOtAdGkCNezFJRVl65UYzNWGCmmExMF18/Zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37FC5F80124;
	Mon,  8 Jun 2020 22:22:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38A0AF802A0; Mon,  8 Jun 2020 22:22:04 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AF6DF80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 22:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AF6DF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="VX8nIUcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591647718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8DbncCAj8G8TsX0W6TCLzlIdnP0hriQNqIs9TTuAgbY=;
 b=VX8nIUcnBw00IBFeGTtcp6dFmhRs/utj4+jgFABhiCzxgcJ5vdXzLe5gvtn0EQVDelHTyU
 mwCauKHtuqEv8nv95/qWg5fe8nfQwFQ4qx+i7ZHp66zax9nG/cuWXBVwwYPqD6oYQO9gIX
 Mi6KkOih588w2AhF4STL/6GtfXP5n/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-D-1prupUP4Oecl1s59CFig-1; Mon, 08 Jun 2020 16:21:49 -0400
X-MC-Unique: D-1prupUP4Oecl1s59CFig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F25210CE792;
 Mon,  8 Jun 2020 20:21:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-122.ams2.redhat.com
 [10.36.114.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2482D6116D;
 Mon,  8 Jun 2020 20:21:43 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/3] bytcr-rt5640: Fix DMIC1 not working when connected over
 AIF2
Date: Mon,  8 Jun 2020 22:21:40 +0200
Message-Id: <20200608202142.92894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

The RT5640 codec has 2 ADC-s which are caled the Stereo ADC and the
Mono ADC (even though the mono ADC seems to be stereo too?). The Stereo
ADC is connected to the AIF1 interface of the codec and the Mono ADC
to the AIF2 interface.

Almost all X86 BYT/CHT design use the AIF1 interface, but a few models
use the AIF2 interface. For this reason the IN?-InternalMic.conf bits
not only select/enable the microphone input on the Stereo ADC, but
also on the Mono ADC, so that the analog mic. inputs also work in devices
using the AIF2 interface.

Before this commit DigitalMics.conf was only setting up the DMIC input
on the Stereo ADC and not on the Mono ADC, causing DMIC1 to not work
when connected over AIF2.

This commit adds selecting / enabling DMIC1 on the Mono ADC.
This fixes the internal microphone not working on the Toshiba Encore WT10A.

Note that for devices which use the AIF1 interface this is a no-op since
the AIF1 interface is not connected to anything, there is no complete
chain so DAPM will not enable any of the elements in the chain.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5640/DigitalMics.conf | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ucm2/codecs/rt5640/DigitalMics.conf b/ucm2/codecs/rt5640/DigitalMics.conf
index 503c4a9..fdd412f 100644
--- a/ucm2/codecs/rt5640/DigitalMics.conf
+++ b/ucm2/codecs/rt5640/DigitalMics.conf
@@ -6,6 +6,9 @@ SectionDevice."Mic" {
 	]
 
 	EnableSequence [
+		cset "name='Mono ADC MIXL ADC2 Switch' on"
+		cset "name='Mono ADC MIXR ADC2 Switch' on"
+		cset "name='Mono ADC Capture Switch' on"
 		cset "name='Stereo ADC MIXL ADC2 Switch' on"
 		cset "name='Stereo ADC MIXR ADC2 Switch' on"
 		cset "name='Internal Mic Switch' on"
@@ -13,6 +16,9 @@ SectionDevice."Mic" {
 	]
 
 	DisableSequence [
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+		cset "name='Mono ADC Capture Switch' off"
 		cset "name='Stereo ADC MIXL ADC2 Switch' off"
 		cset "name='Stereo ADC MIXR ADC2 Switch' off"
 		cset "name='Internal Mic Switch' off"
-- 
2.26.2

