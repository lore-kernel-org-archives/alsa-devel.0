Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9E5C677F1
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 19:37:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AB75B00E;
	Fri, 13 Jan 2023 20:36:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AB75B00E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673638661;
	bh=VzzAdGwmoxwimvqLcoG8+cmSGhF4PD4xtuhgxBqOI4c=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Vz8bDYRQ9MmydVT9J6OoT0GCzAnlPnjroD9vqvIvGfFIhT9zUNWbPKUyTK8GkTso3
	 kcNIpELjTZPdfLL/61nAVz9+W3012pCDYHU1NQpUkv1oGeQo2JOKj9lBmfR3Q1+PdZ
	 hWYh4MsTB9NHLskMP97ajRBNyu98Z4w8UID/oCsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 168EEF802E8;
	Fri, 13 Jan 2023 20:36:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB1C1F8030F; Fri, 13 Jan 2023 20:36:49 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52D8CF8019B
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 20:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52D8CF8019B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=ORiYY1wn
Received: by mail-pl1-x62c.google.com with SMTP id d15so24433268pls.6
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rYqri1Hsodo96403V/CNTOVaRrTuVHHTBkoiYeX7lwI=;
 b=ORiYY1wnYAYZZ6QeQDujBsfpACxvl7al8b1S9MuU6gOjtkgowYaLGC09q48a0NFmlF
 dvoSfj1ylsWCzf0txRIYsQyPca9sVqz+KUTL1PWcad0Kvw9rkmpZXNo7TQOw4hfgOZj1
 7cjFtGdK6dmu3hWZAdZei0QW0jQEkGK9LeRZvIaOOq4tZLWIlD6P6eZZ/u3jbPFzkZof
 7TjclBxn3di3DTOOFq5OW9nhq+Bd0eZj58s/M+fcPJQRurDs6PE6Bn8s9nXJhY4dVQGZ
 LaiKbB8dnid5jJ4MfstJBJHyRoUqDQgMy1heB00VYEEqCBWW9VmsO3o6Haz488hC/cY5
 xnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYqri1Hsodo96403V/CNTOVaRrTuVHHTBkoiYeX7lwI=;
 b=RaGYPZVmFEa7qNb3adUS6gjpdIwrfQfeVyB25+5yEZuL8bX2//F0c5RNRscRTJfXW/
 WrBGsPLOLdoFI3AP0l4qMrYi7iFTjbZlpz7l1i1DhCjOO9rvPLkqzvrEsSnp7AZrzvKB
 x7g+ogK/yrqy63YuAxlYln5kQpgzw9AKalDCPiBv5H4WoLn/Y0W8TsUloYIMlHfOAsmo
 7UzkbWQ02+hELB+MMJRhV28vH7LEtSkQoKN2MAAVcIVOHuBonMJ2Kj4EQHXkL/G97p4n
 SEAIdLtwLzh/faflMUZkMR5WeOiIttmjRb/CTE2zcOAUy2eXmsHOrXtj54RiRpbfpRZy
 47gQ==
X-Gm-Message-State: AFqh2kplXuAV9UD/U7Ug/D9D0kabclMCVTvaLMABc9twAfqGaOZrAgKZ
 +ofNEli595wI9pKp7aR7BduunHsQh5bmVHre4a/XMA==
X-Google-Smtp-Source: AMrXdXuYgOY46ANXq1EHwp8i9xXzgfzaNVi7rMcjNBJf3xS16sNppUj78+q9b0lec3fCYYJ/0qJc39+uBhkCdsqKoAE=
X-Received: by 2002:a17:90a:5b:b0:227:203c:6071 with SMTP id
 27-20020a17090a005b00b00227203c6071mr1691728pjb.167.1673638603567; Fri, 13
 Jan 2023 11:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20230112234426.1714071-1-cujomalainey@chromium.org>
 <20230113185019.1500147-1-cujomalainey@chromium.org>
 <43beedbe-05e4-1c11-a27a-b2e3ca002935@perex.cz>
In-Reply-To: <43beedbe-05e4-1c11-a27a-b2e3ca002935@perex.cz>
From: Curtis Malainey <cujomalainey@google.com>
Date: Fri, 13 Jan 2023 11:36:32 -0800
Message-ID: <CAOReqxhnCn2o6MAk0WpGGjObYp=M_gihZHO=zynbYkww-=kGHg@mail.gmail.com>
Subject: Re: [PATCH v2] ucm: add existence checks to geti calls
To: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: cujomalainey@chromium.org, alsa-devel@alsa-project.org, tiwai@suse.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Jan 13, 2023 at 11:32 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> On 13. 01. 23 19:50, cujomalainey@chromium.org wrote:
> > From: Curtis Malainey <cujomalainey@chromium.org>
> >
> > Right now in snd_use_case_geti you cannot tell if the item being queried
> > exists or not when being checked. This also means the only way to check
> > for the existence of something in the client of the library is to
> > iterate over the list of mods/devs even if we know exactly the name we
> > are looking for. We have functions that do exactly this internally so
> > lets return this information in a logical fashion through geti.
>
> The device_status/modifier_status functions are used internally, too.
> I would add the device validation only to the geti code. The other parts do
> this job already and expect just 0 or 1 return values.
>
>                                 Jaroslav

Understood, I will move it back to geti directly, figured this was the
cleanest place to put it but that makes sense if other places use
those internal functions.

>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
