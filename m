From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/3] new support for ad1938 codec
Date: Thu, 16 Jul 2009 16:00:04 +0800
Message-ID: <1247731207-26743-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 72F5C24631
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 09:58:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam&Mark,
The following series add support for ad1938 codec

*PATCH 1: ad1938 codec driver

*PATCH 2: blackfin I2S(in TDM mode) DAI driver
Even though TDM mode can be as part of I2S DAI, but there are so much
difference in configuration and data flow,
it's very ugly to integrate I2S and TDM into a module. So we use the DAI
type, but split normal I2S and TDM into individual files.

*PATCH 3: board driver to connect bf5xx with ad1938

--
Thanks,
Barry
