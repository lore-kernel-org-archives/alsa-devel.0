Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A06CC00140
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Aug 2022 09:28:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF52382C;
	Wed, 10 Aug 2022 11:27:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF52382C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660123684;
	bh=fnWJLzWvxId/v0/lNipxL0f8n9B8J4/LqesVWVdKxDw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RKj77sST3czZ0c5hpiHXaRrNWjEz/1Wcjx8jN0z2fSPh+rpexBpLB2FkBvMH3pWOk
	 rge79nJ3q1Bw/7oSoYG6fbw3WA7m5RLRjVeo62Q6XrzxL9Qc2FenOuY+JsPxmlfR/U
	 BZdSGqO+8pcrdIJGiaHk2S5sSfHJOdEjQCxaROOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E5F2F80154;
	Wed, 10 Aug 2022 11:27:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C73F5F801F5; Wed, 10 Aug 2022 11:27:11 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9994BF80132
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2022 11:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9994BF80132
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4M2l2J4Btmz9sdD;
 Wed, 10 Aug 2022 11:27:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id you5eUQs1kjl; Wed, 10 Aug 2022 11:27:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4M2l1F6NlSz9sdC;
 Wed, 10 Aug 2022 11:26:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CDB4B8B77B;
 Wed, 10 Aug 2022 11:26:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 33D6Qb5HhjkF; Wed, 10 Aug 2022 11:26:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B0D418B763;
 Wed, 10 Aug 2022 11:26:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27A9PxPi340335
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Aug 2022 11:25:59 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27A9PwvR340334;
 Wed, 10 Aug 2022 11:25:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] aplay: Add support for G711 A law on .au files
Date: Wed, 10 Aug 2022 11:25:40 +0200
Message-Id: <20220810092540.340279-1-christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
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

.au files support G711 A law as well. Add it to aplay.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 aplay/aplay.c   | 9 +++++++++
 aplay/formats.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 6ce7191..c004bf9 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1210,6 +1210,12 @@ static int test_au(int fd, void *buffer)
 			fprintf(stderr, _("Warning: format is changed to S16_BE\n"));
 		hwparams.format = SND_PCM_FORMAT_S16_BE;
 		break;
+	case AU_FMT_ALAW:
+		if (hwparams.format != DEFAULT_FORMAT &&
+		    hwparams.format != SND_PCM_FORMAT_A_LAW)
+			fprintf(stderr, _("Warning: format is changed to A_LAW\n"));
+		hwparams.format = SND_PCM_FORMAT_A_LAW;
+		break;
 	default:
 		return -1;
 	}
@@ -2735,6 +2741,9 @@ static void begin_au(int fd, size_t cnt)
 	case SND_PCM_FORMAT_S16_BE:
 		ah.encoding = BE_INT(AU_FMT_LIN16);
 		break;
+	case SND_PCM_FORMAT_A_LAW:
+		ah.encoding = BE_INT(AU_FMT_ALAW);
+		break;
 	default:
 		error(_("Sparc Audio doesn't support %s format..."), snd_pcm_format_name(hwparams.format));
 		prg_exit(EXIT_FAILURE);
diff --git a/aplay/formats.h b/aplay/formats.h
index ac0a2b0..cbc99fe 100644
--- a/aplay/formats.h
+++ b/aplay/formats.h
@@ -121,6 +121,7 @@ typedef struct {
 #define AU_FMT_ULAW		1
 #define AU_FMT_LIN8		2
 #define AU_FMT_LIN16		3
+#define AU_FMT_ALAW		27
 
 typedef struct au_header {
 	u_int magic;		/* '.snd' */
-- 
2.37.1

