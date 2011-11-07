From: Daniel Mack <zonque@gmail.com>
Subject: Swapped channels issue on pxa-ssp based platforms
Date: Mon, 07 Nov 2011 18:40:12 +0100
Message-ID: <4EB817FC.4000905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2FED244A6
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2011 18:40:32 +0100 (CET)
Received: by faaa20 with SMTP id a20so843545faa.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2011 09:40:31 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,

we're hunting a weird bug on PXA3xx/ssp based audio devices which causes 
the playback channels to be swapped when the capture stream is started 
at the same time. Content for the left channel appears on the right and 
vice versa, in approximately 50% of all test runs of the following command:

   $ arecord -f cd - -D hw:0,0  | aplay -D hw:0,0  -f cd -

When just aplay is used, everything's fine.

It's unrelated to the codec part, as we see this with machines that 
feature different models. I guess this is some sort of a race condition 
in the stream startup, and suspected sound/soc/pxa/pxa-ssp.c to lack 
some locking, so I added a spinlock around all register 
read-modify-write cycles. But that doesn't seem to be the reason.

It could also be the DMA engine that writes to the wrong position, but I 
fail to see it right now.

Does anyone have an idea where to look for the culprit? Have there been 
similar effects in other SoC platforms?

Thanks for sharing your thoughts :)


Daniel
