From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 21:20:56 +0200
Message-ID: <4F68D898.5080606@bitmer.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>	<4F68AE51.808@bitmer.com>
	<CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id C1A91104371
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 20:21:01 +0100 (CET)
In-Reply-To: <CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 06:42 PM, Grazvydas Ignotas wrote:
> This is what we have in pandora tree now:
> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=pandora-kernel.git;a=commitdiff;h=d494977441ac8f99d094b5e03398cb33a14e832a
> Seems to work well for everything here.
> 
To me this looks more like a correct fix. At quick test I got single
xrun when starting up but not endless loop of them. Maybe need to tune a
bit with CONFIG_SND_PCM_XRUN_DEBUG=y.

As a reference here are the test cases from you and Peter:

Nok:
aplay -D hw:0 -f s16_le -c 2 --period-size=512 --start-delay=50000
/dev/urandom

Ok:
aplay -D hw:0 -fs16_le -c2 --period-size=320 --buffer-size=972 \
--start-delay=81000 -v /dev/urandom

Nok:
aplay -D hw:0 -fs16_le -c2 --period-size=324 --buffer-size=972 \
--start-delay=81000 -v /dev/urandom

-- 
Jarkko
