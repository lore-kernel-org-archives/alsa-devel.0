Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9420CD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:44:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A87F0601A4;
	Mon, 11 May 2026 16:44:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A87F0601A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510694;
	bh=PMWgb9uJVc3m5xu4+aIIUkJe62zTNopP2DAgcY2FgMA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TtEBwJJjGJD1N9UgIppkTTUHp4/qWYsT3+XYq0VV5e0CyJNoT1rSdR1s5ApNYAh+J
	 v6FBrgxF45RNFTZP1D3YqA8Hr40Lp3tR77Yr1LKLOu9jXkGObWl/m9yic83Z6F6n9s
	 +Y5ViUoYoea4IRihil6s6qV607K4ExTXMcr6/PY4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E726F805F0; Mon, 11 May 2026 16:44:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD99BF805F2;
	Mon, 11 May 2026 16:44:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 552C8F80518; Thu,  7 May 2026 19:02:41 +0200 (CEST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 644C5F800BA
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 19:02:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 644C5F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=b25hT+1e
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-bc3582acc23so171685366b.3
        for <alsa-devel@alsa-project.org>;
 Thu, 07 May 2026 10:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778173358; cv=none;
        d=google.com; s=arc-20240605;
        b=Fm1Oj49g2QpRDWdwJnsUvkjFEsb3IW69gOR/PpSliTJ9N8UQ1nLUlATSaZNxVyjZqx
         5sfvtbWH1D3a+h3li3rt+J35cUqDiG5rkG+nSimJsyNistbd7Sqzs48dXB3MqCfKMiym
         /7UNvFaSbVXMq+9B7F3yE3Ke8LjAIxNwlR+dwm2RzSH6zyRzrDo5HtDO0AAvrkc2D1cI
         5otYNPJXex9vHQR6IkeE2GTulrZooldUkQKVgNupnezxmGs12IIwZ+uOExULRnXkyi1c
         /UdxaFxtGPJ3G4b0L+LykM/lvvVfVE/QB5vAGvi1w5Zi1Syytv6nuQYhuifqrd96QdxH
         xNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=1J2t5i39j9btklP0Qp7lKPNwpkZtHDIsNaGDaYrLOQ4=;
        fh=RDcT3X+HgBVDoNRDWQL8z0RayWd9J/vicvRjVP74ldw=;
        b=C7PfHdDg3VygbUk0YKFlOF59cNrCBoS/Diky2CL5Uynq3iZ9paVgYnaBFPfTognFR4
         Nk8z1AChgBIOPiAUaFwTdCseJKjuAjraq+xBq5v6kQWaO/zQMr5HD/QELyO4hES37I8u
         LYf4vJjW21w8XUDNCOwYt6n+VuzPOzgqAd3Z5jgN3XO7wqGVWMk15hySPNYus+6b0yoQ
         o0T50dm3/xI8uy9nyHQaGGyUfDVgGcidW97/KEC1MYAbGu1471IzaZj92Ilf2gsqewvk
         U4Qp1Xdbu5ToGcOx6iJs06p6ei+EhSdck7fSX9mwVZwDOEnshqp5rk0vyDWNEg/Lk/Fa
         fKGA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778173358; x=1778778158;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1J2t5i39j9btklP0Qp7lKPNwpkZtHDIsNaGDaYrLOQ4=;
        b=b25hT+1eLt2Kl8VsfzKAqGGlRoHMLljFZuicg0p0jmr7FL3+mFJY9hzXXeFU5fbAQG
         eMH37deJIEINKYW1TP7+WIWbemthThLfWOu1FKgTngvZxAmh2+x7gB+7X4tAsHn67v3a
         CyAv4VFN/8YNYvk+k5Tu9SAKKD82xwq1EIrS7iVhdJMGVRNmJcsj5vFRuwwfOSGPgnqD
         Mf5mc65vmEGd2elTQkpVKghT2OEFNeKBzrVtt6Jp93GGTxXVge1ircsp//2vi8w/+9H8
         7UsllNetfZRndMNhdLE9JzZl9GwbooT81JO1HV4FM6fA+DI3FVxGgL7KCAfOZzvUePmj
         kDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173358; x=1778778158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J2t5i39j9btklP0Qp7lKPNwpkZtHDIsNaGDaYrLOQ4=;
        b=tKvucGuHQXHSnC9YGpPvw4U6LM2VM4ZtMFV/OxnwvPOGV0fhhN8sT9nIqoy2f99+/6
         yUxZZApUk77Ef0z+ujIdHRE4oAnvgrB14lweOEhtQ9PWxqMHzBkrfdTK1eGd5c3AtU3v
         a0gbjaS9r2qKNgtUz8PZGctD2RaPNJL7CJsU3z65R6vZP+G3cspyB/o7T28THnjSz+wN
         AymIFzgpHQuXugxrX+5DAF2xp14a6BoGuiSjkEvjRHp90PW61/lG7FUCmElSUb0pNWhE
         gVjNRGnF3qXX2T1lBizVY7ZVLhFDbil0FO3yJlsUmu8i1ycrp3MfDzrvqAPVtD/qJ3mL
         6Ocw==
X-Gm-Message-State: AOJu0YxXp0ePariu0FUBPyPNID+DWO7D6T/M4ioYw/RCQo0CABIIjU+n
	uY9LKc8fC+pWxIEyG0KsxzhWi6l/l6t9+qrctNW3deqUDPYXuLHV11nXQteu02bKRnpW6uMLZ8+
	8VCnLcuJ2+xS8aSiTCkKE8GzE/220CVe+rXb6dDE=
X-Gm-Gg: AeBDieszyCXO4iNgsASAl6+ZwHlsdCIx1tsI9PN1DQeInf1S1iCPb+DvcQsYWJVmEjQ
	k6pWLfBXU69h2AxZJrPfL5Q5iNPnM0yQCHF//Jr0MpeFXpYpiC5chp/w8B5JBgDzsoRrnM49/QE
	KzJHmNfC3WsCG0NKGHJmwkm61xnixWveXrV75lkYX5SxMBzREf6Utw1j5TnjymYmrSuPfPKQi05
	4MEo6w1+IP3NTag5BdK1auGQZKO1unmVPaDa9bqzvYg7jpdptqxarigr2ofYSS+eJJBiYlqTb2H
	dCTTJzQfAThfI8cqQA==
X-Received: by 2002:a17:907:9303:b0:bc3:cb5c:5516 with SMTP id
 a640c23a62f3a-bc56b028ed9mr496191166b.11.1778173357410; Thu, 07 May 2026
 10:02:37 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Bojan_Janjatovi=C4=87?= <bojan.janjatovic@gmail.com>
Date: Thu, 7 May 2026 19:02:24 +0200
X-Gm-Features: AVHnY4KmXU8FCHFv7L4hK-1bX9Ua6ifMVEXpOUMtfiAIqsdUofSlDtmg0BOwO1Y
Message-ID: 
 <CAA-EO1fe_YusfgLNhjyry4ybjnUuSjd6cVgXahnjWYepvvcjQA@mail.gmail.com>
Subject: [PATCH] conf: fix snd_func_imul accumulator initialization
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: bojan.janjatovic@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VNMUEOEPUZDOIHSSR7UACGMGCDBSCYXJ
X-Message-ID-Hash: VNMUEOEPUZDOIHSSR7UACGMGCDBSCYXJ
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:13 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VNMUEOEPUZDOIHSSR7UACGMGCDBSCYXJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_func_iops() initialized result to 0 for both iadd and imul. For
imul this made every multiplication step multiply by 0, so
snd_func_imul() returned 0 for every input since it was added in
aa7a0dd7 (2006-10-11). The doxygen example for imul therefore did not
match observed behavior.

Initialize the accumulator to 1 for imul and keep the empty integers
list result as 0. Add table-driven config tests covering iadd and imul
single, multi, zero, negative, empty, and out-of-order integer lists.

Fixes: https://github.com/alsa-project/alsa-lib/issues/456
Signed-off-by: Bojan Janjatovi=C4=87 <bojan.janjatovic@gmail.com>
---
This is my first ALSA patch submission, so please let me know if I
should adjust the format or routing.

 src/confmisc.c    |  8 +++++-
 test/lsb/config.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index c1f5410c..4acc3cd6 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -488,7 +488,7 @@ static int snd_func_iops(snd_config_t **dst,
  snd_config_iterator_t i, next;
  const char *id;
  char *res =3D NULL;
- long result =3D 0, val;
+ long result =3D op =3D=3D 1 ? 1 : 0, val;
  int idx =3D 0, err, hit;

  err =3D snd_config_search(src, "integers", &n);
@@ -531,6 +531,9 @@ static int snd_func_iops(snd_config_t **dst,
  }
  }
  } while (hit);
