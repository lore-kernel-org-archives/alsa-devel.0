Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F01C433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370A920678
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MdmgODuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370A920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C88BA16A4;
	Wed,  2 Sep 2020 17:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C88BA16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599061132;
	bh=0naeiIRPUqcMGm3YwKR8T3w6GAHDh21uvIk5OiuBsOY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MdmgODufjLvF/Kf4OjFkFmIuwKG1YI28iHvFlbMQ6UIst6CmfJOMzv+Oo5DJfePIW
	 4fGKPhUrPImT/KLjKedI6j0OUiO0zVHcLSblyW57NkeZgKYKu388ZwmJCfAeTW0Seg
	 3pUupDATGLfKrt031bGKAmvxVKah6X9Zcb5eYYlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CCB1F80212;
	Wed,  2 Sep 2020 17:38:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44C2DF8024A; Wed,  2 Sep 2020 17:38:01 +0200 (CEST)
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 528A4F800BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 17:37:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 528A4F800BA
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kDUnK-009LqU-QO; Wed, 02 Sep 2020 15:35:30 +0000
Date: Wed, 2 Sep 2020 16:35:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: general protection fault in snd_ctl_release
Message-ID: <20200902153530.GK1236603@ZenIV.linux.org.uk>
References: <000000000000c15ee205ae4f2531@google.com>
 <s5h36409pbb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h36409pbb.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, maz@kernel.org, tiwai@suse.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com
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

On Wed, Sep 02, 2020 at 05:22:00PM +0200, Takashi Iwai wrote:

> Marc, Al, could you guys check this bug?

That's racy; the first one should be get_file_rcu() instead of
file_count()+get_file(), the second is not needed at all (we
have the file pinned down by the caller).  See vfs.git#work.epoll
for fix
