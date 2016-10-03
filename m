From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH 0/5] ASoC: tas571x: fix of several issues for
	TAS5717
Date: Mon,  3 Oct 2016 16:40:45 +0200
Message-ID: <1475505650-8572-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep23.mx.upcmail.net (fep23.mx.upcmail.net [62.179.121.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A033266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:41:07 +0200 (CEST)
Received: from edge01.upcmail.net ([192.168.13.236]) by viefep23-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20161003144107.FDMN3040.viefep23-int.chello.at@edge01.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 3 Oct 2016 16:41:07 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

An extensive usage of the TAS571x driver with the TAS5717 chip revealed several
issues which in the first place caused audio to fail to play. This set of
one-line and trivial patches fixes them. 

The issues were:
* improper handling of the power-down signal
* some timings not obeyed
* bias level not saved in the driver
* channel mixer volume controls in the wrong chip structure ;-)

Petr Kulhavy (5):
  ASoC: tas571x: fix missing bias save level
  ASoC: tas571x: extend the t_i2c time to comply with TAS5721
  ASoC: tas571x: remove improper PDN signal usage in set_bias_level
  ASoC: tas571x: wait 50ms after oscillator trim
  ASoC: tas571x: move mixer volume controls from TAS5711 to TAS5717

 sound/soc/codecs/tas571x.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

-- 
2.7.4
