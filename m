Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2B6E98FD2
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:58:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09A4260201;
	Thu,  9 Apr 2026 11:58:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09A4260201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775728705;
	bh=xIN41gGpg5Xwn1HUl0Dy9g0IfzJ6uW50jmb1zIzJfU8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HCyyOAqAQn6yBMNPwZorlUiAeKqxau1yT/VWx9SLinpGHB7zRHogU3faiBVgomR+4
	 OcBIGk6P3ui2QJQ5IKvbG0t1SLGMDJDUsCrW57zTYn1hY2wlzcghPxp7DajVH2iAC0
	 A4sslk6hz/7njO5igR9BNdS93cc2GQGskZRodpEw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F01F8063C; Thu,  9 Apr 2026 11:57:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDC36F80634;
	Thu,  9 Apr 2026 11:57:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54670F80548; Tue,  7 Apr 2026 18:19:31 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D397F80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 18:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D397F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fl8TSj2v
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c56aa62931so10803518eec.0
        for <alsa-devel@alsa-project.org>;
 Tue, 07 Apr 2026 09:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775578767; cv=none;
        d=google.com; s=arc-20240605;
        b=IXAU3Rpn49spN3o+TefF8/c+UILgLzvneX173d92/dxdDs+/dS3FP1DKW2kpyD2/PI
         98la2WavVYVNLJW+qFRLMGJP0nlq/WM4DuaquJUiK1iExzoFRgXjlAQPnu/3E3g/y9xU
         1xFbbKOnZ/FddXB4b16/Icm34KA+4H8cmoNKSUIPLEzamgSd5wDeslfUXlyJPfuXTXw3
         tTUFflIAjymVfx1sKrclEqBcerdeUpIc1205KbdcjnxnoeaYW5ZfQQfrI58iZZZlQdL6
         dsNZy0eeRBx61QflZtf617mFWpZ2RmppwQgiVzJrW78Zn7v1WNgk6j4krdbhHph47DQc
         7NYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TvRSX/U1Dl+pSnnmd1vp2UbkwmM/wjb2AzB0mrVmkMI=;
        fh=QqjXUNd4IbzQn3QNR+WGtAMGAeWCtSo/L31r7Gdtswk=;
        b=fkeMdVW7epNnURmAGVNOiXpgVnnhhD1gJdakR3lztKBy98mv/D7EUMm1R39EPhPoqm
         kToe0aoQ9TtOGrA592CIyZafu2A/BL0D8M/+/265pZAwJTwNXV1pL/LTT3WDPypejyXZ
         sfgB64utomzZgI+x6whNxBRMHJB1n3c4GRrpLIT5cC9xiJTLdnYOHBhkUprB4d+BNjh3
         qM+kOMADK6WRLy16gpMomfQs6aLrm8S2l+rYA1DfKqEztY3B4O9Hi9PoYRMkyv6t6oHb
         bwl7taDfaPLeg6lYaNaVFs/ePeXjo1D+QEE8TTnbTmDKlVpykolM2Te5IgfupATvw8kb
         ptEg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578767; x=1776183567;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TvRSX/U1Dl+pSnnmd1vp2UbkwmM/wjb2AzB0mrVmkMI=;
        b=Fl8TSj2v5P82dV762Ln173KfbcrZjHg4nuGVPzFmAGsEWZLrgT4kq/Iu88g1QtiAe1
         iZ0iO+lByqb75kjDMs4b5nYDgXkvyAD06N9vAx61dCWD4QddFnY3cfr6QhLi0Ft4jI3y
         jYicNanHS8ONqcqHgqa9jmUW0OhQpNWP0EbzlrtwsTgrtvqphnzlqWl2+7u+qWHPqeZ6
         TswrNtbwov4rpRPXvoekJ5hiQHjWrSXO+2rjNascCPb46Kg8Ljj++gonPFmkZuKMggrV
         tUe8eiohbsE0d/cmxOcxU6U/k7Mthjh6BaTHx1YkMkyFsCyhg+59dwhkEPdF1yXjFqaF
         3PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578767; x=1776183567;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvRSX/U1Dl+pSnnmd1vp2UbkwmM/wjb2AzB0mrVmkMI=;
        b=oCXGIbH5Je5BnBiyVZtdHL1YgDuEbLa6BNA871OOPws0JSWg+wGFMFchg+hulC1P1k
         Hbn8gVi+13nNHcu1S5M1bB62JDoa5DRperzkD6DJ+CkSSHWmQuI14SapFcnqeUligegK
         7lc+l8OhWCrELRBQy8Zkk2Ey/wtJvG6DuE+QGmPhzUJh10nbmPm9Z6jQvq+KBWbGdVCH
         fBLCwLW12NyDWdKxNE9JTf2EWzJUeUlyds2frMSdHkJy5I6hLeJNAN3gm6T94LJCOUEZ
         NJZaQu2hutHlEAoWykFugsFK0Q3N/NId0d/8XY347xqtM0GCbq9we+BgCIaw+2IsQGYX
         xAIQ==
