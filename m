Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFB606A897
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OmJHbTyr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=xqjGRzkE
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1676A60200;
	Mon, 16 Nov 2026 14:47:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1676A60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794836831;
	bh=Whw3e0isbHr9XwlBwtdbJyjwMZAriJSImbDL0Ucyne0=;
	h=Date:To:Cc:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OmJHbTyrEELljMePgotdDUuIIbaVRskIz6Ytcc1Yn9/H8On0FW+h3zKZbh2mbSfH5
	 An5hIhdfW+thgC5RCgDFND49U7Jfv6k/tNiAuBNsdf9sbr82pFtosSVtjNa1RPshuh
	 RVl9dC27z3GCSxtgX7eP8JE3aATziIGrDJwfJUT8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 160DEF8060A; Mon, 16 Nov 2026 14:46:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 187A1F805F6;
	Mon, 16 Nov 2026 14:46:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76738F80537; Wed, 11 Nov 2026 23:22:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,TRACKER_ID,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=57.103.71.109
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794435725;
	b=Nuykuzj0/kSeZY5381iyAY41J1nkshLJMTuwNVbxy4WJtqsKkatKkfROt/QTfShlhdok
	 8cRTjQOEGgiV8ByptOms8NvE0aNaN/1LT7It/JraYmKgNtWQztKalKtuufvPJCAYX1Gy5
	 4+IoQRGUWCCZeUiNuGZoB0IVzMDL2Ka1AFDo4wTga5rrQPByPq+rGmwQ8+QTo0viV6PAE
	 YINQpIy4XMJsdmj/naz03UeQ+kBmxbkH0GOvpKvGcd6ltdd0xF3cPP8tbTE//7CtTkBGI
	 ojM6Ez84oVt+mAQmYFVG2Z830KmQtv4sadeFBEeuf+UGsuQFjMAMV0mzJSXHBWHuOZA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794435725;
	h=Dkim-Signature:Message-ID:Date:MIME-Version:To:From:Subject;
	bh=Ym9O24AhEzwCh8afCPSQaFcW8Lx00Zfyb7zO0KBRrF4=;
	b=NS+r3XZGMrK1V1hCMaLcIEwMqPjcHR3eBogdPuwdrrlNU0KLaXUr6U+ZtWjiK5s7sA7Z
	 1Ada3IKblx2ifEYqFMymyVnLqJgTwfBbud1sDlFqJLuZ+vIH9bWImnmVoVydzbodbYgSq
	 7LCsJRSY2vUCqMF8TEXkthxns5MovNE/VM9dhEl0KFQjHd3iBrev94k2DFgvHyAp8Si9p
	 ZFRWn+7cwD4LQbjL2SF4SyTmYgqAx2BZHmqkvx8F01wUfNR2YLY6vm0WcAhcsUfaeSzUz
	 mOHXF0HHLi0DuAzo/EAa3uVvfG8BpgTN6aHh4wvxiIUqPgC7Jro9LkgcE4jTU7ElE6Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=xqjGRzkE;
	arc=none smtp.remote-ip=57.103.71.109
