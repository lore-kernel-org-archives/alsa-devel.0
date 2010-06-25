From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 00/16] ASoC: multi-component - CODECs
Date: Fri, 25 Jun 2010 18:52:47 +0100
Message-ID: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DF9D5103821
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:17 +0200 (CEST)
Received: by wwb13 with SMTP id 13so187430wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:15 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is the second part of the multi-component series and focuses on the changes required to support ASoC multi-component on CODEC drivers.

I've split the CODEC driver patches into smaller chunks and tried to group (where possible) similar CODECs together. All the patches will be rebased together at upstream time so we don't break bisect.

Most CODEC drivers were extremely straight forward with changes limited to their probe() and remove() sections. Some CODECs did require a little extra work and this is marked in their commit messages.

Thanks

Liam
