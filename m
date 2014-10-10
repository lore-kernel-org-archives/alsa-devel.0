From: Sergej Sawazki <ssawazki@gmx.de>
Subject: ASoC machine driver: how to configure supported frame
 rates?
Date: Fri, 10 Oct 2014 18:12:09 +0200
Message-ID: <54380559.7030807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id BEACF261A5A
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 18:12:10 +0200 (CEST)
Received: from [192.168.178.39] ([92.204.8.217]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lt1S6-1YJDw81dgg-012UVt for
 <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 18:12:10 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

I'm writing an ALSA SoC machine driver. The codec on my board, as well
as the cpu do support the following rates: SNDRV_PCM_RATE_8000_192000

However, the codec, as well as the cpu are clock slaves and the clocks
are fixed. Hence, my board does only support the 96kHz sample rate.

Can someone give me some advice on how to tell ALSA that my board does
only support the rate SNDRV_PCM_RATE_96000?
I don't want to modify the codec and the platform driver.

Any help would be highly appreciated.  Thanks!

 - Sergej
