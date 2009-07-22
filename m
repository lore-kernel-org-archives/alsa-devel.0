From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/2]blackfin TDM dai and blackfin-ad1938
	machine driver
Date: Thu, 23 Jul 2009 02:10:32 +0800
Message-ID: <1248286234-6053-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 474B324493
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 20:10:47 +0200 (CEST)
Received: by ewy22 with SMTP id 22so429720ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2009 11:10:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
The following two patches are the 2nd version for the "new support for
ad1938 codec" patch sequence. Since you have applied the codec driver
patch([PATCH 1/3] new ad1938 codec driver based on asoc), here I only
send the DAI and Board driver patches again according to your feedback.
Patch 1:
blackfin I2S(TDM mode) CPU DAI driver
Patch 2:
board driver to connect bf5xx with ad1938

Detailed description about every patch and changes is included in the
corresponding patch.
Thanks
Barry
