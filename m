From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add trace events for jack detection
Date: Mon, 06 Dec 2010 12:35:27 +0000
Message-ID: <1291638927.3281.28.camel@odin>
References: <1291552104-22230-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B537224152
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:35:30 +0100 (CET)
Received: by wwc33 with SMTP id 33so3783558wwc.20
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 04:35:30 -0800 (PST)
In-Reply-To: <1291552104-22230-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-12-05 at 12:28 +0000, Mark Brown wrote:
> As jack detection can trigger DAPM and the latency in debouncing can create
> confusing windows in operation provide some trace events which will hopefully
> help in diagnostics. The soc-jack core traces all reports that it gets and
> the resulting notifications to upper layers. An event for jack IRQs is also
> provided for instrumentation of debounce, and used in the GPIO jack code.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
