From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Run-time CODEC reset
Date: Sun, 13 Nov 2011 07:29:05 +0100
Message-ID: <201111130729.05961.marek.vasut@gmail.com>
References: <4EBF6081.8030907@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B033C24737
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 07:29:08 +0100 (CET)
Received: by faaa20 with SMTP id a20so5076488faa.38
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 22:29:08 -0800 (PST)
In-Reply-To: <4EBF6081.8030907@codeaurora.org>
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
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> Hi,
> 
> I have a use case which requires CODEC to be reset at run-time. As
> application exercises playback/capture through PCM device and mixer, my
> understanding is that there is no interface for application to reset
> CODEC through ALSA ASoC framework. CODEC driver would have to build
> non-standard interface for this purpose. Is there precedence in any of
> asoc CODEC driver which provides reset interface?

Why not describe the hardware / submit a patch to support the hardware first ? 
Then you can ask the developers for help. You can be helped more if you share 
your problematic code.

M
