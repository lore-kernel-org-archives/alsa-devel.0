Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 15:54:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C076023F
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 15:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9C076023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CC1A1616;
	Tue,  9 Nov 2021 16:53:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CC1A1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636473253;
	bh=jZljM6Yz3r3gIZRndW1XS7ZfDTdgZ4nQxuPpUlMf0CA=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IowyW6rHa7hie3AX16lNBwe3T9TG4YYCH25xFSEYlZ5wR9qZYFnG/efDiLvZY3eW5
	 MB1NHdWex2FiVslFEJy9YM9rYIf0YxFcojaWVaDB+GK0EeFAFgaVWuf76ZvssFKwvt
	 BFKire4RomJq4IhzQOcGQxkT90wo5x58UiS1F18E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F7BCF800C9;
	Tue,  9 Nov 2021 16:53:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C1BCF800C9; Tue,  9 Nov 2021 16:53:21 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB56DF800C9
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 16:53:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB56DF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GjRJK5Po"
Received: by mail-wm1-x333.google.com with SMTP id
 o4-20020a1c7504000000b0032cab7473caso1966330wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2021 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language;
 bh=6e7Y2jSfhQdl+F9WbSrI8qqZG5X/wkXiL9DZwnMc+dg=;
 b=GjRJK5PoAAd68WKKHvtJYMtLOlgBjFGd5hR8j71UO6Bb0x95AZ+UQYRNKCGPJ+y38n
 CZSGpaZG08004VYQe34YEabWV+GcwzVkrZPj0xv6A64Ksj/WgSoYDj1oCS6yid1wWbtH
 1wMitrTlPIvTUvZDRtO5Q1YoybEaiafCWIoWTl0eHKxjBDpnWObMZRKVr2xWsQqld0VO
 NJFK5y37K7/QmoUNyTsdx9V+7us4afb3JHKgmYEQ5kPDbQGj+BmSYQq5ClLX568ula1d
 +oYYbs6/DhyIXjI3nItHRPnULXaMANMhHm9GPGfGGB1dV3i1psIa6ZRbJJ8Gc7tQv2rQ
 3+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language;
 bh=6e7Y2jSfhQdl+F9WbSrI8qqZG5X/wkXiL9DZwnMc+dg=;
 b=0Wkf4JHIuJgePtrWIhNJbMtlWil2+UjA4j9YZM0DudTqH1txvErDSFK4nG+qc6L0Wf
 wBb3SuxlSXQs5cRzlqIphi6Qnhf75qoCgpPdQLWFD4+m0k6LU7efPupD8Dk5fC9jL35t
 lnbkcSrV0zJHobYRsBkpAhN+ShWvzQ1eILtzPJHaGD/ABMN6wPz+cRwwmRYcuA/RTyPD
 RF61Cu9uP21j0KTMy0BTbBHSnFMcgxBYXMpmjV0WtuLqrQxj2CPR7VhvqJOU3RQPPAv5
 d4l23D4UoLp+WaCBVGJ/SfSoFl642NUNm4zvX61Cerg7bBphSgrezqOXk2K2UnNVOVXV
 IaiQ==
X-Gm-Message-State: AOAM53212IYZ5S+4QisqUPwAqW3I4qhL4RA+mKnvy8t8rXFD45XfQAlc
 q1Y+cwbKzE0zqdcroDMfT2sAJCM4d0o=
X-Google-Smtp-Source: ABdhPJyL92FBdLVCMxub4HTd5w2QkQHWPJwR2u9oAdfRXIW5DctNspBm+HrfDLtWi3ZeGeJTuPUOOw==
X-Received: by 2002:a05:600c:202:: with SMTP id
 2mr8376664wmi.134.1636473196839; 
 Tue, 09 Nov 2021 07:53:16 -0800 (PST)
Received: from [192.168.21.204] ([31.185.172.54])
 by smtp.gmail.com with ESMTPSA id u15sm3083563wmq.13.2021.11.09.07.53.16
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Nov 2021 07:53:16 -0800 (PST)
To: alsa-devel@alsa-project.org
From: Alan Young <consult.awy@gmail.com>
Subject: [PATCH] ALSA: ctl: Fix copy of updated id with element read/write
Message-ID: <d0c9ba7f-56e5-3462-465b-1b6b6c0d856b@gmail.com>
Date: Tue, 9 Nov 2021 15:53:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1450B8D93D9CB29AFCB8870A"
Content-Language: en-GB
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

This is a multi-part message in MIME format.
--------------1450B8D93D9CB29AFCB8870A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------1450B8D93D9CB29AFCB8870A
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ALSA-ctl-Fix-copy-of-updated-id-with-element-read-wr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-ctl-Fix-copy-of-updated-id-with-element-read-wr.pa";
 filename*1="tch"

From 8dfd143c2e05405bc1f61107c5858eab9c5fc847 Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Mon, 8 Nov 2021 12:39:56 -0500
Subject: [PATCH] ALSA: ctl: Fix copy of updated id with element read/write

When control_compat.c:copy_ctl_value_to_user() is used, by
ctl_elem_read_user() & ctl_elem_write_user(), it must also copy back the
snd_ctl_elem_id value that may have been updated (filled in) by the call
to snd_ctl_elem_read/snd_ctl_elem_write().

This matches the functionality provided by snd_ctl_elem_read_user() and
snd_ctl_elem_write_user(), via snd_ctl_build_ioff().

Without this, and without making additional calls to snd_ctl_info()
which are unnecessary when using the non-compat calls, a userspace
application will not know the numid value for the element and
consequently will not be able to use the poll/read interface on the
control file to determine which elements have updates.

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
 sound/core/control_compat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 470dabc60aa0..edff063e088d 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -264,6 +264,7 @@ static int copy_ctl_value_to_user(void __user *userdata,
 				  struct snd_ctl_elem_value *data,
 				  int type, int count)
 {
+	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, size;
 
 	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
@@ -280,6 +281,8 @@ static int copy_ctl_value_to_user(void __user *userdata,
 		if (copy_to_user(valuep, data->value.bytes.data, size))
 			return -EFAULT;
 	}
+	if (copy_to_user(&data32->id, &data->id, sizeof(data32->id)))
+		return -EFAULT;
 	return 0;
 }
 
-- 
2.25.1


--------------1450B8D93D9CB29AFCB8870A--
