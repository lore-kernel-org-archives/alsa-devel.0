From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/2] TLV320AIC3X MCLK and rate updates
Date: Wed, 20 Feb 2008 15:23:43 +0200
Message-ID: <1203513825-17158-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 462502434B
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 14:23:57 +0100 (CET)
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
Cc: Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org


Hi

Two patches to TLV320AIC3X SoC codec driver. First one fixes typo (?) 
for 64 kHz sample rate and second one adds support to 12 MHz MCLK used
e.g. in Nokia N810 Internet Tablet.

Patches are generated from 2.6.25-rc2-omap1 tree but they apply to alsa git
and alsa-kernel hg trees as well.


-- 
Jarkko
