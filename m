Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226CCEF8FEE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:19:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83BE060246;
	Wed,  4 Mar 2026 16:18:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83BE060246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772637542;
	bh=4UgYcnM3LM0RK4nnYia2SepSbLw5kHZxkM8pfW9coGo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lKqshGV00NaoSQ7Yp89+6tP7ptUXq+Sa+pZYoUj/1ER9TspSFHWghaKwlj37+ynTV
	 CoIooOAfYjeqR+5AbyatDsGPdRqeuZssfgwiQujUSPiuV3Ok9YMQ1wraXn74EIB/cR
	 2e28rGCzO0x6+y5MlvKGEMqTltsCs+x2VDVf6qhU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A363F8064C; Wed,  4 Mar 2026 16:18:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3830F80642;
	Wed,  4 Mar 2026 16:18:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F5A5F8055A; Thu, 12 Feb 2026 04:56:15 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 51050F800BD
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2026 04:56:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51050F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=VeE9pVOG
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-6726f320b4fso1814201eaf.2
        for <alsa-devel@alsa-project.org>;
 Wed, 11 Feb 2026 19:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770868571; cv=none;
        d=google.com; s=arc-20240605;
        b=PAp+kDPO/S9CclUS5FPjSEx0B1BuLgRXXw4c+nY7YMnnPswMS4+9P5y2ZUhfF1giVW
         b/wquH8ayV5UKGtLqAYhiXAyb+zn4hzdoaIzGwyWNPVfSLMYQA6wxWkuG+fSX0lAtvZM
         AiNpu9vBk483i2roNhzQincESz1zDF00mvWs8pu8ZFc8BRX/QT78lUNZ9/aYoCRojj8G
         SE5vVdCbLndMFQVl2vibzEu/Vyc9YpTZfh3M4YjPqF/XjdnSHoh/yV+122/Ur4IUneM2
         1TP9X7sZPaCIQy+LdwQF44jO2GHCLXlaVTlv7SbZrR6XoTKYTHf2HvnHISKrDrbUSZAA
         ls2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nX/AIDWxId2ArPtKXChiYuakzcwlqlVNpIfP7UhsoNE=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=KUcPDb7r84CoIGQWqzG+qde9vGfhVQgWgXdlxND+fNBMAp/ETQhrzdx2fewuqitkNA
         uqbA0N2T1k7kHeEtzkRDGL8Nn8xINP3yp6z9qn4N60A4vfYUhK2c8VC1Ct62YN5G3ZtU
         uQVlMtwU43XznxgibKVgsAZLG93TukeG6lyOqM8/LOx68YuxRdUz0Y37yagOdf4mT+tS
         RvySFXFgxKujAv4Dwicwn5/gnQ6ICokZn+BIfwQqVNaOLScpnPzI1HTRl+o9dQCcRKA/
         fEljbGwcHDwDYQsosU0WRhzMoTXOf5gEFQQYlV7vKRCnfonZd00rSy4s69eJh7CQTJnB
         hVzQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770868571; x=1771473371;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nX/AIDWxId2ArPtKXChiYuakzcwlqlVNpIfP7UhsoNE=;
        b=VeE9pVOGV5oc/SMd8W0yaf91W8+7r+rbxsMHRj7hqIC5+NNcDhthaXEFDv1l4YUGaO
         SJmv+n8cZuW9lb/Oi2D2cXkDsNzcWh/pvcYZiHEuHBxz9q3yLhEkNW4GIMjPfJvtCirL
         acqx0nqmbdfeXxqWohDqqfHen+dwv6/INxK3g2YMwGSUIAkAn2WZq3YGM0igk6V5610O
         w23B6k2gosti255n+yS5rUde/IDqwBUf/w9c8JJ+L2Lwu/3/qy58K4fzf0QHuwRbJGbt
         RVB7QZYBBeA5w6LTv3+5Y9ulKkm+eMimNLo2Vlm2mXykuuGTSZBfK+SztVYy8jqHi/G0
         YZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770868571; x=1771473371;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX/AIDWxId2ArPtKXChiYuakzcwlqlVNpIfP7UhsoNE=;
        b=Dg5OKbDOdjGrL0VCdn45qQpzzMXbtjQfXWRFmL88UhRqH32MZKg89Xa46iv2o5j2MV
         239NhONLyZ+h6pnf2Uhih06ME0UTviF4cHsR+/EFiKwWIL7ondx2L5hjoUnYdaIEc7zF
         /q81Kk0G+wm+qBaeVY5ZjjycVaDzPXWK8Lt8BJb+EeOTY4mdISvSO6ANrXtCOzYu2OWr
         hQC2Ur4XMgQ9+/ElejtamXYW2yYvLmOm3zJcADnJxv5dOazb3rfLG4lafG0jTBaReMw7
         Y8nQo9GrNuzyjUlh9FXYRJ7NI/YtD/kiZ/cHa1hKFQHRLhunEZFlXgqgOmlicIMYheFc
         Ik2w==
