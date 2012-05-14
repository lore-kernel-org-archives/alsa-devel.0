From: Patrick Lai <plai@codeaurora.org>
Subject: Problem with snd_soc_suspend
Date: Sun, 13 May 2012 23:30:29 -0700
Message-ID: <4FB0A685.3040408@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 90789103B65
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 08:30:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The CODEC I am working on has multiple digital audio interfaces included
in multiple DAI-LINks. DAILINK X has ignore_suspend flag set and
DAILINK Y has ignore_suspend flag cleared. The problem I encountered is
that as system attempts to enter suspend while DAILINK X is active,
snd_soc_suspend() calls snd_soc_dapm_stream_event(
SND_SOC_DAPM_STREAM_SUSPEND) on inactive DAILINK Y since DAILINK Y
ignore flag is not set. Consequently, CODEC widgets get powered off
even though they should remain powered for DAILINK X.
Kernel version I am working with is 3.0.

Couple questions with respect to this problem

1. Should soc-core check if CODEC DAI is active beside checking
ignore_suspend flag before calling snd_soc_dapm_stream_event()?
I checked latest soc-core.c from kernel 3.4 RC7. The logic is the same
as 3.0

2. Even if snd_soc_dapm_stream_event() is called, DAPM should not power
off widgets that are powered up for DAILINK x.  It seems like DAPM has
the logic to only power off AIF widget if stream name of widget matches
CODEC DAI stream name in soc_dapm_stream_event(). I have not gotten
time to debug this problem further. However, is it a known bug on
kernel 3.0. If so, has the problem been addressed in more recent kernel?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
