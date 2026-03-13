Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52971F013CA
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:37:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07E6D601F1;
	Mon, 16 Mar 2026 09:37:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07E6D601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773650251;
	bh=9faPPi2nAlNZZ4GYdARQ+/iG5HNyPgcy6nGQMncAZxE=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=auyW6y9oHIHgZFhrDWZQAIkl5cGT9hMVuFLGN3jhOcaFXFgRc2DvjmM/F0r1bnFGe
	 D6yGtpqosYWjYRIM/xsrLHs2t4EtidJZ0IhA47Yn1EVqM8HwwEwPChLlLhiYmSwxs9
	 nw3QMMYzP/Zmw0C7X8CSSNjd/ttrziKNz7KRyzyM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 840DFF805F2; Mon, 16 Mar 2026 09:36:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 764CFF805F4;
	Mon, 16 Mar 2026 09:36:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DAF1F804B4; Fri, 13 Mar 2026 16:17:42 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66E24F8015B
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2026 16:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66E24F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=NfEg4hRh
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-82990763921so2097599b3a.1
        for <alsa-devel@alsa-project.org>;
 Fri, 13 Mar 2026 08:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415058; cv=none;
        d=google.com; s=arc-20240605;
        b=MNjm6jAGUm3QipVudWfbCxCZm+aGjhwL5Z3+J0Of/e0ytQFWv4lBz7zzwwV4G408DS
         QC8VRxFgvxfZ6kXcIMU1tbWJmOqty1wcXwDcDMgJ38se18x9W8CN6ZGYkRIuWOVUaFUu
         LDOrE8XEZIBaw9g1RatIduHwLTxXg1QafRETq5xFbf5wet//zQ4G8c9CvV4c+NgIU4RX
         HEMFESwoccejZJo3ZWZfr6q2KCf8JB1oLTJ+/CcdMgjP/cilRe06uFZFx53kM/tCL972
         MODzRKRCcdGum7vn0o9/SBzUiSp8TW4xKhHUy7hYoelvQfSshEbqj6YhywbZezmFtGEy
         d0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pDw4RaVps1YsEhX4aaQP2hiHFBHLn4pf/Mel4xCWt6g=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=Vof8d+B/iXW49ZKt2MObD5OdvuS8gqx9k8zNLyS5GWxbXf1WhafeI7cnJht7GI93Qa
         R9RCUJMMo9+Yqj2MHRGuMXoW3jqP86nsczlE8hHSp9K++PhBT9UzovIrXFJc5IHUH02B
         QXXnOoLcZU0inInfwT1JkhW5AJ7IP9eYw7QWHGY1EU30NeabpRPmkt+5iAMzONc1GHSg
         fN0Fo3TxEkDgu1JB9Epznx/SgJK8pEQlAvooswh7gvx74kllRSL39fjx68a/Fxtee4kS
         p+ae2Mxi8jj82LCtSiKs/1kLD1EhWQ0qASVmCs7S4R9VqwgbfrtsEIsxSmx+Ww4+ZMYn
         slig==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773415058; x=1774019858;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDw4RaVps1YsEhX4aaQP2hiHFBHLn4pf/Mel4xCWt6g=;
        b=NfEg4hRhVC3W/Epgblmen254uc/0Qx9THzzlEyMW0eZ1AA2jWlCs/EKM9N7RsWcOzm
         gvMsRdhDTvbic/KXrSv9zEHb8amlcb6PLO0+OVRzBtQh2OeSu/6/a43OGXfo5adX3nkc
         4xmggrWlHH7pLV2iZHOGRYrwFu06fesgCanw6S2fDSXgoGXeFAFR3a+S1blWt5uqgmp5
         A8BudkvdsN+etEsMX0Bfps3MaECTissPXmxZ+LKPjkQSltAQRAKnie8US5NS7Lixh9+g
         vUklTSTCc7fto24FfeNlC7w0f6lgroM1Brj8Mc2b4PfCY6iqqq8uyfIVpkKwdvUyfZO2
         1sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415058; x=1774019858;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDw4RaVps1YsEhX4aaQP2hiHFBHLn4pf/Mel4xCWt6g=;
        b=nqolw1wA/vT+QzD2CSQaB51ryeFfp6zO9X0v5rkN9q2xGYlPbf1jbCvJgLvSVsMYFL
         ayszHKpfAn85LrRrJ75/aI+emBedD1IOJsT26REJgG1ZGNqAbQPwjUd2DcPmmZrAEJjd
         M3m2d5/qjXDkIh4E3qGOWCicAkb3t+qfWlIOpYjRizpYNlnhmGVnZqecluSpA+69OU+s
         yTB9qROz40uPVEhMLWjiS8XuIdJMCngUHHjHkw3jjb20YSCkcfSxsTUDrBjjkMwxcJxD
         J3wDs2a/Be5rx9lsE0W9bOVEAWCihL6UqHEqWdpI1h8M7sUxRhouk+3xdViDwk+5LsVC
         cD+w==
