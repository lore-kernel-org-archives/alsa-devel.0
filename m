Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F800C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:02:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972A72072E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Nn43HLpL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L3xg3C07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972A72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB456886;
	Mon, 30 Mar 2020 13:01:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB456886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585566154;
	bh=vA5kP4YoD5QNLRZTtk8pw6d1NTIS3Zq3p11fvMnzam4=;
	h=From:To:In-Reply-To:Subject:Date:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nn43HLpLAtDuLiTQNDFcL2bfXBvwUarpcKelin5CAwHF7Kp/GZTRD/a7Ax+n39kzD
	 HrgpKqc9kWEOD10lmtPLjYG9ZquVCbS3tQjt9zHUuonm5mDwWHY25ENOxNRHXumYHQ
	 LluPmZMRrZupKNDs1mMhoYDP/8JvNfgCD8R/dXrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5930EF80145;
	Mon, 30 Mar 2020 13:01:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5052FF8014A; Mon, 30 Mar 2020 13:01:40 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28346F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 13:01:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28346F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="L3xg3C07"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200330110129epoutp011e90590c178fc73e22cb69d8878cc844~BD-UgSNmQ2931729317epoutp01P
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 11:01:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200330110129epoutp011e90590c178fc73e22cb69d8878cc844~BD-UgSNmQ2931729317epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1585566089;
 bh=MQz6au9t7RhlfPGqj1gl+iff4rqukL8/zcHs4Txl4H8=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=L3xg3C073g/ioBrs5UG1+7Yah5RfhcknvI0BE578VHLQeVio25FLFWQXcnqxtHRTg
 oiRLKpJbfmsP+K8aTUEyBKBZkveZ4lo0PKH7+V3XsW2QkKwWQrov5PRTTeXrZtmPxO
 Q9nFg6ms/tnmefs/GzuuPle8E9mcmGligzL3hvYI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20200330110128epcas2p38a6927f73dcbdd44ce0b8c5f343cab14~BD-Tvx-1Q3132131321epcas2p3z;
 Mon, 30 Mar 2020 11:01:28 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 48rTzW28BVzMqYkf; Mon, 30 Mar
 2020 11:01:27 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 67.99.04142.681D18E5; Mon, 30 Mar 2020 20:01:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20200330110126epcas2p291039a9be404c41725d3577e4cd3058f~BD-RlBuoW0056700567epcas2p29;
 Mon, 30 Mar 2020 11:01:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200330110126epsmtrp11b14387bd84a4dcc7f848479ea94d0b4~BD-RkYXqT3044230442epsmtrp10;
 Mon, 30 Mar 2020 11:01:26 +0000 (GMT)
X-AuditID: b6c32a46-3f9ff7000000102e-d0-5e81d186c0f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.FC.04024.681D18E5; Mon, 30 Mar 2020 20:01:26 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20200330110125epsmtip1311c31f543169836448f4982807b438b~BD-RX-ewt1313613136epsmtip1V;
 Mon, 30 Mar 2020 11:01:25 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMyw5sXD?= <gt82.lee@samsung.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <vkoul@kernel.org>
In-Reply-To: 
Subject: [PATCH 0/1] ASoC: soc-compress: lock pcm_mutex to resolve lockdep
 error
