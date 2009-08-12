From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/3] patch sequence adds analog devices ad1836
	asoc support
Date: Wed, 12 Aug 2009 12:32:51 +0800
Message-ID: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9352324DD5
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 06:31:06 +0200 (CEST)
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
The patch sequence adds ad1836 support based on asoc

patch 1:
new ad1836 codec driver based on asoc 

patch 2:
add set_tdm_slot entry in tdm-dai to define the relationship between audio channel and tdm slot number

patch 3:
new board driver to connect ad1836 codec and bf5xx

patch 3 depends on patch 2.

Thanks
Barry
