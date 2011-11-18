From: =?UTF-8?B?5L+e5pmT56OK?= <elioxia@gmail.com>
Subject: newbie questions on alsa architecture (e.g. who reads
	.asoundrc)
Date: Fri, 18 Nov 2011 17:29:51 +0800
Message-ID: <CAPCpjV=w4SZjPgBbQ7anVTCpOCADnGUcTPpPtp9t7mdn8zuwrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D68B0103823
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 10:29:52 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2361391ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 01:29:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hello
i recently found that a few android devices build their audio stack
upon alsa (SGSII for example), and become interested in creating an
audio output capture application through alsa api (since android stack
does not support such feature)
Some tutorials suggest .asoundrc tweaks work for pc, so i want to know
what happens when a copy device line is added to the conf file, and is
that possible to achieve the goal through plain api calls.
i'm ok if a kernel rebuild is necessary, just hoping to dig into alsa
a little deeper.
