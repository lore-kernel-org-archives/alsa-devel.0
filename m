From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/4] extend ad1938 codec/machine driver to
	ad193x supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 16:16:57 +0800
Message-ID: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 178C52458C
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 09:18:07 +0100 (CET)
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
The following patch series extends ad1938 codec/machine driver to support ad193x(including ad1936/ad1937/ad1938/ad1939).
Some codecs use i2c bus and others use spi bus.
patch 1: extend ad1938 codec driver to ad193x supporting ad1936/7/8/9
patch 2: change bf5xx-ad1938 machine driver to bf5xx-ad193x machine driver
patch 3: soc-cache: add i2c read entry for 8_8 mode
patch 4: soc-cache: let reg be AND'ed by 0xff instead of data buffer for 8_8 mode

Thanks
Barry
