Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE88FC4451C
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:40:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7F5E60251;
	Sat, 18 Jul 2026 11:40:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7F5E60251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367650;
	bh=Irn0DQtdzHE4iRQyXcI2LA04B8mCzW88Fo2i4cJuICU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DutrC5XV1l9L6RwXI5ESj71Ufw/zDbCGdEW++j6Uwt6I3x6DEY5kIPnU3W3w2p+2b
	 WYnsFqsY4sT3PjGD4wgWhRxM85kbnoEzDiQOrN2QqJmuj7YKCb0vFGqaPU4znJ+yp3
	 qk+a/yxhGFS1r3ZvcgNd3HeB1KircKaguy3NY7Os=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96862F80606; Sat, 18 Jul 2026 11:39:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CAD1F80615;
	Sat, 18 Jul 2026 11:39:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F124F80527; Thu, 16 Jul 2026 10:06:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784189181;
	b=SvjH7vp/vEwtUiwxl974wxmwGgl0eFBt3JotxH6SRa5qtmaRzLZaRFC6os5iFyuwfF1r
	 QkNv1FaPagWxiGd6aYo4MXt5Qf/2tQObp/4kl6t8WuOgJo1V+umP2SKDKnHPl4ePPsVSJ
	 wpEkhPW5k0wFefefo+6UwkGpC7YlVT8OL5miNq9xyqYcpW05orjJx5pgPlkvarG8/OFx0
	 ofuQ8tKShxh+R6BYEjL84X2UBZXK9NnNAYmlirA1f8jO+4n/+V8ZptroeHRxaxAgpWZ2b
	 EsyRCYSpCl6P9mJOlDKnRdCBdWfkGdUztan3Eq/ZuO/BNuhDzSMaYSh99UeAuSIniTQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784189181;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:From:Subject:To;
	bh=0t2IjliNmT2AS+EJnOilX7w5unlEhK61oynwn1NW3bQ=;
	b=obPTJgi/BQqzAxpVjebgKWRl8Xpb6vR0aMdzBYpdV1t325pN3L7C7LmsM2l80p9h9xY8
	 ltSflWhAoz7QSMnR6FgFeGOEEySdizkMoxpnu6ed81duTNy5RP04cJmSijKMvsS+HOthY
	 GOarRk9ejJXknwj7VCnI30XDbtBJBAp5iecJIPeif2oJDOrCIAm2z5//p+f9NB46IQZpy
	 E6us89ZJF8lP3sYyDNZBpHcrkjPkPjJFPHjWQE0CRQcPnKzfZ+/T7XXqMXrqTVR8lss/Z
	 ivRY3FOPK5vxQTb0VDpkHE6AXQzkkf6aa1TsWBqZCG5szmQQY2CkQHByhgewF9/CR7A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PWRkMA8y;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7275EF8051E
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 10:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7275EF8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PWRkMA8y
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so166115f8f.1
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Jul 2026 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784189179; x=1784793979;
 darn=alsa-project.org;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uETF3yuI7l9amd4leuO5YTp4N4zOu0w/Pmyo6uQRuyI=;
        b=PWRkMA8yOAaCr6+ITF0GuaCnzhIcOubYFSdTtnGpQioWVCZvHAc7FzgcsVr1MVAUb3
         OwZs7UyvhSuaKqlr+v6oLoPPqTnUjJb508+9OfmthpolUQ7L7yeXQdiqg6aPC24GaD25
         c3MMquEFxj+IFER5kVn9Rh9ncUQxOV6hyQIWKgBQgqEYcmILpWU1Gxuui6bwnSThYVRR
         MFImlzbgiWtr6p8zm+xMc6fKemY2yt6tocFYaWH+QMvhZZUACalAAqDXp0zYEKCGXRIV
         xf1eqS1hkFCJ08/1sNp8Dz4o1F0xby6+zCW+9FQ3LWDZP18408eH6Uo9RdnEZpphAh1n
         hFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784189179; x=1784793979;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uETF3yuI7l9amd4leuO5YTp4N4zOu0w/Pmyo6uQRuyI=;
        b=izD6xE5KCHQ0bdQmMpoJ+AowixiC2UA2PHEdaVJn4jeNENEMWJS0Iq5DW+nR5iNIIX
         EU5jKgudB4/Kv+fs4KlgtV+wz8/mxOWrJefoTQuBbVBMgfsNXgysg4YgCwCdsUrNqPiI
         8mxbfGvCdlhJ5Fmw/SfN9UVTgYYZ+0vNO0XLYlD7WbCqSxN/SVytxNxVougZjFoHZa+G
         F+ZBCRgs61hLstMuNjD4nPTS9sKailE9mcN79UiQpyn4sDQWbb9DgdeM/WHoqrUbe4rS
         LikUcE/9BWLsddUGBF5fkP/Rl0/9R/6yJXNVA8gPntm22sxOdU4RxuTfSX9+k3ECzuIn
         F1hg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2NUSPa+9PkKZbWALg0JH04gw+968XeOw2cmcVyJPH0W5zXCG5/uQWYmlkS/c+HQqmbsikmo4PHHro@alsa-project.org