X-Gm-Message-State: AOJu0YwNsBPXVtMMNSKhkpn5jpGyfoC3tOL8fpxAQM8nDAoAU+mD5aOv
	gCEQ7pe2v3+MkoDleGuGt0u+Nds+c8Gtsa5eU170qw7XvQMg28cT+8EQuZ6nWxZ8kCbRt8WUD49
	XszRdH8TUMciR6RBG0SiGmReZsIUDfbr2QQtlPK8=
X-Gm-Gg: AZuq6aJOsRQ/S/op+whHfZujjz3N7E7M64mmLVNe6TRHth92yqD+nYHhZn52LRFUPbW
	cc9VpcWoz8kc7iKN9JrnyN6qmQp05/bQNxwqyTOurOMXlSz6QoFzcWo2pwCJ1MiuOrJEh0UPqLE
	BJs9PFFycaBYMvqvixZ/wgz5F2OH9ggTR2Mp9gUYbH8Y+b1xGlRGuZavldCI625XrdQrqAZFRTp
	H/ddkmEwiPMOCHNen9Q8dY2HNn0DqBJYsqsT3pZ0l++SzfA2NEC/5PZqcOLLwazNImgPGEw1afb
	F1jKvoo=
X-Received: by 2002:a05:6820:160a:b0:663:f65:1c84 with SMTP id
 006d021491bc7-6759a55739emr788473eaf.54.1770868570795; Wed, 11 Feb 2026
 19:56:10 -0800 (PST)
MIME-Version: 1.0
From: Dmitriy Kazakov <dmitriy.kazakov.da@gmail.com>
Date: Thu, 12 Feb 2026 06:56:00 +0300
X-Gm-Features: AZwV_Qh5-jta1ZV78MHErGD96N7kIrPofA28Aqu7NoCuMybPoJ_lyPkoaWlUU9Q
Message-ID: 
 <CAG7i1jq4Z5RtogsfLR+_qb06p6cJ=2zrjM=0VowXpYg7ktd7cg@mail.gmail.com>
Subject: Lenovo Legion 7 pro: sound issues on this series of laptops
To: alsa-devel@alsa-project.org
X-MailFrom: dmitriy.kazakov.da@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: KKI7HULYWJHOO2QYXNMYO6MU2KLNEKDD
X-Message-ID-Hash: KKI7HULYWJHOO2QYXNMYO6MU2KLNEKDD
X-Mailman-Approved-At: Wed, 04 Mar 2026 15:18:02 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKI7HULYWJHOO2QYXNMYO6MU2KLNEKDD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8gQWxzYSBkZXYgdGVhbSwNCg0KSSBleHBlcmllbmNlZCBzb3VuZCBpc3N1ZXMgb24gbXkg
bmV3IExlbm92byBMZWdpb24gNyBwcm8gbGFwdG9wIG9uIFVidW50dQ0KMjQuMDQuIFRoZSBzb3Vu
ZCBpcyBxdWlldCBhbmQgbmFycm93ZWQgZG93bi4gUmVzZWFyY2ggc2hvd3MgaXQgaXMgYQ0KY29t
bW9uIGlzc3VlIGZvciB0aGlzIHNlcmlhIG9mIGxhcHRvcHMuDQoNCmh0dHBzOi8vYnVnemlsbGEu
a2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIwMjU5DQoNClRoZXJlIGlzIGFsc28gYSBwYXRj
aCBmb3IgdGhpcw0KaHR0cHM6Ly9naXRodWIuY29tL25hZGlta29iZWlzc2kvMTZpYXgxMGgtbGlu
dXgtc291bmQtc2FnYT91dG1fc291cmNlPWNoYXRncHQuY29tDQoNCg0KUGxlYXNlIGFkb3B0IGl0
IGludG8gdGhlIGtlcm5lbCBhbmQgdmVyaWZ5IHBvdGVudGlhbCBidWdzIHNpbWlsYXIgdG8gaXQu
DQoNClRoYW5rIHlvdS4NCg0KLS0gDQpLaW5kIHJlZ2FyZHMsDQpEbWl0cnkgS2F6YWtvdiA8aHR0
cDovL3d3dy5saW5rZWRpbi5jb20vcHViL2RtaXRyeS1rYXpha292LzI2LzYxOC85Nzk+Lg0KPGh0
dHA6Ly93d3cubGlua2VkaW4uY29tL3B1Yi9kbWl0cnkta2F6YWtvdi8yNi82MTgvOTc5Pg0K
