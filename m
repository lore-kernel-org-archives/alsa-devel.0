From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
 protection mode
Date: Wed, 21 Mar 2012 10:21:08 +0200
Message-ID: <4F698F74.30002@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com>
	<CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
	<4F68D898.5080606@bitmer.com>
	<CA+7tXigvqY19SPCajY2awV9rJRkTh33H8cO+FZ+Un0uK1f9voA@mail.gmail.com>
	<4F698A02.1070306@ti.com> <4F698DAC.7060503@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id C6F921043E5
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:21:24 +0100 (CET)
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so741760lag.31
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 01:21:11 -0700 (PDT)
In-Reply-To: <4F698DAC.7060503@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2012 10:13 AM, Jarkko Nikula wrote:
> Oh yes. I guess start_threshold is not even known yet when we are ruling
> the buffer size so we cannot use it as a source for alternative rules?

We do place rule for the buffer size, so it is guarantied that it is
bigger than the FIFO.
Start threshold is set by the application, and it is not really
guarantied when the application will set it. It can be runtime changes
as well - being sw_param. In most case overwriting in pcm_prepare phase
might work, but it is not guarantied.

Not sure, but what would be probably useful here is to have a way from
the driver level to let userspace/ALSA know that we should use this and
that start_threshold.
If application does not care ALSA would use this driver provided
information. If application specifies the start_threshold, we should
obey it. In this case the period size would be needed to have the
constraint, but we do not know beforehand what application wants to do.

-- =

P=E9ter
