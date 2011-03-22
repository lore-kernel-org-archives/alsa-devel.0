From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: Support download of WM8958 MBC
 firmware
Date: Tue, 22 Mar 2011 18:16:44 +0000
Message-ID: <1300817804.3356.15.camel@odin>
References: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EB17424447
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 19:16:48 +0100 (CET)
Received: by wwj40 with SMTP id 40so7238539wwj.20
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:16:48 -0700 (PDT)
In-Reply-To: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2011-03-22 at 17:51 +0000, Mark Brown wrote:
> Allow userspace to supply an update to the ROM firmware. The firmware
> request is non-blocking so userspace can load the firmware at its
> leisure without delaying startup, the driver will begin using the
> firmware the next time MBC is started after it has been supplied.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@ti.com>