Received: from outbound.mr.icloud.com (mr-2005a-snip4-6.eps.apple.com
 [57.103.71.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E382F80020
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 23:22:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E382F80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=xqjGRzkE
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPS id
 8ACEE180014E;
	Wed, 11 Nov 2026 22:22:00 +0000 (UTC)
X-ICL-RepId: 01a1ccb4-2525-78c4-945b-4e5e884bc200
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1794435721; x=1825971721; bh=ighPj0o/pCV31qfmR8ANNiV12+k3mR/bZ7S+S31yus4=;
 h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject:x-icloud-hme;
 b=xqjGRzkEvjlyFvnJU7StHlc9cobsq5WvyRGawOVmrB0MAhpQREYs37imUWNQTo4vtA7sCg44gxsGcKJmgWxMw9fQRQjlWB9e54vMCPWvVFCMCXrdx2NPT0c69zj+i9vTQGN9cYvrRcs/8rKuxULnNFJjEVg2o1zMk4MyPC1fMk7bZk8xrCqzegRPGdM7q54PqR2ahqne/H5WlkG95BwQIeX5/Z4AnJnATDd4sOWqohQHaZlYD/4GLAIha5qyLW/u5x+z+uv4VtCaBDKSQJetTL4FKurz/+ilIEKbQHIoHc6DHQQRRstfBuaqIykR3CPln2m2tBLjlR/kHndnz+qXjw==
Received: from [192.168.1.48] (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPSA id
 104AF1800153;
	Wed, 11 Nov 2026 22:21:58 +0000 (UTC)
Message-ID: <71fb1e29-60e1-4522-a071-c53557cea39b@icloud.com>
Date: Thu, 12 Nov 2026 06:21:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com, regressions@lists.linux.dev,
 kernel@lists.fedoraproject.org
From: Arlou Kier Motas <motasarloukier@icloud.com>
Subject: [REGRESSION] ALSA HDA CS4208: MacBookPro11,4 loses bass speaker on
 Linux 7.3.3
X-Proofpoint-ORIG-GUID: 3Q13-_wvXapimQQ_SjWK4aofoIVFJuts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4OSBTYWx0ZWRfX/ojbaXCTJ8ft
 Y39MdjOQ4I/oogFoDnG1IBxRLDE4Se6La8/kfUGU1ucbsm/YB3OEqsXxC1QRjsK+YsjuLPeHNAq
 aqLnq4bCQ+AKSPMTv9CLRU/5JUadWK4oWc0+ehYhHPoeP9P6b1OJeN+jZBGadBlOz8QRlrf4tqb
 ykVY4dW9p6YmfELPknT8SxEmRAW4XrsGznNHj7Z+fwkK8Ltbmi6VnM0YhPe5ZvByxORV8IQ4Ly8
 csKOnsylPHbMT3UD/PeVct2APJC3gbvvYv4O/ChJn4hnC8AXGzsxpt8bZbJDDcbDMB5rUrYl8PP
 eIQa9XLAZpMQacfub7xgFvr/5K0RS8BrTPyfGpf9rrgsXjzcKwggQt7F0vM/gs=
X-Authority-Info-Out: v=2.4 cv=V/lwEOni c=1 sm=1 tr=0 ts=6af4ea89
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=RYUI-02sw64A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=Oh2cFVv5AAAA:8 a=_cmgmxL9vGWN6BvcGB0A:9 a=QEXdDO2ut3YA:10
 a=A5FNFRSyR3tapvPxb2UA:9 a=qE3OGb7XVH2kILnb:21 a=_W_S_7VecoQA:10
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-GUID: 3Q13-_wvXapimQQ_SjWK4aofoIVFJuts
X-JNJ: AAAAAAAB1WBXRoOdU5il+ywbYsE4oTXjUtp8AB/Rf7N2T91YrU+Hjc/PBEYbm7z0hlsQXx
 flTFWCZ83g/VE6KITGrwxuSDKuL25YqADoB3U0GeV2puiWyuIbbCp7zoYhkOjPVdx7o+3Q
 PNblUMcEaZ8Utv+6A5rLWIpaAjlQEiPWwZ7Iv9G69qFBM9fgNIACcJBzWVVQ2Wi8g27qeh
 mjRdiM+e4u89hjphVb7OEHJS8C+QfEMZ1McfRmURIrdLqAqVpo732gQ3B0KC3P2jviHPYK
 H3vN+sYF4yFzeNVRqxWpQLz5SGKpFBtVfgt+KdO6LnjL8LahiiTq8ITrqQ8OQ7m+JJMWRG
 GVL7gN23Lw7F5aXbRTCUOWcTpFRiwwRdlAzaJ4YyIhsNVloWF9UQH7TTFrENv+PIvx7GKo
 y21zomGnZqQHX2lYAIEPFfwwhc0gs1P/mJa12uJF2ZUkijgepbifHGwRwJpnu/EBgZL99C
 Mnyc9QSe7RFmg5Q6ZHdzwpsnBW4+0s7bDHR5KiEH8ltgTSIDg1iunNVhHguGvBKwlq0Xsv
 8/S+jRbu3wdbDyEJiSNXv/1MMcrtDIQ9gjdCB/PHXYaMkbe34f0e6MDI+G3Bj5EGmT8NKr
 NwUcu4CUcqs8R/cFxUigTIpnj9p7czMP6CSKDd+X96DQmSwU3BrufwgZnfTW3uVN90MvVt
 77of2fYpQZfSeu47TvJo7EA97rMZH28SHOzYBmwU3Zi4KVa1XBsLHQZpVFgOLVaGO+Gtw7
 bLuxtnuo4fHGxMTm7D+S2vUED7OS93i2w++/0OensUZmdbmdzWGKvV8wDZlpCx5sDhgVLe
 0b7REk1hy9eLsl9o3boYVuk9TW6PRU0mQkUTmGX9hs0ApelzlHSNKulrSRce+bsi1UZjj+
 oGWVNPW/WNsHF+Nk7YXEqxPCwmVHsBsUj8OqBgecwwX3ujom5QL4rt6sOSD4GVIDtkDZK8
 nXikFrVslZSDYS4UIOlZkvpXxfo14FZ3/5JKKXDkK6SDetj78NOuGZVWHZySF+X0iWeF0C
 QumEewlr3Y5BqdCYHIWgU/F2bLm7Vof+thKP/20fdmtd2j8xZ8jFhqTshYT6By6RKUxt9P
 AVvhlhhtrTzgFvm/aa+zjAj05VNqVMGykVvorPaD+qwz0xh2yKR3HbZpZqrRbAB6eOo7D+
 arODS5cFHclyfWTdSgIUYhUQeUea9tB2Hlo48qkbVSn6y3C+QCpCy8uF4N3IFug1uxp1Yc
 jDxIwWztlgx9IyymCQNOVFRecrVDiIi5olllpIMY2G0SkT2h384q3G7ZjRZA6RLdW3p606
 /tJg==
X-MailFrom: motasarloukier@icloud.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TNQFIBVD6DQPRH6SUOH3DAIZUMC433BL
X-Message-ID-Hash: TNQFIBVD6DQPRH6SUOH3DAIZUMC433BL
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:46:28 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TNQFIBVD6DQPRH6SUOH3DAIZUMC433BL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

RGVhciAqQUxTQSogYW5kICpGZWRvcmEgS2VybmVsIERldmVsb3BlcnMqLA0KDQpJIHdvdWxkIGxp
a2UgdG8gcmVwb3J0IGEgcmVwcm9kdWNpYmxlIGF1ZGlvIHJlZ3Jlc3Npb24gYWZmZWN0aW5nIHRo
ZSANCmludGVybmFsIHNwZWFrZXJzIG9mIG15IEFwcGxlIE1hY0Jvb2sgUHJvIDE1LWluY2ggKE1p
ZCAyMDE1KSwgbW9kZWwgDQpNYWNCb29rUHJvMTEsNCwgcnVubmluZyBGZWRvcmEgTGludXggNDQg
S0RFIFBsYXNtYS4NCg0KKlN1bW1hcnkqDQoNClRoZSBpbnRlcm5hbCBzcGVha2VycyB3b3JrIGNv
cnJlY3RseSBvbiBMaW51eCBrZXJuZWwgNy4yLjE1LCBpbmNsdWRpbmcgDQpub3JtYWwgYmFzcyBy
ZXByb2R1Y3Rpb24uIEhvd2V2ZXIsIHdoZW4gYm9vdGluZyBrZXJuZWwgNy4zLjMsIHRoZSBzb3Vu
ZCANCmJlY29tZXMgbm90aWNlYWJseSB0aGluLCBhbmQgdGhlIEFMU0EgIkJhc3MgU3BlYWtlciIg
bWl4ZXIgY29udHJvbCANCmRpc2FwcGVhcnMuDQoNClJlYm9vdGluZyBpbnRvIGtlcm5lbCA3LjIu
MTUgcmVzdG9yZXMgbm9ybWFsIGF1ZGlvLg0KDQoqSGFyZHdhcmUgSW5mb3JtYXRpb24qDQoNCiAg
Kg0KDQogICAgQ29tcHV0ZXI6IEFwcGxlIE1hY0Jvb2tQcm8xMSw0DQoNCiAgKg0KDQogICAgQXVk
aW8gY29udHJvbGxlcjogSW50ZWwgSERBIFs4MDg2OjhjMjBdDQoNCiAgKg0KDQogICAgUENJIHN1
YnN5c3RlbTogWzgwODY6NzI3MF0NCg0KICAqDQoNCiAgICBBdWRpbyBjb2RlYzogQ2lycnVzIExv
Z2ljIENTNDIwOCBbMTAxMzo0MjA4XQ0KDQogICoNCg0KICAgIERpc3RyaWJ1dGlvbjogRmVkb3Jh
IExpbnV4IDQ0IEtERSBQbGFzbWENCg0KKldvcmtpbmcgS2VybmVsOiA3LjIuMTUtMjAwLmZjNDQu
eDg2XzY0Kg0KDQpLZXJuZWwgbG9nczoNCg0KfENTNDIwODogcGlja2VkIGZpeHVwIGZvciBjb2Rl
YyBTU0lEIDEwNmI6MDAwMCBhdXRvY29uZmlnIGZvciBDUzQyMDg6IA0KbGluZV9vdXRzPTIgKDB4
MTIvMHgxMy8weDAvMHgwLzB4MCkgdHlwZTpzcGVha2VyfA0KDQpCb3RoIHNwZWFrZXIgb3V0cHV0
cyBhcmUgaW5pdGlhbGl6ZWQsIGFuZCB0aGUgIkJhc3MgU3BlYWtlciIgY29udHJvbCBpcyANCnBy
ZXNlbnQuDQoNCipSZWdyZXNzZWQgS2VybmVsOiA3LjMuMy0yMDAuZmM0NC54ODZfNjQqDQoNCktl
cm5lbCBsb2dzOg0KDQp8Q1M0MjA4OiBwaWNrZWQgZml4dXAgZm9yIFBDSSBTU0lEIDgwODY6NzI3
MCBhdXRvY29uZmlnIGZvciBDUzQyMDg6IA0KbGluZV9vdXRzPTEgKDB4MTIvMHgwLzB4MC8weDAv
MHgwKSB0eXBlOnNwZWFrZXJ8DQoNClRoZSBzZWNvbmQgc3BlYWtlciBvdXRwdXQgKHBpbiAweDEz
KSBpcyBubyBsb25nZXIgaW5pdGlhbGl6ZWQsIGFuZCB0aGUgDQoiQmFzcyBTcGVha2VyIiBtaXhl
ciBjb250cm9sIGRpc2FwcGVhcnMuDQoNCipTdXNwZWN0ZWQgQ2F1c2UqDQoNCkkgY29tcGFyZWQg
dGhlIENTNDIwOCBrZXJuZWwgbW9kdWxlcyBmcm9tIGJvdGggdmVyc2lvbnMgYW5kIGlkZW50aWZp
ZWQgDQphbiBhZGRpdGlvbmFsIHw4MDg2OjcyNzB8ZW50cnkgaW4gdGhlIGhhcmR3YXJlIGZpeHVw
IHRhYmxlcyBvZiBrZXJuZWwgNy4zLjMuDQoNClRoaXMgYXBwZWFycyByZWxhdGVkIHRvIHVwc3Ry
ZWFtIGNvbW1pdDoNCg0KODJjZmFiNmE1MjYyMWZlYmYzNjc1MmJkNWVkNTE4NGY4MmM5NmUwNw0K
DQpodHRwczovL2tlcm5lbC5nb29nbGVzb3VyY2UuY29tL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90aXdhaS9zb3VuZC8rLzgyY2ZhYjZhNTI2MjFmZWJmMzY3NTJiZDVlZDUxODRmODJjOTZlMDcg
DQo8aHR0cHM6Ly9rZXJuZWwuZ29vZ2xlc291cmNlLmNvbS9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGl3YWkvc291bmQvKy84MmNmYWI2YTUyNjIxZmViZjM2NzUyYmQ1ZWQ1MTg0ZjgyYzk2ZTA3
Pg0KDQpUaGUgY29tbWl0IGFkZHMgc3VwcG9ydCBmb3IgYSBNYWNCb29rQWlyNywyIGNvbmZpZ3Vy
YXRpb24gdXNpbmcgUENJIA0Kc3Vic3lzdGVtIGlkZW50aWZpZXIgODA4Njo3MjcwLCB3aGljaCBp
cyBhbHNvIHByZXNlbnQgb24gbXkgTWFjQm9va1BybzExLDQuDQoNCkkgc3VzcGVjdCB0aGF0IHRo
ZSBuZXcgbWF0Y2hpbmcgZW50cnkgY2F1c2VzIHRoZSBkcml2ZXIgdG8gc2VsZWN0IGFuIA0KaW5h
cHByb3ByaWF0ZSBzcGVha2VyIGNvbmZpZ3VyYXRpb24gZm9yIHRoaXMgTWFjQm9vayBQcm8uDQoN
ClRoaXMgY29tbWl0IGlzIGEgc3VzcGVjdGVkIGNhdXNlIGJhc2VkIG9uIGRyaXZlci10YWJsZSBj
b21wYXJpc29uczsgSSANCmhhdmUgbm90IHBlcmZvcm1lZCBhIGZ1bGwga2VybmVsIGdpdCBiaXNl
Y3QuDQoNCipFeHBlY3RlZCBCZWhhdmlvcioNCg0KQm90aCBpbnRlcm5hbCBzcGVha2VyIG91dHB1
dHMgc2hvdWxkIGluaXRpYWxpemUgY29ycmVjdGx5LCBwcmVzZXJ2aW5nIA0Kbm9ybWFsIGJhc3Mg
cmVwcm9kdWN0aW9uIGFzIG9ic2VydmVkIHdpdGgga2VybmVsIDcuMi4xNS4NCg0KKlJlcXVlc3Qq
DQoNCkNvdWxkIHRoZSBBTFNBIGFuZCBGZWRvcmEga2VybmVsIG1haW50YWluZXJzIHBsZWFzZSBp
bnZlc3RpZ2F0ZSB3aGV0aGVyIA0KdGhlIG5ldyBDUzQyMDggUENJIHN1YnN5c3RlbSBtYXRjaGlu
ZyBsb2dpYyBpcyBpbmFkdmVydGVudGx5IGFmZmVjdGluZyANCk1hY0Jvb2tQcm8xMSw0Pw0KDQpJ
IHdvdWxkIGFwcHJlY2lhdGUgZ3VpZGFuY2Ugb24gYSBtb2RlbC1zcGVjaWZpYyBmaXggb3IgYW4g
dXBzdHJlYW0gDQpjb3JyZWN0aW9uIHRoYXQgcmVzdG9yZXMgYm90aCBzcGVha2VyIG91dHB1dHMg
d2l0aG91dCBhZmZlY3RpbmcgDQpNYWNCb29rQWlyNywyIHN1cHBvcnQuDQoNCkkgY2FuIHByb3Zp
ZGUgYWRkaXRpb25hbCBBTFNBIGNvZGVjIGR1bXBzLCBrZXJuZWwgbG9ncywgYW5kIGRyaXZlciAN
CmNvbXBhcmlzb25zIGlmIG5lZWRlZC4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciB0
aW1lIGFuZCBmb3IgbWFpbnRhaW5pbmcgTGludXggYXVkaW8gc3VwcG9ydC4NCg0KQmVzdCByZWdh
cmRzLA0KDQoqDQpBcmxvdSBLaWVyIE1vdGFzKg0KDQoNCg==
