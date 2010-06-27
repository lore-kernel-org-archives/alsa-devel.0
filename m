From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 00/15] ASoC: multi-component - Platform Drivers
Date: Sun, 27 Jun 2010 12:51:59 +0100
Message-ID: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BE32C103844
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:28 +0200 (CEST)
Received: by wwb13 with SMTP id 13so934011wwb.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:27 -0700 (PDT)
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

This is the third and final part of the ASoC multi-component series and
focuses on the SoC Platform support.

I've split the patches by SoC architecture and again all will be rebased later
to avoid breaking git bisect.

Most platform drivers were quite straight forward with most changes in the
probe() and remove() areas. However, the Samsung and i.MX platform did require
some extra work to decouple some of the components.

Thanks

Liam
