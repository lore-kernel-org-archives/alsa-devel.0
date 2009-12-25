From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/3] ad1836/ad1938: PM and typo fix/cleanup
Date: Fri, 25 Dec 2009 14:10:05 +0800
Message-ID: <1261721408-16248-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C11D103801
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 07:10:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
The following 3 patches fix/cleanup PM and typo of ad1836/ad1938 codec driver:

1. ad1836: reset and restore clock control mode in suspend/resume entry 
2. ad1938: fix typo, rename mask to rx_mask for ad1938_set_tdm_slot
3. ad1938:let soc-core dapm handle PLL power

As I will send patches special for moving to soc-cache, in patch 1, I still use
the old way to read/write codec registers.

Thanks
Barry