X-Gm-Message-State: AOJu0Yy89+td8vYjknuR0lHK6VvMgCA4h0c+BfV+mqBiVWOM7zGQyzHF
	Frblc52uhKve7A+W67ETWVZ4nTGzgcDVcTP/jl2GRPNZT7XicusXqYJl
X-Gm-Gg: AfdE7cm4/zTXD7py9enpfUGn0JdfTafaVvwFYLQRfZuFzNC3O+wgFR2emSPqHpYNxIA
	/E2XW5Gxm0LNJWOHUsB4naH+eLgky2loDBIYfBHfzhJtED/Y5hFU9p9ekiqaSCx3GEkqLcniiNX
	MqUVQ3PUSqBytGsrmgDJxE0IKYSokUjuAYtuMSmdgPZmls8YOePr6z2A1PrdsKRxYEz7HKyqHzZ
	CMI/JtuDUAoyuJ8h4IzyII5Mmo28c0wKMal7ZlACujCx/CGd0MZee0umQncjVlsZuWcEhKg44Nr
	MvYVVhv8JCy881IwYK6/XpOkd4lgz798lOggvcxSczQabwxf5QjSTQxkjlKMvVt5NFymns70/Kn
	xtEC8i9jKA6uEEbrq29h9i8feETHYB+TXdqUzKiTq5OC8Gax0rvx2MDdETZm6SALAvb+3IQNk2X
	LvI0T3L4BfYpZSLw==
X-Received: by 2002:a05:6000:4905:b0:47f:3f98:7805 with SMTP id
 ffacd0b85a97d-47f5a433401mr1385635f8f.17.1784189178980;
        Thu, 16 Jul 2026 01:06:18 -0700 (PDT)
Received: from [192.168.18.146] ([176.202.18.59])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm23310586f8f.22.2026.07.16.01.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 01:06:18 -0700 (PDT)
Message-ID: <c730789d-2a46-4fe7-ba98-fab990361e90@gmail.com>
Date: Thu, 16 Jul 2026 11:06:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Salman S. Tahir" <salman.abusaad@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_7=2E2-rc3=5D_ASoC=3A_cs35l56=3A_compo?=
 =?UTF-8?Q?nent_probe_waits_for_an_init=5Fcompletion_that_cannot_be_signalle?=
 =?UTF-8?Q?d_until_the_wait_ends_=E2=80=94_whole_sof=5Fsdw_card_fails?=
