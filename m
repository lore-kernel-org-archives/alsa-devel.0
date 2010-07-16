From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: ASoC DaVinci voicecodec based on copyfromuser
Date: Fri, 16 Jul 2010 16:46:56 +0200
Message-ID: <1279291619-5081-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F2AA9103806
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 16:47:05 +0200 (CEST)
Received: by wyf19 with SMTP id 19so1911639wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2010 07:47:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

In dm365 cpu it is not possible to run CQ93VC Voice Codec together with
McBSP I2S peripheral, because they share the same dma event.
With this patchset it is possible to run the CQ93VC Voice Codec using
copyfromuser.
