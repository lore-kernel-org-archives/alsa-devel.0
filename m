Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F8C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 11:41:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D221239A4
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 11:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D221239A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9D5E16CB;
	Fri,  8 Jan 2021 12:40:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9D5E16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610106098;
	bh=wCJYiZ5Ea8OORItaNLMjZkLzWNC3zvC9kLRyYB16Xpk=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J/FAiT+e6KBRDvfwv1Rv1hsD1sX4TC1eM9gpsUmBEb6X5VrX5wUVxxYGYBhvy9oG1
	 ptJvZqyVsLqGbFpDWfGkODmH/rYU6ghhy6DvF5sDcfeWGVeHP05PHvyk9Lc+2DkDTO
	 CupMYtPHaKmaI6DuiVyH0+VnoZp6qmPpdX2gDYV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24773F800FD;
	Fri,  8 Jan 2021 12:40:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E264F80166; Fri,  8 Jan 2021 12:40:44 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED944F800FD
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 12:40:36 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 11BB9A0040;
 Fri,  8 Jan 2021 12:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 11BB9A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1610106031; bh=LVgdo2oJdl5Xv4zAG00+Wp03Wd9IkhXVTQ34Cm9L3v8=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Mw7KM8gGznHd8dVMhAOZyMumPcZVCutUfbBgkpkzAqBPurbhdleuR1HxOf3CiXNN+
 IBL/Kd2ovy6S8tlqtK7/NXmP/GCAMIHU2P9d/d/szQ1Dk15yAXMXWWA5bZW+bg9BRS
 fGY0Q4auX7nAxxfRvCF+JZcdbxO6IYzvFeD/9LSo=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  8 Jan 2021 12:40:28 +0100 (CET)
Subject: Re: [RFC PATCH 1/3] ALSA: control: add kcontrol_type to control
To: Jaska Uimonen <jaska.uimonen@linux.intel.com>, alsa-devel@alsa-project.org
References: <20210108112355.2053917-1-jaska.uimonen@linux.intel.com>
 <20210108112355.2053917-2-jaska.uimonen@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <1272f71c-c736-d267-563e-c2bf43b740da@perex.cz>
Date: Fri, 8 Jan 2021 12:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108112355.2053917-2-jaska.uimonen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 08. 01. 21 v 12:23 Jaska Uimonen napsal(a):
> Current kcontrol structs don't have a member to describe the control
> type. The type is present in the widget which contains the control. As
> there can be many controls in one widget it is inherently presumed that
> the control types are the same.
> 
> Lately there has been use cases where different types of controls would
> be needed for single widget. Thus enable this by adding the control type
> to kcontrol and kcontrol_new structs.

It looks like a SoC only extension. Use private_data to carry this
information. It has no value for the toplevel code.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
