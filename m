Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E5BCA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:06:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00B2660228;
	Tue, 29 Sep 2026 21:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00B2660228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708811;
	bh=60/3A6q4v0Q8ceXaO2SbBnNMROheMZxFlgmsLdNSojk=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Y6m5AIKLbTlfus4TDRMG5Phs3PYs1tGlqRuq7U9uyCbLaQGy5JDqgBoQhVbM+5pud
	 Tc0VxFDvVUCWCVXkfdBg7hLR/0SAhxVX8kkLPmjjEAdCvB+R8ekKWlXhmLEEINvozq
	 Hr+/ySKmHs4TOoUWCFDXLGVLI/Te0h2G8SfrILmc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEAB3F806D0; Tue, 29 Sep 2026 21:05:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D76EF806C0;
	Tue, 29 Sep 2026 21:05:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53F5DF804F3; Mon, 21 Sep 2026 19:22:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.169
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790011338;
	b=l6xeVkujm+NMerIMcgz8g/DMVhNqu4FnHYh4LpKSY1R1qfpa2mP494foNvVImt7FxYGM
	 brocJ2Lh9IBcQ7XqnO0mRaHV/Eou4FYiRsiUey9YRbn7vdIgudy5JTZci5gNw+deHoRzF
	 FW/YXN+yzGGuvNYqJ8xYD2HDSfGbjUEOulJWrA2iAD+NVBiIbaYY1eEcobEBK/WaYMYQY
	 toGIwkPGSCByjtmXGLqm+AS2yDxthflwV+ONVU1WrzV1bOMDM1l6C/0ExqdChfuE/D8zx
	 +WcAhKzw7TgQPnH+Ne7aC9p1pE5HnDqycOckIi0HXu0sqVnxgQkbeGMZgVxlFwco1pQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790011338;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=aCxdr05lijQY68M5xs6cAMY7rPbetU83QuPbii1ZTeQ=;
	b=dY+g33zClWIEaLUfRj4zYt1MBN/rYts6Bw30y1iO3DU2h/nBH5HzbspC0oqT3HCsYBpv
	 b1zCm0eZzWGf6HjevuL0/wv9baN7wLl7HSUH+IY9nn+QNRojN5uiJ3jWUbU4h82M/xFET
	 YDzCc88EL5nvGMTrmni59PkbdD4Sx/IxSQqoC/I98cU41EWsyUb5ihZhcqOvt5JeK7s1Y
	 JIVntfn00oIIdSxg1nJL6JgBrNaagqfZxJfs/nmLZ87KJ1Ocqiqtlls98dpUZYJgk+ihu
	 sT9VUO9HguGOH2KQS/rAP78HgazYtzRHfSspuPvZqSGLI/NZNGGg1qkWe3Q81fxsVZQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=vulncheck.com header.i=@vulncheck.com header.a=rsa-sha256
 header.s=google header.b=mZXrBCVL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.169
Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com
 [74.125.231.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26C08F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 19:22:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26C08F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=vulncheck.com header.i=@vulncheck.com
 header.a=rsa-sha256 header.s=google header.b=mZXrBCVL
Received: by mail-oo2-f41.google.com with SMTP id
 006d021491bc7-6d13d47b7caso194134eaf.0
        for <alsa-devel@alsa-project.org>;
 Mon, 21 Sep 2026 10:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790011335; cv=none;
        d=google.com; s=arc-20260327;
        b=Ly7Yvmo+oGLnetxxLvb3epMMeJ2IvOJVurDtQFGRbi6utXW8CRf+ySYBGaTvvAXcYL
         eOV7bJXRNbvtAdkx+2q5xlH+j60cMr2IFHcIzQMRiM2tKksg/hYMgJyYM5QpOK97ggLe
         dLJKmsnk7YkmzovIHFEnfkm3Gqaj577r29zwqw2bAMTloIQ65IltyH3PRwLW2FmrUkpJ
         PKpre5Zfl7hgFsnqKxO/jcP6on5VqDK4C5gGJMLs00vbJrD4pfkGpnclojGYRU5NyRhm
         J+7sDC++LYXA7egXqolJMVTsGrvhXfq1iM9GIQAyQX3f/QXjeT4qTcXVcKn1G4a5NGbl
         8QYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3pVyuJEmZZOcpPoDhWL1eFnOc9YvY0EEZ/EBzzFK8lw=;
        fh=0mKO+nZ7sxNzPmF3fuSb2WVqZFVM/tTv2IrB7cCiAxY=;
        b=lJ1uIWQcsT7LC/BsuzsonAJnLU8ZOW5zmGnh4FZtzRontiRa5MPeRGWSHX9lLeJD5H
         LmdZ8UEOa222JCLFUF6L+0vHm1PDgKTd8o6SRNU7/gDcckQhVnNhh9Mw/K7DDqKs2uI0
         Yq1Z9xuQOrRB1C0wNCIoiIUcekDQi2LSBOwSZhWbZXv/GSKd5/dachhsYZu4sfVsgdTP
         27D0Zi2p07ubqmv3mjBFuAt7YSPWhIk+br8iRYG3x9JlRUAh2YGcGduUG79ozngREEd+
         JUoh+73ZZFVww9wlJ8wAkKtnhlMAv3Qt+uVujWDYMi7lPEgA6WRh2EUvGEVZcfNqA+cF
         fHtA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vulncheck.com; s=google; t=1790011335; x=1790616135;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3pVyuJEmZZOcpPoDhWL1eFnOc9YvY0EEZ/EBzzFK8lw=;
        b=mZXrBCVLslgVJzMzZyFpt7SSSDHGsTj/bC23KorzuoMWR/OatKnvEq5OUWL/xnpi96
         LX1iHokrMTr+r+HSeC4YRYUKkR+N0tXrwQ8N5gbzO/B/zI7893UBsEii0DxWfLAf3rkR
         zJH9J3USQXfkr4cSnpik7VwWM+r1y4SJoLLmoR4IvNXRq0FOy9qtrjPVXdgNsag7QXy3
         QHMHF0RXVm/vZ5ebPnLHv1M5PezrvRYhLH+Rd7OpGtDAEw4h/UIt1AYtK4c3orDaAjuY
         8FUfyxsenKP+FVYpQce8ZYn/uRGzZ0qLdtG0Fs8/B/wXevBVNbOb6q6zeECUy/clYEpX
         RzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011335; x=1790616135;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pVyuJEmZZOcpPoDhWL1eFnOc9YvY0EEZ/EBzzFK8lw=;
        b=0kV7t8B3dIQJcpmeQ8IH2D+ZHF0lRDK7YTn/aLEDnH7iouEn1nvjnYgSkU/+KfiEyb
         lMd6j3iGb6lAyzi+vKhXqWi3K0t2HXbEk5kqh0aP3PbOKpdv7ht/rigohOnBKg2GE46q
         GpHAaqVbvLhJS10HmXxpAIJlte+ziAp2g9Lyqc2G217Z4LOe2/u9HFyPZzaLqya7lj98
         Uk0ZatlYeAAd7et47M/qtgZD2o+WjIIcQZgx7vK9udKn4igEroEwJQUSIvPnpO4EaMX/
         E15jSonq1Wr7Djyx8e1TV5j1xBC35/6FsYzoqO5Z4cF9r8pN/ihun3WLMP5iRr1euLfj
         Pqng==
X-Gm-Message-State: AFuF++mgxgRVC5XXK2Ri/7rKpfL4p+tsvEEyZvMyUWYSfAJSd8MqBwGC
	mswUCemVS1xGln25CH3W1YgzcFIuoiGtafkp567d+COwDKYsoSd3/vvw7s5IqzSU9FuMZzTOYpt
	dIZEKhTtJJ6VsnvaBc5jkH3pmVEJfh3R+zY89xTihd+kQFzPrnNGDPcTgoIu8
X-Gm-Gg: AYBFou3A6Z8wuy0O49nIJe7DKZ0U6akwM1//W7oUG9ELC/7OuXYxhSxsVX8cLHd5mfD
	zXFgBEJyrffyx81hTbUeOJpu7psKt5jeExDTCgAF3hdr2YpdHHI15N+TlDllfp1tJB+Uh1EKSk5
	sG4+GhyouSFtrXiJ1UgRK/x1EXvXvSYH3vU7BJGD+67CZSW5GubFAxSeUEq0iKgOx+FNgDqJZk9
	GTjwIdoCY5PZhZOgxAwqF+l4Lj8XD+7GKal40F62m1hGRp1TSZxQZc8+5tnYdksaArZWwV4G3r7
	vjtBzTMHcjER6wjFegIxwYh390YOFVYhn3SzcU3mKSLLCCGUQqi2
X-Received: by 2002:a05:6820:208a:b0:6b7:8415:d780 with SMTP id
 006d021491bc7-6ca9c056f44mr11650767eaf.43.1790011334852; Mon, 21 Sep 2026
 10:22:14 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Tarr <btarr@vulncheck.com>
Date: Mon, 21 Sep 2026 13:22:03 -0400
X-Gm-Features: AcwNN1VwDv6yT5_MipCg_fCAJ8wenjF-BQJCYrH0xOMjMUAaEE75M1WaGHjLLBI
Message-ID: 
 <CAOH03+3bBSMrvVdxH5qQB8nvnejJAtnS3gnH4b5mO2fPugeZuw@mail.gmail.com>
Subject: Coordinated Vulnerability Disclosure - ALSA Project / tinycompress
To: alsa-devel@alsa-project.org, Disclosures <disclosure@vulncheck.com>
Content-Type: multipart/mixed; boundary="000000000000c253e0065c017d9c"
X-MailFrom: btarr@vulncheck.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: S2JUTMZX3W5ZZQ6ENUTMJRVWOHS4P5EQ
X-Message-ID-Hash: S2JUTMZX3W5ZZQ6ENUTMJRVWOHS4P5EQ
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:43 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2JUTMZX3W5ZZQ6ENUTMJRVWOHS4P5EQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--000000000000c253e0065c017d9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings ALSA Security Team,


I'm a vulnerability analyst at VulnCheck <https://www.vulncheck.com/> an
exploit intelligence company and research CVE Numbering Authority (CNA),
where I'm one of several folks who manage our coordinated vulnerability
disclosure (CVD) program.

An external security researcher recently reported
<https://www.vulncheck.com/advisories/report> a potential vulnerability
impacting ALSA Project / tinycompress
<https://github.com/alsa-project/tinycompress> and VulnCheck is acting as
the intermediary and coordinator.

VulnCheck follows a 120-day disclosure policy
<https://www.vulncheck.com/vulnerability-disclosure-policy>, meaning we
afford vendors/maintainers up to 120 days from the time of receiving the
report to address the issue before publication of a CVE record and
third-party advisory. For this vulnerability, that 120-day deadline falls
on *January 19, 2027 (01/19/2027)*. Of note, patch publication constitutes
public disclosure =E2=80=94 if a patch is issued, we will publish the CVE r=
ecord at
that time rather than waiting for the full 120-day window.

The researcher has provided us with a comprehensive technical report, which
we have attached to this email. Let us know if you have any questions for
us about the CVD process or for the researcher regarding the reported
vulnerability.

--=20
Thank you,

<https://www.vulncheck.com/>

Brandon Tarr
VulnCheck

--000000000000c253e0065c017d9c
Content-Type: text/markdown; charset="US-ASCII";
 name="tinycompress-vulnerability-report.md"
Content-Disposition: attachment;
	filename="tinycompress-vulnerability-report.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mubifrpz0>
X-Attachment-Id: f_mubifrpz0

IyBPdXQtb2YtQm91bmRzIFJlYWQgaW4gU09GIFByb2JlIFBhY2tldCBQYXJzZXIKKipQYWNrYWdl
OioqIGFsc2EtcHJvamVjdC90aW55Y29tcHJlc3MKKipUZXN0ZWQgVmVyc2lvbnM6KiogdjEuMi4x
NiAoY29tbWl0IDZkMzlmMDIwYmRjNGFmOWRjNTg2YjQ4Y2VjZmVkM2MyYTRlMjM1ZWEsIGFsc28g
Y3VycmVudCBtYXN0ZXIgSEVBRCkKLS0tCiMjIEFmZmVjdGVkIEZpbGVzCnNyYy91dGlscy9zb2Zw
cm9iZWNsaWVudC9wcm9iZXNfZGVtdXguYyAodmFsaWRhdGVfZGF0YV9wYWNrZXQsIGFyb3VuZCBs
aW5lIDI0NykKLS0tCiMjIFJvb3QgQ2F1c2UKZGF0YV9zaXplX2J5dGVzICh1aW50MzJfdCwgdGFr
ZW4gZnJvbSB0aGUgcHJvYmUgc3RyZWFtKSBpcyBuZXZlciBjYXBwZWQgYWZ0ZXIgdGhlIGluaXRp
YWwgNDA5NiBieXRlIGFsbG9jYXRpb24uIHZhbGlkYXRlX2RhdGFfcGFja2V0KCkgY29tcHV0ZXMg
Y2hlY2tzdW1wID0gKHVpbnQ2NF90KikocGFja2V0LT5kYXRhICsgcGFja2V0LT5kYXRhX3NpemVf
Ynl0ZXMpIGFuZCBkZXJlZmVyZW5jZXMgaXQuIHRvdGFsX2RhdGFfdG9fY29weSBpcyBpdHNlbGYg
YSB1aW50MzJfdCwgc28gZGF0YV9zaXplX2J5dGVzICsgc2l6ZW9mKHVpbnQ2NF90KSB0cnVuY2F0
ZXMgaW4gMzIgYml0cyBvbiBldmVyeSBwbGF0Zm9ybSwgbWVhbmluZyBhIGh1Z2UgZGF0YV9zaXpl
X2J5dGVzIHlpZWxkcyBhIHNtYWxsIHRvdGFsX2RhdGFfdG9fY29weSBhbmQgdGhlIHJlYWxsb2Mg
cGF0aCB0aGF0IHdvdWxkIG90aGVyd2lzZSBncm93IHRoZSBidWZmZXIgaXMgbmV2ZXIgdGFrZW4u
IFRoZSBzdWJzZXF1ZW50IGNoZWNrc3VtIHJlYWQgdGhlbiBsYW5kcyBvdXRzaWRlIHRoZSBhbGxv
Y2F0ZWQgcGFja2V0IGJ1ZmZlci4KLS0tCiMjIFBvQwpGZWVkIHRoZSBwYXJzZXIgYSBwYWNrZXQg
d2l0aCBkYXRhX3NpemVfYnl0ZXMgPSAweEZGRkZGRkZGLiBJbml0aWFsIHBhY2tldF9zaXplIGlz
IDQwOTYgYW5kIHJlbWFpbnMgdW5jaGFuZ2VkIGFmdGVyIHBhcnNpbmcuCkNvbmZpcm1lZCBvdXRw
dXQ6CkFkZHJlc3NTYW5pdGl6ZXI6IFNFR1YgKFJFQUQpIC4uLiBwcm9iZXNfZGVtdXguYzoyNDcg
aW4gdmFsaWRhdGVfZGF0YV9wYWNrZXQuCi0tLQojIyBJbXBhY3QKQW4gYXR0YWNrZXIgd2hvIGNv
bnRyb2xzIHRoZSBTT0YgRFNQIHByb2JlIHN0cmVhbSAodGhlIGZpcm13YXJlL2tlcm5lbCBwYXRo
IGZlZWRpbmcgc29mcHJvYmVjbGllbnQsIG9yIGEgdGVzdCBoYXJuZXNzIHNlbmRpbmcgY3JhZnRl
ZCBwYWNrZXRzKSBjYW4gY3Jhc2ggdGhlIHVzZXJzcGFjZSBwcm9iZSBjbGllbnQgd2l0aCBhIHNp
bmdsZSBtYWxmb3JtZWQgcGFja2V0LCBjYXVzaW5nIGEgZGVuaWFsIG9mIHNlcnZpY2UuIFRoaXMg
aXMgbm90IHJlYWNoYWJsZSBieSBhbiB1bnByaXZpbGVnZWQgZmlsZSBvciBuZXR3b3JrIGF0dGFj
a2VyIGluIG5vcm1hbCB1c2U7IGl0IHJlcXVpcmVzIHRoZSBhYmlsaXR5IHRvIGluamVjdCBkYXRh
IGludG8gdGhlIHByb2JlIHN0cmVhbS4KLS0tCiMjIFN1Z2dlc3RlZCBSZW1lZGlhdGlvbgpDYXAg
ZGF0YV9zaXplX2J5dGVzIHRvIGEgc2FuZSBtYXhpbXVtIGFuZCByZWplY3Qgb3ZlcnNpemVkIHBh
Y2tldHMgYmVmb3JlIHVzZS4gTWFrZSB0b3RhbF9kYXRhX3RvX2NvcHkgYSBzaXplX3QgYW5kIHBl
cmZvcm0gYSBjaGVja2VkIGFkZGl0aW9uIGluc3RlYWQgb2YgcmVseWluZyBvbiB1aW50MzJfdCBh
cml0aG1ldGljLgoKLS0tCgojIE5VTEwgUG9pbnRlciBEZXJlZmVyZW5jZSBvbiBGYWlsZWQgQ29t
cHJlc3MgRGV2aWNlIE9wZW4KKipQYWNrYWdlOioqIGFsc2EtcHJvamVjdC90aW55Y29tcHJlc3MK
KipUZXN0ZWQgVmVyc2lvbnM6KiogdjEuMi4xNiAoY29tbWl0IDZkMzlmMDIwYmRjNGFmOWRjNTg2
YjQ4Y2VjZmVkM2MyYTRlMjM1ZWEsIGFsc28gY3VycmVudCBtYXN0ZXIgSEVBRCkKLS0tCiMjIEFm
ZmVjdGVkIEZpbGVzCnNyYy9saWIvY29tcHJlc3MuYyAoY29tcHJlc3NfZ2V0X2Vycm9yLCBsaW5l
IDgxOyBjb21wcmVzc19jbG9zZSwgbGluZSAxOTQpCi0tLQojIyBSb290IENhdXNlCmNvbXByZXNz
X2dldF9lcnJvcigpIGFuZCBjb21wcmVzc19jbG9zZSgpIGRlcmVmZXJlbmNlIHRoZSBjb21wcmVz
cyBwb2ludGVyIHdpdGggbm8gTlVMTCBndWFyZC4gVGhlIGNwbGF5LCBjcmVjb3JkLCBhbmQgZmNw
bGF5IHV0aWxpdGllcyBjYWxsIGNvbXByZXNzX2dldF9lcnJvcihjb21wcmVzcykgaW5zaWRlIHRo
ZWlyIG93biBlcnJvciBicmFuY2ggKGlmICghY29tcHJlc3MgfHwgLi4uKSksIHNvIGEgZmFpbGVk
IGRldmljZSBvcGVuIGxlYWRzIGRpcmVjdGx5IGludG8gdGhlIHVuZ3VhcmRlZCBkZXJlZmVyZW5j
ZS4KLS0tCiMjIFBvQwpDYWxsIGNvbXByZXNzX2dldF9lcnJvcihOVUxMKS4KQ29uZmlybWVkIG91
dHB1dDoKQWRkcmVzc1Nhbml0aXplcjogU0VHViBvbiBhZGRyZXNzIDB4MCAuLi4gY29tcHJlc3Mu
Yzo4MS4KLS0tCiMjIEltcGFjdApBbnkgZmFpbGVkIGNvbXByZXNzIGRldmljZSBvcGVuIChkZXZp
Y2UgYnVzeSwgYWJzZW50LCBvciBpbnZhbGlkIGNhcmQvZGV2aWNlIG51bWJlcikgY2F1c2VzIHRo
ZSBjYWxsaW5nIHV0aWxpdHkgdG8gY3Jhc2ggd2hpbGUgdHJ5aW5nIHRvIHJlcG9ydCB0aGUgZXJy
b3IsIHJhdGhlciB0aGFuIGV4aXRpbmcgY2xlYW5seS4gVGhpcyBpcyB0cml2aWFsbHkgcmVhY2hl
ZCBpbiBub3JtYWwgb3BlcmF0aW9uIGFuZCByZXN1bHRzIGluIGEgZGVuaWFsIG9mIHNlcnZpY2Ug
b2YgdGhlIGNhbGxpbmcgcHJvY2VzczsgaXQgZG9lcyBub3QgZXhwb3NlIG1lbW9yeSBjb250ZW50
cyBvciBhbGxvdyBjb2RlIGV4ZWN1dGlvbi4KLS0tCiMjIFN1Z2dlc3RlZCBSZW1lZGlhdGlvbgpB
ZGQgYSBOVUxMIGd1YXJkIGZvciBjb21wcmVzcyBpbnNpZGUgY29tcHJlc3NfZ2V0X2Vycm9yKCkg
YW5kIGNvbXByZXNzX2Nsb3NlKCksIGFuZC9vciBhdm9pZCBjYWxsaW5nIHRoZW0gd2l0aCBhIE5V
TEwgY29tcHJlc3MgcG9pbnRlciBmcm9tIGNwbGF5L2NyZWNvcmQvZmNwbGF5Lgo=
--000000000000c253e0065c017d9c--