X-Gm-Message-State: AOJu0YxXF9Hq505Oe4jJWl5hB0WAI0sMR16/kfC1BZA4y0WLF09lYuyA
	dayu1nFnfwdoFsb4MRqUACq6ujJd/hjby4PWzrc2AaDyJcohC7QgvAsXwhy0foTtLikGeH3+3os
	0xbrMsdMkoaOrPBuDU9UfEoWyEWVV3J5Itq1LIT8=
X-Gm-Gg: AeBDieuykyOYl83D0gzcL3sXNSTViOOLtMtDB2vTdwaFZ89nDMR/AHLAs5YuqUX+SJr
	YmeiuRusYTZFQ+NDTEzUQE4PUWiipUbUbRPc/SwCrVdw8RFjUpeKGsK8LnohWUsjCexZWb1HKZ8
	qydNtEhp1aNRK+YYlY1xqctlAmVdWFCXAWGV7u5eC8lWg1ADDCSocQHYe73Jg6c1OWMMaEDIvsL
	Wg5cO5JcFysUBb4U9e0ig70AXfPgXxKwEts4c/KI2CSOvjeAiM5Qa4u5PDrE+KPZtk6FOp3ywNM
	gli6QIU=
X-Received: by 2002:a05:7301:4090:b0:2c5:b23e:48ac with SMTP id
 5a478bee46e88-2cbf99ec0aemr8617373eec.2.1775578766961; Tue, 07 Apr 2026
 09:19:26 -0700 (PDT)
MIME-Version: 1.0
From: Joseph Ferrero <joeferrero14@gmail.com>
Date: Tue, 7 Apr 2026 09:19:16 -0700
X-Gm-Features: AQROBzCtrC8-KONrU3iHxUagVXEKfoCvER5zee2-YMbfnRPtz8qfJdvnNQui7e4
Message-ID: 
 <CAGid3wpdk1NK0mij2f4bwWOchdJE81ipyifx5yxxOB0W=Bm3_g@mail.gmail.com>
Subject: [REGRESSION] ALSA: hda/realtek: Gigabyte quirk misconfigures front
 combo jack mic pin as HP out on ALC897
To: alsa-devel@alsa-project.org
Cc: shumingf@realtek.com
X-MailFrom: joeferrero14@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LW33CKIZPB3MQSAYZ72VMTLXT2QR6KFZ
X-Message-ID-Hash: LW33CKIZPB3MQSAYZ72VMTLXT2QR6KFZ
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:57:20 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LW33CKIZPB3MQSAYZ72VMTLXT2QR6KFZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkFmdGVyIHVwZ3JhZGluZyBmcm9tIGtlcm5lbCA2LjE5LjEwIHRvIDYuMTkuMTEsIHRo
ZSBmcm9udCBwYW5lbCBjb21ibyBqYWNrDQpvbiBteSBHaWdhYnl0ZSBaODkwTSBHQU1JTkcgWCBu
byBsb25nZXIgcHJvdmlkZXMgbWljcm9waG9uZSBpbnB1dC4gVGhlDQpoZWFkcGhvbmUgb3V0cHV0
IG9uIHRoZSBzYW1lIGphY2sgc3RpbGwgd29ya3MuIFJldmVydGluZyB0byA2LjE5LjEwDQpyZXN0
b3JlcyBtaWMgZnVuY3Rpb25hbGl0eS4NCg0KSSBzdXNwZWN0IHRoZSBmb2xsb3dpbmcgY29tbWl0
IGludHJvZHVjZWQgaW4gNi4xOS4xMToNCg0KICBBTFNBOiBoZGEvcmVhbHRlazogQWRkIHF1aXJr
IGZvciBHaWdhYnl0ZSBUZWNobm9sb2d5IHRvIGZpeCBoZWFkcGhvbmUNCg0KSGFyZHdhcmU6DQog
IEJvYXJkOiBHaWdhYnl0ZSBaODkwTSBHQU1JTkcgWA0KICBDb2RlYzogUmVhbHRlayBBTEM4OTcg
KGNhcmQgMSwgL3Byb2MvYXNvdW5kL2NhcmQxL2NvZGVjIzApDQogIFN1YnN5c3RlbSBJZDogMHgx
NDU4YTE5NA0KICBDb250cm9sbGVyOiBJbnRlbCA4MDAgU2VyaWVzIEFDRSAoSERBIEludGVsIFBD
SCkNCg0KV29ya2Fyb3VuZDoNCiAgRG93bmdyYWRlIHRvIGxpbnV4IDYuMTkuMTAuDQoNClRoYW5r
cywNCkpvc2VwaCBGZXJyZXJvDQo=
