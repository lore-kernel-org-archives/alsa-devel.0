From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Hook wm_hubs micbiases up to CLK_SYS
Date: Tue, 22 Feb 2011 09:27:58 +0000
Message-ID: <1298366878.3353.8.camel@odin>
References: <1298070531-11251-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 967B81038AF
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:28:02 +0100 (CET)
Received: by wwe15 with SMTP id 15so6807433wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:28:02 -0800 (PST)
In-Reply-To: <1298070531-11251-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2011-02-18 at 15:08 -0800, Mark Brown wrote:
> The microphone detection functionality requires a clock to work. In any
> non-detection case where the MICBIAS is enabled CLK_SYS will be needed
> anyway so there is no negative impact on power consumption.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