To: rf@opensource.cirrus.com
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <1bb9628e-3c3b-4b43-906b-0f5bc2f6e4d5@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <1bb9628e-3c3b-4b43-906b-0f5bc2f6e4d5@opensource.cirrus.com>
X-MailFrom: salman.abusaad@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4SPVSDAA5CJDEI6FFVMHR5RQ7XN3DTDP
X-Message-ID-Hash: 4SPVSDAA5CJDEI6FFVMHR5RQ7XN3DTDP
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:39:50 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4SPVSDAA5CJDEI6FFVMHR5RQ7XN3DTDP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciB0aGUgZGlhZ25vc2lzIGFuZCB0aGUgY29tcGxldGUo
KSAtPiBjb21wbGV0ZV9hbGwoKSBzdWdnZXN0aW9uLiBJDQp0ZXN0ZWQgaXQgYmVmb3JlIHJlcGx5
aW5nLCBhbmQgSSdtIHNvcnJ5IHRvIHJlcG9ydCBpdCBkb2VzIG5vdCBmaXggdGhlIA0KZmFpbHVy
ZQ0Kb24gdGhpcyBtYWNoaW5lIChMZW5vdm8gWW9nYSA5aSAxNElMTDEwLCB0d28gU1BJIENTMzVM
NTYgQjAgYW1wcywgNy4yLXJjMykuDQoNCldoYXQgSSByYW4NCi0tLS0tLS0tLS0NCkkgcmVidWls
dCBzbmQtc29jLWNzMzVsNTYgd2l0aCBleGFjdGx5IHRoZSBvbmUgY2hhbmdlIHlvdSBkZXNjcmli
ZWQ6DQoNCnNvdW5kL3NvYy9jb2RlY3MvY3MzNWw1Ni5jOjIxMTEsIGluIGNzMzVsNTZfaW5pdCgp
DQotIGNvbXBsZXRlKCZjczM1bDU2LT5pbml0X2NvbXBsZXRpb24pOw0KKyBjb21wbGV0ZV9hbGwo
JmNzMzVsNTYtPmluaXRfY29tcGxldGlvbik7DQoNCihidWlsdCBtb2R1bGUgc3JjdmVyc2lvbiBD
RUFGNUY4MzhGRkUwNzUwRTQxQTgxRiwgdmVybWFnaWMgbWF0Y2hpbmcgdGhlIA0KcnVubmluZw0K
a2VybmVsKS4gSSBBL0InZCBpdCBhZ2FpbnN0IHRoZSB1bm1vZGlmaWVkIHN0b2NrIG1vZHVsZSwg
d2l0aCBteSB1c2Vyc3BhY2UNCndvcmthcm91bmQgcmVtb3ZlZCBzbyB0aGUgY2FyZCBwcm9iZXMg
bm9ybWFsbHkgZWFjaCBib290LiBXYXJtIHJlYm9vdHMsDQpvdGhlcndpc2Ugc3RvY2sgbWFjaGlu
ZToNCg0KIyB8IG1vZHVsZSB8IGNhcmQgfCBjYWxMIHwgY2FsUiB8IHRpbWVvdXQgfCBpbnN0RmFp
bCB8IHZlcmRpY3QNCi0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLSstLS0tLS0rLS0t
LS0tKy0tLS0tLS0tLSstLS0tLS0tLS0tKy0tLS0tLS0tDQoxIHwgU1RPQ0sgfCBubyB8IHllcyB8
IG5vIHwgeWVzIHwgeWVzIHwgRkFJTA0KMiB8IEZJWCAoY29tcGxldGVfYWxsKSB8IG5vIHwgeWVz
IHwgbm8gfCB5ZXMgfCB5ZXMgfCBGQUlMDQozIHwgRklYIChjb21wbGV0ZV9hbGwpIHwgbm8gfCB5
ZXMgfCBubyB8IHllcyB8IHllcyB8IEZBSUwNCg0KQm90aCBmaXgtYXJtIGJvb3RzIGZhaWwgaWRl
bnRpY2FsbHkgdG8gc3RvY2ssIGFuZCB0byB0aGUgMTEvMTEgc3RvY2sgDQpmYWlsdXJlcw0KSSBy
ZXBvcnRlZCBvcmlnaW5hbGx5OiBsZWZ0IGFtcCBjYWxpYnJhdGVzLCByaWdodCBhbXAgbmV2ZXIg
ZG9lcywgdGhlIA0KY29tcG9uZW50DQpwcm9iZSB0aW1lcyBvdXQsIGFuZCB0aGUgd2hvbGUgc29m
X3NkdyBjYXJkIGlzIHRvcm4gZG93bi4NCg0KVGltZWxpbmUgKENMT0NLX01PTk9UT05JQyksIHN0
b2NrIHZzLiBjb21wbGV0ZV9hbGwNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpUaGUgdHdvIGFybXMgYXJlIHRpbWluZy1pZGVudGljYWwsIHdoaWNo
IEkgdGhpbmsgaXMgdGhlIGtleSBwb2ludDoNCg0KZXZlbnQgU1RPQ0soIzEpIEZJWC9jb21wbGV0
ZV9hbGwoIzMpDQpsZWZ0IGFtcCBpZGVudGlmaWVkIChSZXYgQjApIDUuMzY5cyA1LjUzMXMNCnJp
Z2h0IGFtcCBTUEkgcHJvYmUgYmluZHMgcmVndWxhdG9ycyA1LjY2M3MgNS44MzNzDQpsZWZ0ICJD
YWxpYnJhdGlvbiBhcHBsaWVkIiA5LjUyNnMgOS42OThzDQpyaWdodCAiX2NzMzVsNTZfY29tcG9u
ZW50X3Byb2JlOg0KaW5pdF9jb21wbGV0aW9uIHRpbWVkIG91dCIgMTAuODEzcyAxMS4zMjVzDQpy
aWdodCBhbXAncyBvd24gIlJldiBCMCIgaWQgcHJpbnQgMTAuODc3cyAxMS40MDRzDQoNCkxvZyBm
cm9tIHRoZSBmaXgtYXJtIGJvb3QgKCMzKSwgY29tcGxldGVfYWxsKCkgbW9kdWxlIGxvYWRlZDoN
Cg0KY3MzNWw1NiBzcGktY3MzNWw1Ni1sZWZ0OiBDaXJydXMgTG9naWMgQ1MzNUw1NiBSZXYgQjAg
T1RQMyBmdzozLjQuNCANCihwYXRjaGVkPTApIFs1LjUzMXNdDQpjczM1bDU2IHNwaS1jczM1bDU2
LXJpZ2h0OiBzdXBwbHkgVkREX1Agbm90IGZvdW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IgDQpb
NS44MzNzXQ0KY3MzNWw1NiBzcGktY3MzNWw1Ni1sZWZ0OiBEU1AxOiBGaXJtd2FyZTogMWEwMGQ2
IC4uLiB2My4xMS4yNiwgNDEgDQphbGdvcml0aG1zIFs4LjA1M3NdDQpjczM1bDU2IHNwaS1jczM1
bDU2LWxlZnQ6IENhbGlicmF0aW9uIGFwcGxpZWQgWzkuNjk4c10NCjwtLSByaWdodCBhbXAgZW1p
dHMgbm90aGluZyBhdCBhbGwgdGhyb3VnaCBoZXJlIC0tPg0KY3MzNWw1NiBzcGktY3MzNWw1Ni1y
aWdodDogX2NzMzVsNTZfY29tcG9uZW50X3Byb2JlOiBpbml0X2NvbXBsZXRpb24gDQp0aW1lZCBv
dXQgWzExLjMyNXNdDQpjczM1bDU2IHNwaS1jczM1bDU2LXJpZ2h0OiBBU29DIGVycm9yICgtMTkp
OiBhdCANCnNuZF9zb2NfY29tcG9uZW50X3Byb2JlKCkgb24gc3BpLWNzMzVsNTYtcmlnaHQNCnNv
Zl9zZHcgc29mX3NkdzogQVNvQzogZmFpbGVkIHRvIGluc3RhbnRpYXRlIGNhcmQgLTE5IFsxMS4z
MjVzXQ0KY3MzNWw1NiBzcGktY3MzNWw1Ni1yaWdodDogQ2lycnVzIExvZ2ljIENTMzVMNTYgUmV2
IEIwIE9UUDMgZnc6My40LjQgDQoocGF0Y2hlZD0wKSBbMTEuNDA0c10NCg0KT2JzZXJ2YXRpb25z
LCBvZmZlcmVkIGFzIGRhdGEgcmF0aGVyIHRoYW4gdGhlb3J5DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoZSByaWdodCBhbXAncyBTUEkgcHJvYmUg
YmluZHMgaXRzIHJlZ3VsYXRvcnMgYXQgfjUuOHMsIGJ1dCB0aGUgYW1wIHRoZW4NCnByb2R1Y2Vz
IG5vIGZ1cnRoZXIgbG9nIG91dHB1dCBmb3IgfjUuNXMuIEl0cyBvd24gaWRlbnRpZmljYXRpb24g
cHJpbnQgDQooZWFybHkNCmluIGNzMzVsNTZfaW5pdCgpL2h3X2luaXQpIGRvZXMgbm90IGFwcGVh
ciB1bnRpbCAxMS40MDRzIC0tIDc5IG1zIA0KKmFmdGVyKiB0aGUNCmNvbXBvbmVudC1wcm9iZSB3
YWl0IGhhcyBhbHJlYWR5IHRpbWVkIG91dCBhdCAxMS4zMjVzLiBUaGUgc2FtZSBob2xkcyBpbiB0
aGUNCnN0b2NrIGFybSAoaWQgcHJpbnQgMTAuODc3cywgNjQgbXMgYWZ0ZXIgdGhlIDEwLjgxM3Mg
dGltZW91dCkuDQoNCkR1cmluZyB0aGF0IH41LjVzIGdhcCB0aGUgbGVmdCBhbXAgaXMgZG9pbmcg
aXRzIGZpcm13YXJlIGRvd25sb2FkIA0KKGZpbmlzaGluZyBhdA0KIkNhbGlicmF0aW9uIGFwcGxp
ZWQiIDkuNjk4cykuIFNvIG9uIHRoZXNlIGJvb3RzIHRoZSBjb21wbGV0aW9uIA0KKGNvbXBsZXRl
KCkgb3INCmNvbXBsZXRlX2FsbCgpKSBpcyBiZWluZyBzaWduYWxsZWQgdG9vIGxhdGUgdG8gYmUg
d2FpdGVkIG9uLCByYXRoZXIgdGhhbiANCmJlaW5nDQpjb25zdW1lZCBieSBhIHNlY29uZC9lYXJs
aWVyIHdhaXRlciAtLSB0aGUgcmlnaHQgYW1wJ3MgaW5pdCBzaW1wbHkgaGFzbid0DQpyZWFjaGVk
IGxpbmUgMjExMSBieSB0aGUgdGltZSB0aGUgd2FpdGVyIGdpdmVzIHVwLiBUaGF0J3Mgd2h5IGNv
bXBsZXRlX2FsbCgpDQpjaGFuZ2VzIG5vdGhpbmcgaGVyZS4gSSdsbCBsZWF2ZSB0aGUgbWVjaGFu
aXNtIHRvIHlvdSByYXRoZXIgdGhhbiBzcGVjdWxhdGUuDQoNCkNhdmVhdDogTiBpcyBzbWFsbCAo
MyBib290cykgYW5kIGFsbCB3YXJtLiBCdXQgdGhlIHNpZ25hdHVyZSBpcyAxMDAlIA0KY29uc2lz
dGVudA0KYW5kIGlkZW50aWNhbCB0byB0aGUgMTEvMTEgc3RvY2sgZmFpbHVyZXMsIHNvIEknbSBj
b25maWRlbnQgdGhlIGNoYW5nZSANCmRvZXMgbm90DQphZGRyZXNzIHRoaXMgZmFpbHVyZS4NCg0K
T25lIG1vcmUgZGF0YSBwb2ludCBpbiBmYXZvdXIgb2YgdGhlIG11bHRpcGxlLWluc3RhbnRpYXRp
b24gYW5nbGU6IG15IA0KdXNlcnNwYWNlDQp3b3JrYXJvdW5kIGlzIGp1c3QgdG8gYmxhY2tsaXN0
IHNuZF9zb2Nfc29mX3NkdyBhbmQgbW9kcHJvYmUgaXQgb25seSANCmFmdGVyIGJvdGgNCmFtcHMn
IFNQSSBwcm9iZXMgaGF2ZSByZXR1cm5lZCwgc28gdGhlIGNhcmQgaXMgaW5zdGFudGlhdGVkIGV4
YWN0bHkgDQpvbmNlLiBXaXRoDQp0aGF0IGluIHBsYWNlIGl0IGNvbWVzIHVwIGZpcnN0IHRpbWUg
b24gZXZlcnkgYm9vdCAoaW5jbHVkaW5nIGNvbGQpLiANClNpbmdsZSB2cy4NCnJlcGVhdGVkIGlu
c3RhbnRpYXRpb24gc2VlbXMgdG8gYmUgdGhlIHdob2xlIGRpZmZlcmVuY2UgaGVyZS4NCg0KWW91
IG1lbnRpb25lZCByZWNlbnQgY2hhbmdlcyB0byBob3cgQVNvQyBwcm9iZXMgYW5kIHJlLXByb2Jl
cyBjYXJkcyBwb3NzaWJseQ0KYmVpbmcgd2h5IHRoaXMgc3VyZmFjZWQgbm93IC0tIHRoZSAiaW5p
dCBydW5zIGFmdGVyIHRoZSB3YWl0IGVuZHMiIA0KdGltaW5nIGFib3ZlDQptYXkgYmUgYSBkYXRh
IHBvaW50IGZvciB0aGF0LiBJIGhhdmUgdGhlIGhhcmR3YXJlIGFuZCBjYW4gcmVwcm9kdWNlIG9u
IA0KZGVtYW5kLA0Kc28gSSdtIGhhcHB5IHRvIHJ1biBhbiBpbnN0cnVtZW50ZWQgYnVpbGQgKGUu
Zy4gcHJpbnRzL3RpbWVzdGFtcHMgYXJvdW5kIHRoZQ0KcmlnaHQgYW1wJ3MgaW5pdCBhbmQgdGhl
IGNvbXBvbmVudC1wcm9iZSB3YWl0KSwgdGVzdCBhbm90aGVyIHBhdGNoLCBvciANCmJpc2VjdA0K
dGhlIEFTb0MgcHJvYmUvcmUtcHJvYmUgY2hhbmdlcyAtLSB3aGF0ZXZlciBpcyBtb3N0IHVzZWZ1
bCB0byB5b3UuIEp1c3QgDQpsZXQgbWUNCmtub3cuDQoNClRoYW5rcyBhZ2FpbiBmb3IgdGFraW5n
IHRoZSB0aW1lLg0KDQpTYWxtYW4NCg0KT24gV2VkLCBKdWwgMTUsIDIwMjYgMDc6MTAgUE0sIFJp
Y2hhcmQgRml0emdlcmFsZCANCjxyZkBvcGVuc291cmNlLmNpcnJ1cy5jb20+IHdyb3RlOg0KDQog
ICAgT24gMTUvMDcvMjAyNiA1OjAwIHBtLCBTYWxtYW4gUy4gVGFoaXIgd3JvdGU6DQogICAgID4g
SGkgUmljaGFyZCBhbmQgdGhhbmtzIGZvciB0aGUgcHJvbXB0IHJlc3BvbnNlIGFuZCBjbGFyaWZp
Y2F0aW9uLg0KICAgICA+DQogICAgID4gWW91IGFyZSByaWdodC4gSSBhbSBub3JtYWxseSB2ZXJ5
IHdlYXJ5IG9mIEFJLCBidXQgdGhpcyBvbmUgd2FzIGENCiAgICBiaXQNCiAgICAgPiBiZXlvbmQg
bWUhDQogICAgID4NCiAgICAgPiBJIHdpbGwgdHJ5IHlvdXIgY2hhbmdlIGFuZCBhZHZpc2UgaWYg
YW55dGhpbmcgZ29lcyB3cm9uZyBvciBpdA0KICAgIGRvZXNuJ3QNCiAgICAgPiB3b3JrIGFzIGV4
cGVjdGVkLg0KDQogICAgSXQncyByZXZlYWxlZCBhIGdlbnVpbmUgYnVnIGluIHRoZSBkcml2ZXIu
IFNvIHdlIHdpbGwgbmVlZCB0byBnZXQgYSBmaXgNCiAgICBvdXQgZm9yIHRoYXQuDQoNCiAgICBJ
dCdzIGxpa2VseSB0aGUgY2F1c2Ugb2YgeW91ciBwcm9ibGVtLg0KDQogICAgVGhlcmUgd2VyZSBz
b21lIHJlY2VudCBjaGFuZ2VzIHRvIHRoZSB3YXkgQVNvQyBwcm9iZXMgYW5kIHJlLXByb2Jlcw0K
ICAgIGNhcmRzLCB3aGljaCBtaWdodCBiZSB3aHkgdGhpcyBpcyBvbmx5IHNob3dpbmcgdXAgbm93
Lg0K