+ /* Preserve pre-fix behavior for an empty integers list. */
+ if (op =3D=3D 1 && idx =3D=3D 0)
+ result =3D 0;
  err =3D snd_config_get_id(src, &id);
  if (err >=3D 0)
  err =3D snd_config_imake_integer(dst, id, result);
@@ -582,6 +585,9 @@ SND_DLSYM_BUILD_VERSION(snd_func_iadd,
SND_CONFIG_DLSYM_VERSION_EVALUATE);
  integers [ 2 3 2 ]
  }
 \endcode
+ *
+ * \note An empty \c integers list yields 0 (not the multiplicative
+ *       identity 1) for backward compatibility.
  */
 int snd_func_imul(snd_config_t **dst, snd_config_t *root,
    snd_config_t *src, snd_config_t *private_data)
diff --git a/test/lsb/config.c b/test/lsb/config.c
index e8699f13..9906c355 100644
--- a/test/lsb/config.c
+++ b/test/lsb/config.c
@@ -548,6 +548,74 @@ static void test_for_each(void)
  ALSA_CHECK(snd_config_delete(c));
 }

+static void test_evaluate_integer_functions(void)
+{
+ const char *text =3D
+ "sum {\n"
+ " @func iadd\n"
+ " integers [ 2 3 5 ]\n"
+ "}\n"
+ "product {\n"
+ " @func imul\n"
+ " integers [ 2 4 6 ]\n"
+ "}\n"
+ "single {\n"
+ " @func imul\n"
+ " integers [ 7 ]\n"
+ "}\n"
+ "with_zero {\n"
+ " @func imul\n"
+ " integers [ 2 0 5 ]\n"
+ "}\n"
+ "negative {\n"
+ " @func imul\n"
+ " integers [ -2 3 ]\n"
+ "}\n"
+ "empty {\n"
+ " @func imul\n"
+ " integers [ ]\n"
+ "}\n"
+ "out_of_order {\n"
+ " @func imul\n"
+ " integers {\n"
+ " 2 =3D 5\n"
+ " 0 =3D 2\n"
+ " 1 =3D 3\n"
+ " }\n"
+ "}\n";
+ struct {
+ const char *id;
+ long result;
+ } *p, expected[] =3D {
+ { .id =3D "sum", .result =3D 10 },
+ { .id =3D "product", .result =3D 48 },
+ { .id =3D "single", .result =3D 7 },
+ { .id =3D "with_zero", .result =3D 0 },
+ { .id =3D "negative", .result =3D -6 },
+ { .id =3D "empty", .result =3D 0 },
+ { .id =3D "out_of_order", .result =3D 30 },
+ { .id =3D NULL, .result =3D 0 },
+ };
+ snd_config_t *top, *node;
+ snd_input_t *input;
+ long value;
+
+ ALSA_CHECK(snd_input_buffer_open(&input, text, strlen(text)));
+ ALSA_CHECK(snd_config_top(&top));
+ ALSA_CHECK(snd_config_load(top, input));
+ ALSA_CHECK(snd_input_close(input));
+ ALSA_CHECK(snd_config_evaluate(top, top, NULL, NULL));
+
+ for (p =3D expected; p->id; p++) {
+ ALSA_CHECK(snd_config_search(top, p->id, &node));
+ TEST_CHECK(snd_config_get_type(node) =3D=3D SND_CONFIG_TYPE_INTEGER);
+ ALSA_CHECK(snd_config_get_integer(node, &value));
+ TEST_CHECK(value =3D=3D p->result);
+ }
+
+ ALSA_CHECK(snd_config_delete(top));
+}
+
 static int _expand_fcn(snd_config_t **dst, const char *s, void
*private_data ATTRIBUTE_UNUSED)
 {
  if (strcmp(s, "var10") =3D=3D 0)
@@ -644,6 +712,7 @@ int main(void)
  test_get_ascii();
  test_iterators();
  test_for_each();
+ test_evaluate_integer_functions();
  test_evaluate_string();
  test_load_string();
  return TEST_EXIT_CODE();
--=20
2.54.0