Date: Mon, 30 Mar 2020 20:01:25 +0900
Message-ID: <002001d60682$8e75d390$ab617ab0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYDRPHUoYNwKO+GQXuXdl19rDmHIgDO0GCg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6YBWx4J4giaWUR/EoG11cFBxiWia4NLog0oIdUInQOyW
 TtuIvuDWFDSKCwhlU1DjhlYsCg9GraIIYoKCG5igYhSISwQlEiS2nZr07T/nfuee8997SExR
 SsSTeWY7bzNzRpqIxm89mM8kuTr3Zala/YlsV6dfwpa87yfY311uCesdrUdsc28rtlqq9Q7v
 J7TNnncybcPlQkJ73deN6/AM44pcnjPwNiVvzrYY8sw5qXT6Vv1aPZOsUiepU9iltNLMmfhU
 Om2DLml9njHQmFY6OaMjkNJxgkAvWrnCZnHYeWWuRbCn0rzVYLSq1daFAmcSHOachdkW0zK1
 SqVhAuROY+5IVZ/UWiHbfd/diBegMWkRiiKBWgIuV6esCEWTCqoJwVD7CBKDnwhKjxzHxOA3
 gosnR/H/Jf0f6kPlCuoOgtFWpwgNIKga9gUgkiSoZXDkMB1kYqltUHu6JMRjVAJ8HK8MIVGU
 HIonlgfTMdQWeH7zhySocWoelHW3EEEtp1JgrKcOiXoaPCnvx8VrNHDuSo1E1LPh9tdKTBxN
 CX8+XZCKbTXwuqYUiUwsVBS6Ql6AekFA+Y+esP00eOorR6KOgcHHPpmo42HgmEsmFhxA8K1j
 PHxwCkHhYYWoF4Ovqk0SNAPUHHj4NjzcFHA/+CsT03Jwu8I0DTfaJsI0QLVXVoxoT4QzT4Qz
 T4QzT4SDMwi/jOJ4q2DK4QWNVRP51w0otJOJ65vQuWcb/IgiET1ZXtZYkKWQck4h3+RHQGJ0
 rJzYHEjJDVz+Ht5m0dscRl7wIybw8sex+OnZlsCGm+16NaNJTlalMCyTrGHpGfKGSW8yFVQO
 Z+d38byVt/2vk5BR8QXobIyubVXCwOSPXtQnOL7PgdRHbM295rlN+w4x+TsWDJ9X6Mc217o3
 1Y/PTi/+9UnvTPx8Qu+d1fqSrmDU31NOft1Rt3Hs2tW7a5yVLb2ZvVhcnPbMUNHI1S+61Y5F
 JyZUmO3olint0XvHz7avq6YOZvyd2nLwUulMX8fgdo8hr+MVjQu5nDoRswncPwb79S+pAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTrftYmOcwc99zBZXLh5ispj68Amb
 xbcrHUwWG76vZbTYeecEswOrx4bPTWweO2fdZffYtKqTzWP9lqssASxRXDYpqTmZZalF+nYJ
 XBlf5j5gLZjNXnGwYytLA+Mv1i5GTg4JAROJJ4/WAtlcHEICuxklFs/6zA6RkJD4MP8MlC0s
 cb/lCFTRc0aJ78+WsnQxcnCwCVhJ9HQrgdSICERLzGlbzQZiMwsoSjz+M4cFxBYS4JF4tWE/
 I0g5pwCvxIR/1iBhYYEAiZ5FnxlBbBYBVYkZV4+CtfIKWEr8ur2YEcIWlDg58wkLxEgTicbD
 3VC2vMT2t3OYIU5TkPj5dBkrxAlGEjfmT2OEqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZ
 VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeLluYOxstL4g8xCnAwKvHwftjeECfE
 mlhWXJl7iFGCg1lJhJfNHyjEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC
 1CKYLBMHp1QDYxdnWc+p62uuFM5atkfkvEKSIXvHEu/z+7ee1a3jP2b4tGDCzpdt9gbO4Yc/
 ylh2f2MQMJR72Par+5rGt/MHY/XvsDVum29dE3mi9kDE36PpRssfbD4k9lzU8PGHFCHOoBuL
 oyTuWM56LSsXeH2SRZuM2rV5MmWVf1sfMp3Tn/P4rL3Kf60YGSWW4oxEQy3mouJEAMOGifyT
 AgAA
X-CMS-MailID: 20200330110126epcas2p291039a9be404c41725d3577e4cd3058f
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330110126epcas2p291039a9be404c41725d3577e4cd3058f
References: <CGME20200330110126epcas2p291039a9be404c41725d3577e4cd3058f@epcas2p2.samsung.com>
Cc: alsa-devel@alsa-project.org
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

Hi, Mark

I resend the patch and add recipient Vinod as your comment.
Thank you.


I'd like to send a patch to fix a problem using soc-compress with DPCM.
soc_compr_open_fe() and soc_compr_free_fe() call snd_soc_runtime_activate()
and snd_soc_runtime_deactivate() but don't lock card->pcm_mutex.
It can cause lockdep error, because snd_soc_runtime_activate/deactivate()
checks whether pcm_mutex is held using lockdep_assert_held().
I'd like to send a patch which adds mutex_lock/unlock() before and after of
the snd_soc_runtime_activate/deactivate() call.
If there is anything should be changed in my patch or email, please let me
know it.
I'll really appreciate it.

Lee

Gyeongtaek Lee (1):
  ASoC: soc-compress: lock pcm_mutex to resolve lockdep error

 sound/soc/soc-compress.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: 76ccd234269bd05debdbc12c96eafe62dd9a6180
--
2.21.0


