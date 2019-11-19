Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C3C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:49:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27812230B
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uBXVLmxu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JI7yflkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27812230B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E245E1687;
	Tue, 19 Nov 2019 11:48:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E245E1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574160565;
	bh=zy18RpjY0beUkF5+bI6jT/rhQNiVYKUcCXvR2zpIWWU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uBXVLmxuI0qTautbnkHL6yVq35Dn3BbdX6L7qT9X6VcGSxMVD1lUv/+Os/mbfWGUQ
	 wOB2Xa/o9c9b1HREuAnguy6+n4STeGlX3sAAg/ICjl2+o8iMjp1lciK9qqXLNPDARM
	 dpyBxLQBcVYFYWk4jfsoeL2E+C0H+hJ8IlDW15mI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71388F80135;
	Tue, 19 Nov 2019 11:48:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC7CEF80137; Tue, 19 Nov 2019 11:48:33 +0100 (CET)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53CD9F80119
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 11:48:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53CD9F80119
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="JI7yflkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dv+RpO5DCe2WumB5Fv1GgEhU4rDsh3gYBZ8wiOS9RGI=;
 b=JI7yflkl0tpDVrgIHxc15+6qa+93YAukXv9aKKeeY0YmwsU+yqAnW2nmcjmbM1ezDWTrcb
 +pKQCPi6VvLnslPi89uQKLgBJPVZMQfCyCsPz/SlmXDbmRlKk3j3u1RRWRRD3FUBk3Ecfb
 L8o1FoObqVe9cC4izGzQYbBRa9RFwjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-WFceUZoGMN6gvxUZTDB6ng-1; Tue, 19 Nov 2019 05:48:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3260DB60;
 Tue, 19 Nov 2019 10:48:25 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com
 [10.36.117.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 689C69302;
 Tue, 19 Nov 2019 10:48:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Date: Tue, 19 Nov 2019 11:48:19 +0100
Message-Id: <20191119104822.15053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WFceUZoGMN6gvxUZTDB6ng-1
X-Mimecast-Spam-Score: 0
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH alsa-lib 1/4] ucm: Fix opening of
	master-configs by the card's longname
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Prior to commit aba2260ae7b5 ("ucm: switch to ucm2 directory and v2 format,
keep backward compatibility").

The filename build in parse_verb_file() was build like this:
<prefix>/<uc_mgr->conf_file_name>/<file>

Where uc_mgr->conf_file_name would contain either the card_name or the
card's longname depending on the detection of a longname based config in
uc_mgr_import_master_config().

While the filename used in load_master_config() was build like this:
<prefix>/<card_name>/<card_name>.conf

And uc_mgr_import_master_config() first calls load_master_config()
with the card's longname and if that succeeds it overwrites
uc_mgr->conf_file_name with the longname so that the subsequent uses
of uc_mgr->conf_file_name in parse_verb_file() correctly use the longname.

But the new configuration_filename() helper added in commit aba2260ae7b5
_always_ builds the filename like this:
<prefix>/<uc_mgr->conf_file_name>/<file><suffix>

This breaks the loading of the master-config by its longname, as when
the longname is tried uc_mgr->conf_file_name still contains the card_name.

This commit fixes this by adding a dir parameter to configuration_filename()
and restoring the old behavior by passing card_name as dir in
load_master_config().

Fixes: aba2260ae7b5 ("ucm: switch to ucm2 directory and v2 format, keep backward compatibility")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/ucm/parser.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index ed790dc0..17aab054 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -76,9 +76,10 @@ static void configuration_filename2(char *fn, size_t fn_len, int format,
 
 static void configuration_filename(snd_use_case_mgr_t *uc_mgr,
 				   char *fn, size_t fn_len,
-				   const char *file, const char *suffix)
+				   const char *dir, const char *file,
+				   const char *suffix)
 {
-	const char *env, *dir;
+	const char *env;
 
 	if (uc_mgr->conf_format > 0) {
 		/* known format */
@@ -94,13 +95,11 @@ static void configuration_filename(snd_use_case_mgr_t *uc_mgr,
 		}
 	}
 	if (env) {
-		snprintf(fn, fn_len, "%s/%s/%s%s",
-			env, uc_mgr->conf_file_name, file, suffix);
+		snprintf(fn, fn_len, "%s/%s/%s%s", env, dir, file, suffix);
 		fn[fn_len-1] = '\0';
 		return;
 	}
 
-	dir = uc_mgr->conf_file_name;
 	if (uc_mgr->conf_format > 0) {
 __format:
 		configuration_filename2(fn, fn_len, uc_mgr->conf_format,
@@ -1181,7 +1180,8 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
 	}
 
 	/* open Verb file for reading */
-	configuration_filename(uc_mgr, filename, sizeof(filename), file, "");
+	configuration_filename(uc_mgr, filename, sizeof(filename),
+			       uc_mgr->conf_file_name, file, "");
 	err = uc_mgr_config_load(uc_mgr->conf_format, filename, &cfg);
 	if (err < 0) {
 		uc_error("error: failed to open verb file %s : %d",
@@ -1576,7 +1576,7 @@ static int load_master_config(snd_use_case_mgr_t *uc_mgr,
 	}
 
 	configuration_filename(uc_mgr, filename, sizeof(filename),
-			       card_name, ".conf");
+			       card_name, card_name, ".conf");
 
 	/* if the configuration file does not exist, silently return */
 	if (fcheck && access(filename, R_OK) != 0)
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
