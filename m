From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/3] Few patches to recent OMAP McBSP and ASoC
	changes
Date: Sun, 23 Aug 2009 12:24:24 +0300
Message-ID: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A352414A
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 11:22:58 +0200 (CEST)
Received: by ewy20 with SMTP id 20so1848295ewy.46
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2009 02:22:58 -0700 (PDT)
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
Cc: tony@atomide.com, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi

I would like to add these tree patches to recent set:

[PATCHv5 00/20] OMAP ASoC changes in DMA utilization
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020619.html

These are actually independent patches but probably easier to handle as with
the set above since some of the patches are touching both ASoC and OMAP
subsystems. First patch is the most important since it changes the user space
API for McBSP DMA operating mode selection. It would be more difficult to
change it later if software starts to use current numeric value based
operating mode selection in sysfs files.


-- 
Jarkko
