Return-Path: <SRS0=oqyN=5V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA0C2BA15
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:38:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E322051A
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ojgtyaOq";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S47K8tEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E322051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8717A83B;
	Sun,  5 Apr 2020 20:37:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8717A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586111916;
	bh=f/Ie4YXO4lRUQdMYtWhaNDzbqaFZIPHdGTFi6O8/bac=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ojgtyaOq6EAJHmFQiXJRWG3m8brfNcQ7IklL4T05TviLkePhqt9CD9SDOhP3qbvTf
	 CRJxVA3LWs/tb1fm+chq7Av1Rr3ope8rvwcPgP8PE3pHgthxP/qn/WkGPt+rJwidRw
	 1R39j8uYjT0v9oaZmKO+c/9a+uembt5dd6USBoLE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A21AF802A0;
	Sun,  5 Apr 2020 20:35:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F274F80229; Sun,  5 Apr 2020 20:35:13 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80717F800E4
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2020 20:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80717F800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="S47K8tEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586111704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WA6G08Ulv5OayV027H73TwKJ2gRcdxET4LDkXo5JQm8=;
 b=S47K8tEvA9pWWpDj0s38I+a8+soeWAyOxfYG6YGb3S/EyDXooSkvUA1hdrXF/gulKpZNk1
 3sSLhQl4lH33t+FnUL81GfbLyZOugUCPbT0QXm+xjPYs2Bdmmo9O98RJl0yXR1+l+CF9zc
 b8S0q8giOuCTPU/GSA93Cmozk9pDEOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-RTXVWoboMQ6GN22RuvWENw-1; Sun, 05 Apr 2020 14:35:02 -0400
X-MC-Unique: RTXVWoboMQ6GN22RuvWENw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B8AF100551A;
 Sun,  5 Apr 2020 18:35:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8727798A51;
 Sun,  5 Apr 2020 18:35:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 4/5] chtrt5645: Remove bogus JackHWMute settings
Date: Sun,  5 Apr 2020 20:34:53 +0200
Message-Id: <20200405183454.34515-4-hdegoede@redhat.com>
In-Reply-To: <20200405183454.34515-1-hdegoede@redhat.com>
References: <20200405183454.34515-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

There is no reason why the internal microphone or speakers cannot
be used when a headset is plugged in.

The jack does not physically disconnect these, so the JackHWMute settings
are wrong, remove them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/chtrt5645/HiFi-dmic1.conf                   | 2 --
 ucm2/chtrt5645/HiFi-dmic2.conf                   | 2 --
 ucm2/chtrt5645/HiFi-mono-speaker-analog-mic.conf | 2 --
 ucm2/chtrt5645/HiFi.conf                         | 2 --
 4 files changed, 8 deletions(-)

diff --git a/ucm2/chtrt5645/HiFi-dmic1.conf b/ucm2/chtrt5645/HiFi-dmic1.con=
f
index 1a8ee0a..c7e12c9 100644
--- a/ucm2/chtrt5645/HiFi-dmic1.conf
+++ b/ucm2/chtrt5645/HiFi-dmic1.conf
@@ -50,7 +50,6 @@ SectionDevice."Headphones" {
 =09=09PlaybackPriority 200
 =09=09PlaybackPCM "hw:${CardId}"
 =09=09JackControl "Headphone Jack"
-=09=09JackHWMute "Speaker"
 =09}
=20
 =09ConflictingDevice [
@@ -96,7 +95,6 @@ SectionDevice."Headset" {
 =09=09CapturePriority 200
 =09=09CapturePCM "hw:${CardId}"
 =09=09JackControl "Headset Mic Jack"
-=09=09JackHWMute "Mic"
 =09}
=20
 =09EnableSequence [
diff --git a/ucm2/chtrt5645/HiFi-dmic2.conf b/ucm2/chtrt5645/HiFi-dmic2.con=
f
index d3f880a..95fedb3 100644
--- a/ucm2/chtrt5645/HiFi-dmic2.conf
+++ b/ucm2/chtrt5645/HiFi-dmic2.conf
@@ -50,7 +50,6 @@ SectionDevice."Headphones" {
 =09=09PlaybackPriority 200
 =09=09PlaybackPCM "hw:${CardId}"
 =09=09JackControl "Headphone Jack"
-=09=09JackHWMute "Speaker"
 =09}
=20
 =09ConflictingDevice [
@@ -98,7 +97,6 @@ SectionDevice."Headset" {
 =09=09CapturePriority 200
 =09=09CapturePCM "hw:${CardId}"
 =09=09JackControl "Headset Mic Jack"
-=09=09JackHWMute "Mic"
 =09}
=20
 =09EnableSequence [
diff --git a/ucm2/chtrt5645/HiFi-mono-speaker-analog-mic.conf b/ucm2/chtrt5=
645/HiFi-mono-speaker-analog-mic.conf
index db866cd..f6180a4 100644
--- a/ucm2/chtrt5645/HiFi-mono-speaker-analog-mic.conf
+++ b/ucm2/chtrt5645/HiFi-mono-speaker-analog-mic.conf
@@ -54,7 +54,6 @@ SectionDevice."Headphones" {
 =09=09PlaybackPriority 200
 =09=09PlaybackPCM "hw:${CardId}"
 =09=09JackControl "Headphone Jack"
-=09=09JackHWMute "Speaker"
 =09}
=20
 =09ConflictingDevice [
@@ -84,7 +83,6 @@ SectionDevice."Headset" {
 =09=09CapturePriority 200
 =09=09CapturePCM "hw:${CardId}"
 =09=09JackControl "Headset Mic Jack"
-=09=09JackHWMute "Mic"
 =09}
=20
 =09EnableSequence [
diff --git a/ucm2/chtrt5645/HiFi.conf b/ucm2/chtrt5645/HiFi.conf
index 58468a8..116d456 100644
--- a/ucm2/chtrt5645/HiFi.conf
+++ b/ucm2/chtrt5645/HiFi.conf
@@ -50,7 +50,6 @@ SectionDevice."Headphones" {
 =09=09PlaybackPriority 200
 =09=09PlaybackPCM "hw:${CardId}"
 =09=09JackControl "Headphone Jack"
-=09=09JackHWMute "Speaker"
 =09}
=20
 =09ConflictingDevice [
@@ -76,7 +75,6 @@ SectionDevice."Headset" {
 =09=09CapturePriority 200
 =09=09CapturePCM "hw:${CardId}"
 =09=09JackControl "Headset Mic Jack"
-=09=09JackHWMute "Mic"
 =09}
=20
 =09EnableSequence [
--=20
2.26.0

