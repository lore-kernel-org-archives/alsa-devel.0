From: Daniel Mack <zonque@gmail.com>
Subject: Sharing PXA SSP ports
Date: Wed, 22 Jun 2011 14:44:10 +0200
Message-ID: <BANLkTikxz95HyKt0+0gjeByNah0-N+vBLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id A6310246C3
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 14:44:11 +0200 (CEST)
Received: by pzk26 with SMTP id 26so513269pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 05:44:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The current API for requesting an SSP port on PXA platforms assumes
that the caller of pxa_ssp_request() is the only user of this port, so
both input and output streams must be implemented in the same driver.

In a new setup I'm working on, this is not sufficient as we connect
one codec to the input stream and another one to the output stream of
the same CPU DAI "pxa-ssp-dai.0". I'm currently using a hack that
disables the use count check in pxa_ssp_request(), but I certainly
need a cleaner solution.

What would be a good approach? Would we need a multiplexer for this
hardware bus, or can we extend the DAI driver in any clever way to
achieve that? Or is there a solution already I just don't know about?


Thanks,
Daniel