X-Gm-Message-State: AOJu0YwsgYoLOYXt5MgQfTRF9AoBNaf5uREqTCCLFTP0FVj+eiwGeyqJ
	BsQ23mjP3ajHqTp23MYBbllGV7AS7pFwGHjewA8IrjlsyKVmpbv7VGor7JecnfWvS3931lsJOnI
	kIeP6PlhqpPOjBPbte0zEJpe0fE6t+yZe4RVX
X-Gm-Gg: ATEYQzyqlooR2xzd7xc4xXUYd8UWr2acXr1pn2/jzCKZM0f0U0+LlNtuKQKpIPoFzV2
	NDiMIDHxeSzSwEEQyuycUE0ss31PUMUMUSiRXE296cQWStpKfesR9I8vdCysO/SY7c5vS1JAcd4
	i0vvLq+uTMePgDt0IQULEdpLUpH8YFzjSh+aZwurPHCOtLuG0nsrJYiN8Wbx4qI2ixOX6ldDKIl
	xaCWl0yTkYBgGU5d5gFWhkeQuT/1HYUU2RUS59OOmZMQqreD1rhhpyA6xwQ11+5WduOa83W3VsJ
	WDwWrs051H37eROx6uFTCHGbi1B0NavpO6x411VJ/tqMT6pSMykciBAWDa3syKkDWo/+gD+wYS+
	7eee3shwiy89hHgWxNbZNkLFo
X-Received: by 2002:a05:6a00:2ea7:b0:824:960d:193e with SMTP id
 d2e1a72fcca58-82a19901ec7mr3507406b3a.45.1773415057382; Fri, 13 Mar 2026
 08:17:37 -0700 (PDT)
MIME-Version: 1.0
From: Ezequiel Rifos <renzorifosezequiel20@gmail.com>
Date: Fri, 13 Mar 2026 12:17:25 -0300
X-Gm-Features: AaiRm53bRvFGyH8YRgJZTYA7frQ_HJUwIYsGgxNbJoL5SlK4ZLQIyaQn6jRjKJc
Message-ID: 
 <CAEVzTF4UD9KrUq6_HAfROxZ+=fWX=qLRT_Ddkk1T=GzuVtvHFQ@mail.gmail.com>
Subject: [PATCH REQUEST] Acer Aspire AL16-31P - ALC269VC internal speakers not
 working - Bug 221224
To: alsa-devel@alsa-project.org
X-MailFrom: renzorifosezequiel20@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: E4MPO4URDGYCH7JSZSVWIGWNMDFM7MQH
X-Message-ID-Hash: E4MPO4URDGYCH7JSZSVWIGWNMDFM7MQH
X-Mailman-Approved-At: Mon, 16 Mar 2026 08:36:47 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E4MPO4URDGYCH7JSZSVWIGWNMDFM7MQH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjEyMjQNCg==
